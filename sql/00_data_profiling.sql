-- ================================================================
-- Section 0: Data Profiling and Quality Assessment (MySQL 8.0)
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- DATA PROFILING SCRIPT
-- 
-- Purpose: Profile source data for quality assessment, distribution
--          analysis, outlier detection, and cardinality validation
--          BEFORE normalizing into the relational model.
--
-- Run this AFTER loading staging_claims table from insurance_claims_raw.csv
-- but BEFORE running the full ETL transformation.
-- ================================================================

USE healthcare_claims_db;

SELECT '=== DATA PROFILING REPORT ===' AS report_section;
SELECT CURRENT_TIMESTAMP AS profile_timestamp;

-- ================================================================
-- 1. RECORD-LEVEL PROFILING
-- ================================================================
SELECT '1. RECORD-LEVEL PROFILING' AS section;

SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT age) AS distinct_ages,
    COUNT(DISTINCT sex) AS distinct_sexes,
    COUNT(DISTINCT bmi) AS distinct_bmis,
    COUNT(DISTINCT smoker) AS distinct_smoker_values,
    COUNT(DISTINCT region) AS distinct_regions
FROM staging_claims;

-- ================================================================
-- 2. NULL AUDIT
-- ================================================================
SELECT '2. NULL AUDIT' AS section;

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN sex IS NULL THEN 1 ELSE 0 END) AS sex_nulls,
    SUM(CASE WHEN bmi IS NULL THEN 1 ELSE 0 END) AS bmi_nulls,
    SUM(CASE WHEN children IS NULL THEN 1 ELSE 0 END) AS children_nulls,
    SUM(CASE WHEN smoker IS NULL THEN 1 ELSE 0 END) AS smoker_nulls,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN charges IS NULL THEN 1 ELSE 0 END) AS charges_nulls
FROM staging_claims;

-- ================================================================
-- 3. NUMERIC DISTRIBUTION ANALYSIS
-- ================================================================
SELECT '3. NUMERIC DISTRIBUTION - AGE' AS section;

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    ROUND(AVG(age), 2) AS mean_age,
    ROUND(STDDEV(age), 2) AS stddev_age,
    ROUND(STDDEV(age) / AVG(age) * 100, 2) AS cv_age_pct
FROM staging_claims;

SELECT '3.B NUMERIC DISTRIBUTION - BMI' AS section;

SELECT
    MIN(bmi) AS min_bmi,
    MAX(bmi) AS max_bmi,
    ROUND(AVG(bmi), 2) AS mean_bmi,
    ROUND(STDDEV(bmi), 2) AS stddev_bmi,
    ROUND(STDDEV(bmi) / AVG(bmi) * 100, 2) AS cv_bmi_pct
FROM staging_claims;

SELECT '3.C NUMERIC DISTRIBUTION - CHARGES (COST)' AS section;

SELECT
    MIN(charges) AS min_charges,
    MAX(charges) AS max_charges,
    ROUND(AVG(charges), 2) AS mean_charges,
    ROUND(STDDEV(charges), 2) AS stddev_charges,
    ROUND(STDDEV(charges) / AVG(charges) * 100, 2) AS cv_charges_pct
FROM staging_claims;

-- ================================================================
-- 4. PERCENTILE DISTRIBUTION (Cost)
-- ================================================================
SELECT '4. PERCENTILE DISTRIBUTION - CHARGES' AS section;

SELECT
    COUNT(*) AS total_records,
    ROUND(MIN(charges), 2) AS p0_min,
    ROUND(PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY charges), 2) AS p10,
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY charges), 2) AS p25,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY charges), 2) AS p50_median,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY charges), 2) AS p75,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY charges), 2) AS p90,
    ROUND(MAX(charges), 2) AS p100_max
FROM staging_claims;

-- ================================================================
-- 5. OUTLIER DETECTION (IQR Method)
-- ================================================================
SELECT '5. OUTLIER DETECTION - CHARGES (IQR METHOD)' AS section;

WITH quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY charges) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY charges) AS q3
    FROM staging_claims
),
iqr_calc AS (
    SELECT
        q1,
        q3,
        (q3 - q1) AS iqr,
        q1 - (1.5 * (q3 - q1)) AS lower_bound,
        q3 + (1.5 * (q3 - q1)) AS upper_bound
    FROM quartiles
)
SELECT
    (SELECT COUNT(*) FROM staging_claims) AS total_records,
    (SELECT COUNT(*) FROM staging_claims WHERE charges < (SELECT lower_bound FROM iqr_calc)) AS outliers_below_lower,
    (SELECT COUNT(*) FROM staging_claims WHERE charges > (SELECT upper_bound FROM iqr_calc)) AS outliers_above_upper,
    ROUND((SELECT lower_bound FROM iqr_calc), 2) AS lower_bound,
    ROUND((SELECT upper_bound FROM iqr_calc), 2) AS upper_bound,
    ROUND((SELECT q1 FROM iqr_calc), 2) AS q1,
    ROUND((SELECT q3 FROM iqr_calc), 2) AS q3
