-- ================================================================
-- Section 5: Window Functions for Ranking and Trend Analysis
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- QUERY OBJECTIVE: Advanced analytics using window functions for
-- ranking, running totals, lag/lead analysis, and cumulative metrics.
-- ================================================================

USE healthcare_claims_db;

-- ================================================================
-- Query 5.1: Hospital Cost Ranking with Quartile Classification
-- ================================================================
-- Purpose: Rank hospitals by total claim cost and classify into quartiles
-- Use Case: Hospital network stratification, performance benchmarking
-- Window Functions: RANK, NTILE
-- ================================================================
SELECT 'Query 5.1: Hospital Cost Ranking' AS query_name;

SELECT
    h.hospital_name,
    h.state,
    h.region,
    ROUND(SUM(c.claim_amount), 2) AS total_cost,
    COUNT(c.claim_id) AS claim_count,
    RANK() OVER (ORDER BY SUM(c.claim_amount) DESC) AS cost_rank,
    DENSE_RANK() OVER (ORDER BY SUM(c.claim_amount) DESC) AS cost_dense_rank,
    NTILE(4) OVER (ORDER BY SUM(c.claim_amount) DESC) AS cost_quartile,
    CASE
        WHEN NTILE(4) OVER (ORDER BY SUM(c.claim_amount) DESC) = 1 THEN 'High-Cost'
        WHEN NTILE(4) OVER (ORDER BY SUM(c.claim_amount) DESC) = 2 THEN 'Mid-High-Cost'
        WHEN NTILE(4) OVER (ORDER BY SUM(c.claim_amount) DESC) = 3 THEN 'Mid-Low-Cost'
        ELSE 'Low-Cost'
    END AS cost_tier_label
FROM claims c
JOIN hospitals h ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.hospital_name, h.state, h.region
ORDER BY cost_rank;

-- ================================================================
-- Query 5.2: Sequential Claim Numbering per Patient
-- ================================================================
-- Purpose: Assign sequence numbers to each patient's claims chronologically
-- Use Case: Identify claim patterns, repeat utilization, patient journey mapping
-- Window Functions: ROW_NUMBER, PARTITION BY
-- ================================================================
SELECT 'Query 5.2: Sequential Claim Numbering' AS query_name;

SELECT
    c.claim_id,
    c.patient_id,
    p.age,
    p.sex,
    p.region,
    c.claim_date,
    c.claim_amount,
    c.claim_status,
    ROW_NUMBER() OVER (PARTITION BY c.patient_id ORDER BY c.claim_date) AS claim_sequence,
    LEAD(c.claim_date) OVER (PARTITION BY c.patient_id ORDER BY c.claim_date) AS next_claim_date,
    DATEDIFF(LEAD(c.claim_date) OVER (PARTITION BY c.patient_id ORDER BY c.claim_date), c.claim_date) AS days_to_next_claim
FROM claims c
JOIN patients p ON c.patient_id = p.patient_id
ORDER BY c.patient_id, c.claim_date;

-- ================================================================
-- Query 5.3: Diagnosis Cost Tier Classification (DENSE_RANK)
-- ================================================================
-- Purpose: Classify diagnoses into cost tiers based on average procedure cost
-- Use Case: Diagnosis-based care pathway analysis, cost management
-- Window Functions: DENSE_RANK, PERCENT_RANK
-- ================================================================
SELECT 'Query 5.3: Diagnosis Cost Tier Classification' AS query_name;

SELECT
    d.diagnosis_code,
    d.diagnosis_name,
    d.severity_level,
    ROUND(AVG(cd.procedure_cost), 2) AS avg_procedure_cost,
    ROUND(MAX(cd.procedure_cost), 2) AS max_procedure_cost,
    ROUND(MIN(cd.procedure_cost), 2) AS min_procedure_cost,
    COUNT(cd.claim_id) AS procedure_count,
    DENSE_RANK() OVER (ORDER BY AVG(cd.procedure_cost) DESC) AS cost_tier_rank,
    ROUND(PERCENT_RANK() OVER (ORDER BY AVG(cd.procedure_cost) DESC) * 100, 2) AS cost_percentile,
    CASE
        WHEN DENSE_RANK() OVER (ORDER BY AVG(cd.procedure_cost) DESC) <= 2 THEN 'Tier 1 - Expensive'
        WHEN DENSE_RANK() OVER (ORDER BY AVG(cd.procedure_cost) DESC) <= 4 THEN 'Tier 2 - Moderate'
        ELSE 'Tier 3 - Economical'
    END AS cost_tier_label
FROM claim_details cd
JOIN diagnoses d ON d.diagnosis_id = cd.diagnosis_id
GROUP BY d.diagnosis_id, d.diagnosis_code, d.diagnosis_name, d.severity_level
ORDER BY cost_tier_rank;

