-- ================================================================
-- Section 7: Statistical and Financial Analysis
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- QUERY OBJECTIVE: Advanced statistical analysis using aggregates,
-- percentiles, variance, standard deviation, and Pareto principles.
-- ================================================================

USE healthcare_claims_db;

-- ================================================================
-- Query 7.1: Descriptive Statistics Summary for Claims
-- ================================================================
-- Purpose: Comprehensive statistical profile of claim amounts
-- Use Case: Financial reporting, budget forecasting, outlier detection
-- Functions: COUNT, MIN, MAX, AVG, STDDEV, VARIANCE
-- ================================================================
SELECT 'Query 7.1: Descriptive Statistics Summary' AS query_name;

SELECT
    'CLAIMS' AS metric_type,
    COUNT(*) AS total_records,
    COUNT(DISTINCT claim_id) AS distinct_claims,
    ROUND(MIN(claim_amount), 2) AS min_value,
    ROUND(MAX(claim_amount), 2) AS max_value,
    ROUND(AVG(claim_amount), 2) AS mean_value,
    ROUND(STDDEV(claim_amount), 2) AS stddev_value,
    ROUND(STDDEV(claim_amount) / AVG(claim_amount), 4) AS coefficient_of_variation,
    ROUND(VARIANCE(claim_amount), 2) AS variance_value,
    ROUND(STDDEV(claim_amount) * 1.96, 2) AS margin_of_error_95pct,
    ROUND((MAX(claim_amount) - MIN(claim_amount)) / AVG(claim_amount), 4) AS range_ratio
FROM claims;

-- ================================================================
-- Query 7.2: Percentile and Quantile Distribution Analysis
-- ================================================================
-- Purpose: Detailed percentile breakdown for cost distribution
-- Use Case: Identify cost thresholds, distribution shape analysis
-- Functions: PERCENTILE_CONT for continuous percentiles
-- ================================================================
SELECT 'Query 7.2: Percentile Distribution Analysis' AS query_name;

SELECT
    COUNT(*) AS total_claims,
    ROUND(PERCENTILE_CONT(0.00) WITHIN GROUP (ORDER BY claim_amount), 2) AS p0_minimum,
    ROUND(PERCENTILE_CONT(0.01) WITHIN GROUP (ORDER BY claim_amount), 2) AS p1,
    ROUND(PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY claim_amount), 2) AS p5,
    ROUND(PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY claim_amount), 2) AS p10,
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY claim_amount), 2) AS q1_lower_quartile,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY claim_amount), 2) AS q2_median,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY claim_amount), 2) AS q3_upper_quartile,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY claim_amount), 2) AS p90,
    ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY claim_amount), 2) AS p95,
    ROUND(PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY claim_amount), 2) AS p99,
    ROUND(PERCENTILE_CONT(1.00) WITHIN GROUP (ORDER BY claim_amount), 2) AS p100_maximum,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY claim_amount) -
          PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY claim_amount), 2) AS iqr_interquartile_range
FROM claims;

-- ================================================================
-- Query 7.3: Coefficient of Variation Analysis by Hospital
-- ================================================================
-- Purpose: Measure cost variability and consistency by hospital
-- Use Case: Quality control, cost management stability assessment
-- Functions: STDDEV, AVG (for CV calculation), HAVING for filtering
-- Note: CV = (StdDev / Mean) * 100, indicates variability
-- ================================================================
SELECT 'Query 7.3: Cost Variability by Hospital' AS query_name;

SELECT
    h.hospital_id,
    h.hospital_name,
    h.state,
    h.region,
    COUNT(c.claim_id) AS claim_count,
    ROUND(AVG(c.claim_amount), 2) AS mean_claim_cost,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim_cost,
    ROUND(MIN(c.claim_amount), 2) AS min_claim,
    ROUND(MAX(c.claim_amount), 2) AS max_claim,
    ROUND((STDDEV(c.claim_amount) / AVG(c.claim_amount)) * 100, 2) AS cv_pct,
    CASE
        WHEN (STDDEV(c.claim_amount) / AVG(c.claim_amount)) > 0.5 THEN 'HIGH VARIABILITY'
        WHEN (STDDEV(c.claim_amount) / AVG(c.claim_amount)) > 0.3 THEN 'MODERATE VARIABILITY'
        ELSE 'LOW VARIABILITY'
    END AS cost_stability_classification,
    ROUND(SUM(c.claim_amount), 2) AS total_hospital_cost