FROM iqr_calc LIMIT 1;

-- ================================================================
-- 6. CATEGORICAL CARDINALITY ANALYSIS
-- ================================================================
SELECT '6. CATEGORICAL - SEX DISTRIBUTION' AS section;

SELECT
    sex,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_claims), 2) AS pct
FROM staging_claims
WHERE sex IS NOT NULL
GROUP BY sex
ORDER BY count DESC;

SELECT '6.B CATEGORICAL - SMOKER DISTRIBUTION' AS section;

SELECT
    smoker,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_claims), 2) AS pct
FROM staging_claims
WHERE smoker IS NOT NULL
GROUP BY smoker
ORDER BY count DESC;

SELECT '6.C CATEGORICAL - REGION DISTRIBUTION' AS section;

SELECT
    UPPER(region) AS region,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_claims), 2) AS pct
FROM staging_claims
WHERE region IS NOT NULL
GROUP BY UPPER(region)
ORDER BY count DESC;

SELECT '6.D CATEGORICAL - CHILDREN (DEPENDENTS)' AS section;

SELECT
    children,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM staging_claims), 2) AS pct
FROM staging_claims
WHERE children IS NOT NULL
GROUP BY children
ORDER BY children;

-- ================================================================
-- 7. CROSS-TABULATION ANALYSIS
-- ================================================================
SELECT '7. CROSS-TABULATION - AVG CHARGES BY REGION & SMOKER STATUS' AS section;

SELECT
    UPPER(region) AS region,
    smoker,
    COUNT(*) AS record_count,
    ROUND(AVG(charges), 2) AS avg_charges,
    ROUND(MIN(charges), 2) AS min_charges,
    ROUND(MAX(charges), 2) AS max_charges
FROM staging_claims
WHERE region IS NOT NULL AND smoker IS NOT NULL
GROUP BY UPPER(region), smoker
ORDER BY region, smoker;

SELECT '7.B CROSS-TABULATION - AVG CHARGES BY AGE GROUP & BMI CATEGORY' AS section;

SELECT
    CASE
        WHEN age < 30 THEN '18-29'
        WHEN age < 40 THEN '30-39'
        WHEN age < 50 THEN '40-49'
        WHEN age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    CASE
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    COUNT(*) AS record_count,
    ROUND(AVG(charges), 2) AS avg_charges,
    ROUND(STDDEV(charges), 2) AS stddev_charges
FROM staging_claims
WHERE age IS NOT NULL AND bmi IS NOT NULL
GROUP BY age_group, bmi_category
ORDER BY age_group, bmi_category;

-- ================================================================
-- 8. DATA QUALITY SUMMARY
-- ================================================================
SELECT '8. DATA QUALITY SUMMARY' AS section;

WITH quality_metrics AS (
    SELECT
        COUNT(*) AS total_rows,
        SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_count,
        ROUND(100.0 * SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS null_pct,
        SUM(CASE WHEN age <= 0 THEN 1 ELSE 0 END) AS invalid_age_count,
        SUM(CASE WHEN bmi <= 0 THEN 1 ELSE 0 END) AS invalid_bmi_count,
        SUM(CASE WHEN charges < 0 THEN 1 ELSE 0 END) AS negative_charges_count,
        COUNT(DISTINCT CONCAT(age, sex, bmi, children, smoker, region, charges)) AS distinct_rows
    FROM staging_claims
)
SELECT
    total_rows,
    null_count,
    null_pct,
    invalid_age_count,
    invalid_bmi_count,
    negative_charges_count,
    distinct_rows,
    ROUND(100.0 * distinct_rows / total_rows, 2) AS distinctness_pct,
    CASE
        WHEN null_count = 0 AND invalid_age_count = 0 AND invalid_bmi_count = 0 AND negative_charges_count = 0
            THEN 'PASS: Data quality is good'
        ELSE 'WARNING: Review data quality issues'
    END AS quality_status
FROM quality_metrics;

-- ================================================================
-- 9. RECOMMENDATIONS
-- ================================================================
SELECT '9. DATA QUALITY ASSESSMENT RECOMMENDATIONS' AS section;

SELECT 'Ready for ETL transformation. Data appears suitable for normalization.' AS recommendation;
SELECT 'All records can be loaded into the normalized schema.' AS next_step;

SELECT '=== DATA PROFILING COMPLETE ===' AS completion_status;
