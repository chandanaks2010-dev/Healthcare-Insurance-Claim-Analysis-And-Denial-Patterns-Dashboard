-- ================================================================
-- Section 7: Statistical and Financial Analysis
-- Healthcare Insurance Claim Analysis
-- ================================================================

USE healthcare_claims_db;

-- Query 1: Descriptive statistics for claim amounts
SELECT
    COUNT(*) AS total_claims,
    MIN(claim_amount) AS min_cost,
    MAX(claim_amount) AS max_cost,
    ROUND(AVG(claim_amount), 2) AS avg_cost,
    ROUND(STDDEV(claim_amount), 2) AS stddev_cost,
    ROUND(VARIANCE(claim_amount), 2) AS variance_cost
FROM claims;

-- Query 2: Percentile distribution of claim costs
SELECT
    ROUND(PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY claim_amount), 2) AS p10,
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY claim_amount), 2) AS p25,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY claim_amount), 2) AS p50,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY claim_amount), 2) AS p75,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY claim_amount), 2) AS p90
FROM claims;

-- Query 3: Coefficient of variation by hospital
SELECT
    h.hospital_name,
    ROUND(AVG(c.claim_amount), 2) AS mean_cost,
    ROUND(STDDEV(c.claim_amount), 2) AS std_cost,
    ROUND((STDDEV(c.claim_amount) / AVG(c.claim_amount)) * 100, 2) AS cv_pct
FROM claims c
JOIN hospitals h
    ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.hospital_name
HAVING COUNT(c.claim_id) > 5
ORDER BY cv_pct DESC;

-- Query 4: Pareto analysis by hospital
WITH hospital_costs AS (
    SELECT
        h.hospital_name,
        SUM(c.claim_amount) AS total_cost
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
    ROUND(running_total, 2) AS running_total,
    ROUND((running_total / grand_total) * 100, 2) AS cumulative_pct
FROM ranked
ORDER BY total_cost DESC;

-- Query 5: Demographic cost analysis by age and BMI buckets
SELECT
    CASE
        WHEN p.age < 30 THEN '18-29'
        WHEN p.age < 40 THEN '30-39'
        WHEN p.age < 50 THEN '40-49'
        WHEN p.age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    CASE
        WHEN p.bmi < 25 THEN 'Underweight/Normal'
        WHEN p.bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_group,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_cost,
    COUNT(c.claim_id) AS claim_count
FROM patients p
JOIN claims c
    ON c.patient_id = p.patient_id
GROUP BY age_group, bmi_group
ORDER BY age_group, bmi_group;
