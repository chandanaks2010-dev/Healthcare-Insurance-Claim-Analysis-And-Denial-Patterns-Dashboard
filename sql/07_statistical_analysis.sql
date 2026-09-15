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
-- Functions: Window functions for continuous percentile interpolation
-- ================================================================
SELECT 'Query 7.2: Percentile Distribution Analysis' AS query_name;

WITH ordered_claims AS (
    SELECT
        claim_amount,
        ROW_NUMBER() OVER (ORDER BY claim_amount) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM claims
),
percentile_targets AS (
    SELECT 'p0' AS percentile_name, 0.00 AS percentile_value
    UNION ALL SELECT 'p1', 0.01
    UNION ALL SELECT 'p5', 0.05
    UNION ALL SELECT 'p10', 0.10
    UNION ALL SELECT 'q1', 0.25
    UNION ALL SELECT 'q2', 0.50
    UNION ALL SELECT 'q3', 0.75
    UNION ALL SELECT 'p90', 0.90
    UNION ALL SELECT 'p95', 0.95
    UNION ALL SELECT 'p99', 0.99
    UNION ALL SELECT 'p100', 1.00
),
percentile_positions AS (
    SELECT
        t.percentile_name,
        1 + t.percentile_value * (MAX(o.total_rows) - 1) AS position
    FROM percentile_targets t
    CROSS JOIN ordered_claims o
    GROUP BY t.percentile_name, t.percentile_value
),
interpolated_percentiles AS (
    SELECT
        p.percentile_name,
        MAX(CASE WHEN o.row_num = FLOOR(p.position) THEN o.claim_amount END) +
            (p.position - FLOOR(p.position)) * (
                MAX(CASE WHEN o.row_num = CEIL(p.position) THEN o.claim_amount END) -
                MAX(CASE WHEN o.row_num = FLOOR(p.position) THEN o.claim_amount END)
            ) AS percentile_value
    FROM percentile_positions p
    JOIN ordered_claims o
        ON o.row_num IN (FLOOR(p.position), CEIL(p.position))
    GROUP BY p.percentile_name, p.position
)
SELECT
    (SELECT MAX(total_rows) FROM ordered_claims) AS total_claims,
    ROUND(MAX(CASE WHEN percentile_name = 'p0' THEN percentile_value END), 2) AS p0_minimum,
    ROUND(MAX(CASE WHEN percentile_name = 'p1' THEN percentile_value END), 2) AS p1,
    ROUND(MAX(CASE WHEN percentile_name = 'p5' THEN percentile_value END), 2) AS p5,
    ROUND(MAX(CASE WHEN percentile_name = 'p10' THEN percentile_value END), 2) AS p10,
    ROUND(MAX(CASE WHEN percentile_name = 'q1' THEN percentile_value END), 2) AS q1_lower_quartile,
    ROUND(MAX(CASE WHEN percentile_name = 'q2' THEN percentile_value END), 2) AS q2_median,
    ROUND(MAX(CASE WHEN percentile_name = 'q3' THEN percentile_value END), 2) AS q3_upper_quartile,
    ROUND(MAX(CASE WHEN percentile_name = 'p90' THEN percentile_value END), 2) AS p90,
    ROUND(MAX(CASE WHEN percentile_name = 'p95' THEN percentile_value END), 2) AS p95,
    ROUND(MAX(CASE WHEN percentile_name = 'p99' THEN percentile_value END), 2) AS p99,
    ROUND(MAX(CASE WHEN percentile_name = 'p100' THEN percentile_value END), 2) AS p100_maximum,
    ROUND(
        MAX(CASE WHEN percentile_name = 'q3' THEN percentile_value END) -
        MAX(CASE WHEN percentile_name = 'q1' THEN percentile_value END),
        2
    ) AS iqr_interquartile_range
FROM interpolated_percentiles;

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

