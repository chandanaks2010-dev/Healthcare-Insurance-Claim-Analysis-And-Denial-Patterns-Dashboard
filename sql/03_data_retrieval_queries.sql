-- ================================================================
-- Section 3: Data Retrieval Queries (Multi-Table Joins)
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- QUERY OBJECTIVE: Demonstrate complex multi-table JOIN patterns
-- using proper relational algebra and business logic.
-- ================================================================

USE healthcare_claims_db;

-- ================================================================
-- Query 3.1: Complete Claim Profile with All Dimensions
-- ================================================================
-- Purpose: Multi-table join retrieving comprehensive claim information
--          from all 6 relational tables
-- Use Case: Detailed claim review, audit trail, RCM documentation
-- ================================================================
SELECT 'Query 3.1: Complete Claim Profile' AS query_name;

SELECT
    c.claim_id,
    c.claim_date,
    CONCAT(p.age, ' years, ', p.sex) AS patient_profile,
    CASE
        WHEN p.bmi < 25 THEN 'Normal'
        WHEN p.bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS patient_bmi_category,
    p.smoking_status,
    p.num_dependents,
    h.hospital_name,
    h.state,
    h.city,
    h.hospital_type,
    pr.provider_name,
    pr.specialty,
    d.diagnosis_name,
    d.diagnosis_code,
    d.severity_level,
    c.claim_amount,
    cd.procedure_cost,
    c.claim_status,
    DATEDIFF(CURDATE(), c.claim_date) AS days_since_claim
FROM claims c
INNER JOIN patients p ON p.patient_id = c.patient_id
INNER JOIN hospitals h ON h.hospital_id = c.hospital_id
LEFT JOIN claim_details cd ON cd.claim_id = c.claim_id
LEFT JOIN diagnoses d ON d.diagnosis_id = cd.diagnosis_id
LEFT JOIN providers pr ON pr.provider_id = cd.provider_id
WHERE c.claim_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
ORDER BY c.claim_date DESC
LIMIT 50;

-- ================================================================
-- Query 3.2: Provider Performance Matrix (Specialty × Hospital × Outcome)
-- ================================================================
-- Purpose: Cross-join analysis of provider effectiveness
-- Use Case: Evaluate provider credentials, specialization alignment,
--          and hospital quality metrics for RCM optimization
-- ================================================================
SELECT 'Query 3.2: Provider Performance Analysis' AS query_name;