-- ================================================================
-- Query 5.4: Month-over-Month Trend Analysis with LAG/LEAD
-- ================================================================
-- Purpose: Calculate monthly cost trends and percent changes
-- Use Case: Financial forecasting, trend analysis, anomaly detection
-- Window Functions: LAG, LEAD, FIRST_VALUE, LAST_VALUE
-- ================================================================
SELECT 'Query 5.4: Month-over-Month Trend Analysis' AS query_name;

WITH monthly_costs AS (
    SELECT
        DATE_FORMAT(c.claim_date, '%Y-%m') AS claim_month,
        YEAR(c.claim_date) AS fiscal_year,
        MONTH(c.claim_date) AS fiscal_month,
        COUNT(c.claim_id) AS monthly_claims,
        ROUND(SUM(c.claim_amount), 2) AS monthly_total,
        ROUND(AVG(c.claim_amount), 2) AS monthly_avg
    FROM claims c
    GROUP BY DATE_FORMAT(c.claim_date, '%Y-%m'), YEAR(c.claim_date), MONTH(c.claim_date)
)
SELECT
    claim_month,
    fiscal_year,
    fiscal_month,
    monthly_claims,
    monthly_total,
    monthly_avg,
    LAG(monthly_total) OVER (ORDER BY claim_month) AS previous_month_total,
    LEAD(monthly_total) OVER (ORDER BY claim_month) AS next_month_total,
    ROUND(((monthly_total - LAG(monthly_total) OVER (ORDER BY claim_month)) /
           NULLIF(LAG(monthly_total) OVER (ORDER BY claim_month), 0)) * 100, 2) AS mom_pct_change,
    ROUND((monthly_total - FIRST_VALUE(monthly_total) OVER (ORDER BY claim_month)) /
          FIRST_VALUE(monthly_total) OVER (ORDER BY claim_month) * 100, 2) AS ytd_pct_change
FROM monthly_costs
ORDER BY claim_month;

-- ================================================================
-- Query 5.5: PARETO ANALYSIS - Cumulative Cost Distribution by Hospital
-- ================================================================
-- Purpose: Identify "vital few" hospitals driving majority of costs (80/20 rule)
-- Use Case: Budget prioritization, strategic focus areas, resource allocation
-- Window Functions: SUM OVER (ORDER BY), ROW_NUMBER with ranking
-- ================================================================
-- CONCRETE EXAMPLE FROM PLAN.MD:
-- Demonstrates cumulative percentage calculation using running sums
-- to identify which hospitals account for 80% of total healthcare costs
-- ================================================================
SELECT 'Query 5.5: PARETO ANALYSIS - Cumulative Cost Distribution' AS query_name;

WITH hospital_costs AS (
    SELECT
        h.hospital_id,
        h.hospital_name,
        h.state,
        h.region,
        ROUND(SUM(c.claim_amount), 2) AS hospital_total_cost,
        COUNT(c.claim_id) AS hospital_claim_count
    FROM claims c
    JOIN hospitals h ON h.hospital_id = c.hospital_id
    GROUP BY h.hospital_id, h.hospital_name, h.state, h.region
),
ranked_hospitals AS (
    SELECT
        hospital_id,
        hospital_name,
        state,
        region,
        hospital_total_cost,
        hospital_claim_count,
        ROW_NUMBER() OVER (ORDER BY hospital_total_cost DESC) AS cost_rank,
        SUM(hospital_total_cost) OVER (ORDER BY hospital_total_cost DESC) AS running_total_cost,
        SUM(hospital_total_cost) OVER () AS grand_total_cost,
        SUM(hospital_claim_count) OVER (ORDER BY hospital_total_cost DESC) AS running_total_claims
    FROM hospital_costs
)
SELECT
    cost_rank,
    hospital_name,
    state,
    region,
    hospital_total_cost,
    hospital_claim_count,
    running_total_cost,
    grand_total_cost,
    ROUND((running_total_cost / grand_total_cost) * 100, 2) AS cumulative_pct_of_total,
    CASE
        WHEN (running_total_cost / grand_total_cost) <= 0.80 THEN 'Vital Few (0-80%)'
        ELSE 'Useful Many (80-100%)'
    END AS pareto_classification,
    CASE
        WHEN cost_rank <= 5 THEN 'TOP 5'
        WHEN cost_rank <= 10 THEN 'TOP 6-10'
        ELSE 'REMAINING'
    END AS hospital_tier
FROM ranked_hospitals
ORDER BY cost_rank;

-- ================================================================
-- SUMMARY & VALIDATION
-- ================================================================
SELECT '=== SECTION 5: WINDOW FUNCTIONS COMPLETE ===' AS section_status;
SELECT 'All 5 window function queries executed successfully.' AS summary;
SELECT 'Query 5.5 demonstrates PARETO analysis (80/20 rule) for cost concentration.' AS pareto_note;