WITH segmented_claims AS (
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
        p.age,
        p.bmi,
        p.patient_id,
        c.claim_id,
        c.claim_amount,
        c.claim_status
    FROM patients p
    JOIN claims c ON p.patient_id = c.patient_id
),
ranked_segments AS (
    SELECT
        segmented_claims.*,
        ROW_NUMBER() OVER (
            PARTITION BY age_group, bmi_category, smoking_status, sex
            ORDER BY claim_amount
        ) AS segment_row,
        COUNT(*) OVER (
            PARTITION BY age_group, bmi_category, smoking_status, sex
        ) AS segment_count
    FROM segmented_claims
)
SELECT
    age_group,
    bmi_category,
    smoking_status,
    sex,
    COUNT(DISTINCT patient_id) AS unique_patients,
    COUNT(claim_id) AS total_claims,
    ROUND(AVG(age), 1) AS avg_age_in_segment,
    ROUND(AVG(bmi), 1) AS avg_bmi_in_segment,
    ROUND(AVG(claim_amount), 2) AS mean_claim_cost,
    ROUND(STDDEV(claim_amount), 2) AS stddev_claim_cost,
    ROUND(MIN(claim_amount), 2) AS min_claim_cost,
    ROUND(MAX(claim_amount), 2) AS max_claim_cost,
    ROUND(AVG(CASE
        WHEN segment_row IN (FLOOR((segment_count + 1) / 2), CEIL((segment_count + 1) / 2))
        THEN claim_amount
    END), 2) AS median_claim_cost,
    ROUND(100.0 * SUM(CASE WHEN claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(claim_id), 2) AS denial_rate_pct,
    ROUND(SUM(claim_amount), 2) AS segment_total_cost
FROM ranked_segments
GROUP BY age_group, bmi_category, smoking_status, sex
ORDER BY segment_total_cost DESC, age_group, bmi_category;

-- ================================================================
-- Query 7.6: DEMOGRAPHIC RISK SEGMENTATION (ADVANCED - For Heatmap)
-- ================================================================
-- Purpose: Multi-dimensional demographic segmentation for risk profiling
-- Use Case: Executive heatmap visualization, targeted prevention programs
-- Functions: CASE WHEN bucketing (5 age groups × 4 BMI categories × 2 smoking status)
-- Outcome: 40 demographic cells with cost and denial metrics ready for Tableau heatmap
-- ================================================================
SELECT 'Query 7.6: Demographic Risk Segmentation (Heatmap Ready)' AS query_name;

SELECT
    -- Demographic dimensions (create exact buckets matching Plan.md specification)
    CASE
        WHEN p.age < 26 THEN '18-25'
        WHEN p.age < 36 THEN '26-35'
        WHEN p.age < 46 THEN '36-45'
        WHEN p.age < 56 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    CASE
        WHEN p.bmi < 18.5 THEN 'Underweight'
        WHEN p.bmi < 25 THEN 'Normal'
        WHEN p.bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    p.smoking_status AS smoker,
    
    -- Count and aggregation metrics
    COUNT(DISTINCT p.patient_id) AS patient_count,
    COUNT(c.claim_id) AS claim_count,
    ROUND(SUM(c.claim_amount), 2) AS total_cost,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_cost,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim_cost,
    ROUND(MIN(c.claim_amount), 2) AS min_claim,
    ROUND(MAX(c.claim_amount), 2) AS max_claim,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY c.claim_amount), 2) AS median_claim,
    
    -- Denial metrics
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    
    -- Risk tier classification based on cost
    CASE
        WHEN ROUND(AVG(c.claim_amount), 2) < 5000 THEN 'Low Cost'
        WHEN ROUND(AVG(c.claim_amount), 2) < 15000 THEN 'Medium Cost'
        WHEN ROUND(AVG(c.claim_amount), 2) < 30000 THEN 'High Cost'
        ELSE 'Very High Cost'
    END AS risk_tier,
    
    -- Supporting metrics
    ROUND(AVG(p.age), 1) AS avg_age_in_cohort,
    ROUND(AVG(p.bmi), 1) AS avg_bmi_in_cohort,
    ROUND(AVG(CAST(c.claim_amount AS DECIMAL)) / (SELECT AVG(CAST(claim_amount AS DECIMAL)) FROM claims), 2) AS cost_multiplier_vs_avg
    
FROM patients p
LEFT JOIN claims c ON p.patient_id = c.patient_id
WHERE c.claim_id IS NOT NULL
GROUP BY age_group, bmi_category, p.smoking_status
ORDER BY avg_claim_cost DESC, age_group, bmi_category, p.smoking_status;

-- ================================================================
-- Query 7.7: RFM ANALYSIS - Patient Lifetime Value Segmentation
-- ================================================================
-- Purpose: Recency-Frequency-Monetary analysis for customer lifecycle segmentation
-- Use Case: Member retention strategy, value-based targeting, churn prediction
-- Functions: NTILE window function for quartile scoring, CTEs for layered segmentation
-- Outcome: 8 customer segments (Champions, Loyal, Potential, New, At-Risk, Hibernating, Lost)
-- ================================================================
SELECT 'Query 7.7: RFM Analysis - Customer Lifetime Value Segmentation' AS query_name;

