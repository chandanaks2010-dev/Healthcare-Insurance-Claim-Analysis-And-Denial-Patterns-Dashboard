-- ================================================================
-- Section 4: Aggregation and Conditional Analysis (GROUP BY, HAVING)
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- QUERY OBJECTIVE: Aggregate data using GROUP BY, HAVING, and
-- conditional expressions for business intelligence reporting.
-- ================================================================

USE healthcare_claims_db;

-- ================================================================
-- Query 4.1: Hospital Performance Scorecard with Regional Analysis
-- ================================================================
-- Purpose: Comprehensive hospital KPI metrics by region
-- Use Case: Hospital network performance management, quality assessment
-- ================================================================
SELECT 'Query 4.1: Hospital Performance Scorecard' AS query_name;

SELECT
    h.region,
    h.state,
    h.city,
    h.hospital_name,
    h.hospital_type,
    h.bed_count,
    COUNT(c.claim_id) AS total_claims,
    COUNT(DISTINCT c.patient_id) AS unique_patients,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_revenue,
    ROUND(MIN(c.claim_amount), 2) AS min_claim,
    ROUND(MAX(c.claim_amount), 2) AS max_claim,
    SUM(CASE WHEN c.claim_status = 'Approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct
FROM hospitals h
LEFT JOIN claims c ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.region, h.state, h.city, h.hospital_name, h.hospital_type, h.bed_count
HAVING COUNT(c.claim_id) > 0
ORDER BY h.region, total_claims DESC;

-- ================================================================
-- Query 4.2: High-Risk Patient Segments Flagged by Denial Pattern
-- ================================================================
-- Purpose: Identify patient demographics with elevated denial rates
-- Use Case: Risk stratification, proactive intervention, denial prevention
-- ================================================================
SELECT 'Query 4.2: High-Risk Patient Segments' AS query_name;

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
    COUNT(c.claim_id) AS claim_volume,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_value,
    ROUND(SUM(c.claim_amount), 2) AS total_claims_value,
    SUM(CASE WHEN c.claim_status = 'Approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    ROUND(SUM(CASE WHEN c.claim_status = 'Denied' THEN c.claim_amount ELSE 0 END), 2) AS total_denied_amount
FROM patients p
LEFT JOIN claims c ON p.patient_id = c.patient_id
WHERE c.claim_id IS NOT NULL
GROUP BY age_group, bmi_category, p.smoking_status, p.sex
HAVING COUNT(c.claim_id) >= 3 AND ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) > 10
ORDER BY denial_rate_pct DESC, claim_volume DESC;

-- ================================================================
-- Query 4.3: Diagnosis Severity Impact on Claims and Costs
-- ================================================================
-- Purpose: Group claims by diagnosis severity to assess cost drivers
-- Use Case: Care pathway optimization, cost containment, quality improvement
-- ================================================================
SELECT 'Query 4.3: Diagnosis Severity Impact Analysis' AS query_name;

SELECT
    d.severity_level,
    d.diagnosis_code,
    d.diagnosis_name,
    COUNT(cd.claim_id) AS claim_count,
    COUNT(DISTINCT cd.claim_id) AS distinct_claims,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_severity_cost,
    ROUND(MAX(c.claim_amount), 2) AS max_claim_amount,
    ROUND(MIN(c.claim_amount), 2) AS min_claim_amount,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim_amount,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    COUNT(DISTINCT pr.specialty) AS provider_specialties_involved
FROM diagnoses d
LEFT JOIN claim_details cd ON d.diagnosis_id = cd.diagnosis_id
LEFT JOIN claims c ON c.claim_id = cd.claim_id
LEFT JOIN providers pr ON pr.provider_id = cd.provider_id
WHERE c.claim_id IS NOT NULL
GROUP BY d.diagnosis_id, d.severity_level, d.diagnosis_code, d.diagnosis_name
ORDER BY total_severity_cost DESC;

-- ================================================================
-- Query 4.4: Regional and Demographic Cross-Tabulation Analysis
-- ================================================================
-- Purpose: Multi-dimensional aggregation of claims by region, sex, smoker status
-- Use Case: Regional health disparities, demographic trends, market analysis
-- ================================================================
SELECT 'Query 4.4: Regional-Demographic Cross-Tabulation' AS query_name;

SELECT
    h.region,
    h.state,
    p.sex,
    p.smoking_status,
    COUNT(c.claim_id) AS claim_count,
    COUNT(DISTINCT c.patient_id) AS patient_count,
    ROUND(AVG(p.age), 1) AS avg_patient_age,
    ROUND(AVG(p.bmi), 1) AS avg_patient_bmi,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_region_sex_cost,
    SUM(CASE WHEN c.claim_status = 'Approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(c.claim_id), 0), 2) AS denial_rate_pct
FROM hospitals h
LEFT JOIN claims c ON h.hospital_id = c.hospital_id
LEFT JOIN patients p ON c.patient_id = p.patient_id
WHERE c.claim_id IS NOT NULL
GROUP BY h.region, h.state, p.sex, p.smoking_status
ORDER BY h.region, denial_rate_pct DESC;

-- ================================================================
-- Query 4.5: Provider Utilization and Denial Patterns
-- ================================================================
-- Purpose: Measure provider workload and claims outcomes
-- Use Case: Provider productivity, quality metrics, referral network optimization
-- ================================================================
SELECT 'Query 4.5: Provider Utilization and Performance' AS query_name;

SELECT
    pr.specialty,
    pr.provider_name,
    h.hospital_name,
    h.state,
    COUNT(cd.claim_id) AS claims_handled,
    COUNT(DISTINCT cd.claim_id) AS distinct_claims,
    COUNT(DISTINCT c.patient_id) AS patient_count,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_value,
    ROUND(SUM(c.claim_amount), 2) AS total_claims_value,
    SUM(CASE WHEN c.claim_status = 'Approved' THEN 1 ELSE 0 END) AS approved_claims,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(c.claim_id), 0), 2) AS denial_rate_pct,
    COUNT(DISTINCT d.diagnosis_code) AS unique_diagnoses_treated
FROM providers pr
LEFT JOIN hospitals h ON pr.hospital_id = h.hospital_id
LEFT JOIN claim_details cd ON pr.provider_id = cd.provider_id
LEFT JOIN claims c ON c.claim_id = cd.claim_id
LEFT JOIN diagnoses d ON d.diagnosis_id = cd.diagnosis_id
WHERE cd.claim_id IS NOT NULL
GROUP BY pr.provider_id, pr.specialty, pr.provider_name, h.hospital_id, h.hospital_name, h.state
HAVING COUNT(cd.claim_id) >= 2
ORDER BY denial_rate_pct DESC, total_claims_value DESC;

-- ================================================================
-- SUMMARY & VALIDATION
-- ================================================================
SELECT '=== SECTION 4: AGGREGATION ANALYSIS COMPLETE ===' AS section_status;
SELECT 'All 5 GROUP BY/HAVING aggregation queries executed successfully.' AS summary;