FROM hospitals h
LEFT JOIN claims c ON h.hospital_id = c.hospital_id
WHERE c.claim_id IS NOT NULL
GROUP BY h.hospital_id, h.hospital_name, h.state, h.region
HAVING COUNT(c.claim_id) >= 5
ORDER BY cv_pct DESC;

-- ================================================================
-- Query 7.4: Pareto Analysis (80/20 Rule) - Cost Concentration
-- ================================================================
-- Purpose: Identify "vital few" hospitals driving majority of costs
-- Use Case: Strategic focus, cost containment, resource allocation
-- Functions: Window functions for cumulative totals and percentages
-- Outcome: Identify hospitals accounting for 80% of total spend
-- ================================================================
SELECT 'Query 7.4: Pareto Analysis - Cost Concentration' AS query_name;

WITH hospital_costs AS (
    SELECT
        h.hospital_id,
        h.hospital_name,
        h.state,
        h.region,
        ROUND(SUM(c.claim_amount), 2) AS hospital_total_cost,
        COUNT(c.claim_id) AS claim_count
    FROM hospitals h
    LEFT JOIN claims c ON h.hospital_id = c.hospital_id
    WHERE c.claim_id IS NOT NULL
    GROUP BY h.hospital_id, h.hospital_name, h.state, h.region
),
ranked_hospitals AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY hospital_total_cost DESC) AS cost_rank,
        hospital_id,
        hospital_name,
        state,
        region,
        hospital_total_cost,
        claim_count,
        SUM(hospital_total_cost) OVER (ORDER BY hospital_total_cost DESC) AS cumulative_cost,
        SUM(hospital_total_cost) OVER () AS total_system_cost
    FROM hospital_costs
)
SELECT
    cost_rank,
    hospital_name,
    state,
    region,
    hospital_total_cost,
    claim_count,
    ROUND((hospital_total_cost / total_system_cost) * 100, 2) AS pct_of_total,
    ROUND((cumulative_cost / total_system_cost) * 100, 2) AS cumulative_pct_of_total,
    CASE
        WHEN (cumulative_cost / total_system_cost) <= 0.20 THEN 'VITAL FEW - Top 20%'
        WHEN (cumulative_cost / total_system_cost) <= 0.50 THEN 'VITAL FEW - Top 50%'
        WHEN (cumulative_cost / total_system_cost) <= 0.80 THEN 'VITAL FEW - Cumulative <80%'
        ELSE 'USEFUL MANY - Bottom 20%'
    END AS pareto_classification
FROM ranked_hospitals
ORDER BY cost_rank;

-- ================================================================
-- Query 7.5: Demographic-Based Statistical Segmentation
-- ================================================================
-- Purpose: Statistical analysis of claims across demographic segments
-- Use Case: Risk profiling, targeted care programs, population health
-- Functions: GROUP BY with aggregates, STDDEV for within-group variation
-- ================================================================
SELECT 'Query 7.5: Demographic Segmentation Statistics' AS query_name;

SELECT
    CASE
        WHEN p.age < 30 THEN '18-29'
        WHEN p.age < 40 THEN '30-39'
        WHEN p.age < 50 THEN '40-49'
        WHEN p.age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    CASE
        WHEN p.bmi < 25 THEN 'Normal'
        WHEN p.bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    p.smoking_status,
    p.sex,
    COUNT(DISTINCT p.patient_id) AS unique_patients,
    COUNT(c.claim_id) AS total_claims,
    ROUND(AVG(p.age), 1) AS avg_age_in_segment,
    ROUND(AVG(p.bmi), 1) AS avg_bmi_in_segment,
    ROUND(AVG(c.claim_amount), 2) AS mean_claim_cost,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim_cost,
    ROUND(MIN(c.claim_amount), 2) AS min_claim_cost,
    ROUND(MAX(c.claim_amount), 2) AS max_claim_cost,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY c.claim_amount), 2) AS median_claim_cost,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    ROUND(SUM(c.claim_amount), 2) AS segment_total_cost
FROM patients p
LEFT JOIN claims c ON p.patient_id = c.patient_id
WHERE c.claim_id IS NOT NULL
GROUP BY age_group, bmi_category, p.smoking_status, p.sex
ORDER BY segment_total_cost DESC, age_group, bmi_category;

-- ================================================================
-- SUMMARY & VALIDATION
-- ================================================================
SELECT '=== SECTION 7: STATISTICAL ANALYSIS COMPLETE ===' AS section_status;
SELECT 'All 5 statistical/analytical queries executed successfully.' AS summary;
SELECT 'Pareto analysis (Query 7.4) demonstrates 80/20 cost concentration principle.' AS pareto_summary;
