-- ================================================================
-- Section 5: Window Functions for Ranking and Trend Analysis
-- Healthcare Insurance Claim Analysis
-- ================================================================

USE healthcare_claims_db;

-- Query 1: Hospital cost ranking with ties
SELECT
    h.hospital_name,
    SUM(c.claim_amount) AS total_cost,
    RANK() OVER (ORDER BY SUM(c.claim_amount) DESC) AS cost_rank,
    NTILE(4) OVER (ORDER BY SUM(c.claim_amount) DESC) AS cost_quartile
FROM claims c
JOIN hospitals h
    ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.hospital_name;

-- Query 2: Sequential claim numbering per patient
SELECT
    c.claim_id,
    c.patient_id,
    c.claim_date,
    ROW_NUMBER() OVER (PARTITION BY c.patient_id ORDER BY c.claim_date) AS claim_sequence
FROM claims c
ORDER BY c.patient_id, c.claim_date;

-- Query 3: Diagnosis cost tier classification using DENSE_RANK
SELECT
    d.diagnosis_name,
    d.severity_level,
    AVG(cd.procedure_cost) AS avg_procedure_cost,
    DENSE_RANK() OVER (ORDER BY AVG(cd.procedure_cost) DESC) AS cost_tier_rank
FROM claim_details cd
JOIN diagnoses d
    ON d.diagnosis_id = cd.diagnosis_id
GROUP BY d.diagnosis_id, d.diagnosis_name, d.severity_level
ORDER BY cost_tier_rank;

-- Query 4: Month-over-month cost trend with percent change
WITH monthly_costs AS (
    SELECT
        DATE_FORMAT(c.claim_date, '%Y-%m') AS claim_month,
        ROUND(SUM(c.claim_amount), 2) AS monthly_total
    FROM claims c
    GROUP BY DATE_FORMAT(c.claim_date, '%Y-%m')
)
SELECT
    claim_month,
    monthly_total,
    LAG(monthly_total) OVER (ORDER BY claim_month) AS previous_month_total,
    ROUND(
        ((monthly_total - LAG(monthly_total) OVER (ORDER BY claim_month)) /
        NULLIF(LAG(monthly_total) OVER (ORDER BY claim_month), 0)) * 100,
        2
    ) AS pct_change
FROM monthly_costs
ORDER BY claim_month;

-- Query 5: Running total and cumulative percentage
WITH hospital_costs AS (
    SELECT
        h.hospital_name,
        ROUND(SUM(c.claim_amount), 2) AS total_cost
    FROM claims c
    JOIN hospitals h
        ON h.hospital_id = c.hospital_id
    GROUP BY h.hospital_id, h.hospital_name
),
ranked AS (
    SELECT
        hospital_name,
        total_cost,
        SUM(total_cost) OVER (ORDER BY total_cost DESC) AS running_total,
        SUM(total_cost) OVER () AS grand_total
    FROM hospital_costs
)
SELECT
    hospital_name,
    total_cost,
    running_total,
    ROUND((running_total / grand_total) * 100, 2) AS cumulative_pct_of_total
FROM ranked
ORDER BY total_cost DESC;