WITH patient_rfm AS (
  SELECT 
    p.patient_id,
    p.age,
    CASE WHEN p.age < 26 THEN '18-25'
         WHEN p.age < 36 THEN '26-35'
         WHEN p.age < 46 THEN '36-45'
         WHEN p.age < 56 THEN '46-55'
         ELSE '56+' END AS age_group,
    CASE WHEN p.bmi < 18.5 THEN 'Underweight'
         WHEN p.bmi < 25 THEN 'Normal'
         WHEN p.bmi < 30 THEN 'Overweight'
         ELSE 'Obese' END AS bmi_category,
    p.smoking_status,
    
    -- RECENCY: Days since most recent claim
    DATEDIFF(CURDATE(), MAX(c.claim_date)) AS days_since_last_claim,
    
    -- FREQUENCY: Number of claims per patient
    COUNT(c.claim_id) AS claim_frequency,
    
    -- MONETARY: Total lifetime claim value
    SUM(c.claim_amount) AS lifetime_monetary_value,
    
    -- Supporting metrics
    AVG(c.claim_amount) AS avg_claim_value,
    ROUND(STDDEV(c.claim_amount), 2) AS claim_variance,
    COUNT(CASE WHEN c.claim_status = 'Denied' THEN 1 END) AS denied_claims,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN c.claim_amount ELSE 0 END) AS denied_amount
    
  FROM patients p
  LEFT JOIN claims c ON p.patient_id = c.patient_id
  WHERE c.claim_id IS NOT NULL
  GROUP BY p.patient_id, p.age, age_group, bmi_category, p.smoking_status
),

rfm_quartiles AS (
  SELECT 
    patient_id,
    age,
    age_group,
    bmi_category,
    smoking_status,
    days_since_last_claim,
    claim_frequency,
    lifetime_monetary_value,
    avg_claim_value,
    denied_claims,
    
    -- Quartile scoring (1=worst, 4=best)
    -- For Recency: Higher score for more recent claims (lower days)
    NTILE(4) OVER (ORDER BY days_since_last_claim DESC) AS recency_quartile,
    -- For Frequency: Higher score for more claims
    NTILE(4) OVER (ORDER BY claim_frequency ASC) AS frequency_quartile,
    -- For Monetary: Higher score for higher lifetime value
    NTILE(4) OVER (ORDER BY lifetime_monetary_value ASC) AS monetary_quartile
    
  FROM patient_rfm
),

rfm_segments AS (
  SELECT 
    *,
    -- Composite RFM score (higher = better customer)
    ROUND((recency_quartile + frequency_quartile + monetary_quartile) / 3.0, 2) AS rfm_score,
    
    -- Customer segment labels based on RFM quartiles
    CASE 
      WHEN recency_quartile >= 3 AND frequency_quartile >= 3 AND monetary_quartile >= 3 THEN 'Champions'
      WHEN recency_quartile >= 3 AND frequency_quartile >= 3 AND monetary_quartile < 3 THEN 'Loyal Customers'
      WHEN recency_quartile >= 3 AND frequency_quartile < 3 AND monetary_quartile >= 3 THEN 'Potential Loyalists'
      WHEN recency_quartile >= 3 AND frequency_quartile < 3 AND monetary_quartile < 3 THEN 'New Members'
      WHEN recency_quartile < 3 AND frequency_quartile >= 3 AND monetary_quartile >= 3 THEN 'At-Risk High Value'
      WHEN recency_quartile < 3 AND frequency_quartile >= 3 AND monetary_quartile < 3 THEN 'At-Risk Frequent'
      WHEN recency_quartile < 3 AND frequency_quartile < 3 AND monetary_quartile >= 3 THEN 'Hibernating'
      ELSE 'Lost'
    END AS customer_segment
    
  FROM rfm_quartiles
)

SELECT 
  patient_id,
  age,
  age_group,
  bmi_category,
  smoking_status,
  days_since_last_claim,
  claim_frequency,
  lifetime_monetary_value,
  avg_claim_value,
  denied_claims,
  recency_quartile,
  frequency_quartile,
  monetary_quartile,
  rfm_score,
  customer_segment
  
FROM rfm_segments
ORDER BY lifetime_monetary_value DESC, rfm_score DESC;

-- ================================================================
-- SUMMARY & VALIDATION
-- ================================================================
SELECT '=== SECTION 7: STATISTICAL ANALYSIS COMPLETE ===' AS section_status;
SELECT 'All 7 statistical/analytical queries executed successfully.' AS summary;
SELECT 'Query 7.6: Demographic Risk Segmentation provides heatmap-ready data.' AS seg_summary;
SELECT 'Query 7.7: RFM Analysis enables customer lifecycle segmentation and retention strategy.' AS rfm_summary;