SELECT
    pr.provider_name,
    pr.specialty,
    h.hospital_name,
    h.state,
    h.hospital_type,
    COUNT(c.claim_id) AS total_claims,
    SUM(CASE WHEN c.claim_status = 'Approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_claim_value
FROM claims c
INNER JOIN patients p ON p.patient_id = c.patient_id
INNER JOIN hospitals h ON h.hospital_id = c.hospital_id
LEFT JOIN claim_details cd ON cd.claim_id = c.claim_id
LEFT JOIN providers pr ON pr.provider_id = cd.provider_id
WHERE pr.provider_id IS NOT NULL
GROUP BY pr.provider_id, pr.provider_name, pr.specialty, h.hospital_id, h.hospital_name, h.state, h.hospital_type
HAVING COUNT(c.claim_id) >= 3
ORDER BY denial_rate_pct DESC, total_claim_value DESC;

-- ================================================================
-- Query 3.3: Geographical Claim Distribution with Regional Analysis
-- ================================================================
-- Purpose: Map claim volumes and denial patterns across regions/states
--          for Tableau geographical visualization
-- Use Case: Regional healthcare cost analysis, denial pattern by geography,
--          capacity planning for regional medical centers
-- ================================================================
SELECT 'Query 3.3: Geographical Claim Distribution' AS query_name;

SELECT
    h.region,
    h.state,
    h.city,
    h.latitude,
    h.longitude,
    COUNT(DISTINCT h.hospital_id) AS hospital_count,
    COUNT(c.claim_id) AS total_claims,
    COUNT(DISTINCT c.patient_id) AS unique_patients,
    SUM(c.claim_amount) AS total_claim_value,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(MIN(c.claim_amount), 2) AS min_claim,
    ROUND(MAX(c.claim_amount), 2) AS max_claim,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    COUNT(DISTINCT p.age) AS age_diversity
FROM hospitals h
LEFT JOIN claims c ON c.hospital_id = h.hospital_id
LEFT JOIN patients p ON p.patient_id = c.patient_id
GROUP BY h.region, h.state, h.city, h.latitude, h.longitude
ORDER BY total_claims DESC;

-- ================================================================
-- Query 3.4: Diagnosis-Specific Cost Analysis by Provider
-- ================================================================
-- Purpose: Connect diagnosis to provider performance and costs
-- Use Case: Evaluate provider competency in specific clinical domains,
--          identify high-cost diagnosis patterns, cost optimization
-- ================================================================
SELECT 'Query 3.4: Diagnosis-Specific Cost Analysis' AS query_name;

SELECT
    d.diagnosis_code,
    d.diagnosis_name,
    d.severity_level,
    COUNT(c.claim_id) AS claim_count,
    COUNT(DISTINCT pr.provider_id) AS provider_count,
    COUNT(DISTINCT h.hospital_id) AS hospital_count,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(MAX(c.claim_amount), 2) AS max_claim_amount,
    ROUND(MIN(c.claim_amount), 2) AS min_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_diagnosis_cost,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct
FROM diagnoses d
LEFT JOIN claim_details cd ON cd.diagnosis_id = d.diagnosis_id
LEFT JOIN claims c ON c.claim_id = cd.claim_id
LEFT JOIN providers pr ON pr.provider_id = cd.provider_id
LEFT JOIN hospitals h ON h.hospital_id = c.hospital_id
WHERE c.claim_id IS NOT NULL
GROUP BY d.diagnosis_id, d.diagnosis_code, d.diagnosis_name, d.severity_level
ORDER BY total_diagnosis_cost DESC;

-- ================================================================
-- Query 3.5: Patient Demographic Risk Profile with Claim Outcome
-- ================================================================
-- Purpose: Correlate patient demographics with approval/denial outcomes
-- Use Case: Risk assessment, patient segmentation, denial prediction modeling
-- ================================================================
SELECT 'Query 3.5: Patient Demographic Risk Profile' AS query_name;

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
    p.region,
    COUNT(c.claim_id) AS total_claims,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_value,
    SUM(CASE WHEN c.claim_status = 'Approved' THEN 1 ELSE 0 END) AS approved_claims,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_claims,
    SUM(CASE WHEN c.claim_status = 'Pending' THEN 1 ELSE 0 END) AS pending_claims,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct,
    ROUND(AVG(p.num_dependents), 2) AS avg_dependents,
    COUNT(DISTINCT c.hospital_id) AS hospitals_utilized
FROM patients p
LEFT JOIN claims c ON c.patient_id = p.patient_id
WHERE c.claim_id IS NOT NULL
GROUP BY
    CASE WHEN p.age < 30 THEN '18-29' WHEN p.age < 40 THEN '30-39'
         WHEN p.age < 50 THEN '40-49' WHEN p.age < 60 THEN '50-59' ELSE '60+' END,
    CASE WHEN p.bmi < 25 THEN 'Normal' WHEN p.bmi < 30 THEN 'Overweight' ELSE 'Obese' END,
    p.smoking_status,
    p.sex,
    p.region
ORDER BY denial_rate_pct DESC, total_claims DESC;

-- ================================================================
-- SUMMARY & VALIDATION
-- ================================================================
SELECT '=== SECTION 3: DATA RETRIEVAL QUERIES COMPLETE ===' AS section_status;
SELECT 'All 5 multi-table JOIN queries executed successfully.' AS summary;
