-- ================================================================
-- Healthcare Insurance Claim Analysis — SQL Analytics Script
-- Executive MTech Program | Data Science & AI
-- Database: MySQL 8.0+
-- ================================================================

USE healthcare_claims_db;
-- ================================================================
-- SECTION 8: TABLEAU LIVE DATA VIEW (PREFERRED CONNECTION METHOD)
-- ================================================================
-- Tableau can connect directly to MySQL using a database view instead of
-- importing a CSV every time. This is the recommended live-data approach.
--
-- Tableau connection steps:
-- 1. Open Tableau
-- 2. Connect to MySQL
-- 3. Enter Server, Database = healthcare_claims_db, Username, Password
-- 4. Choose the view named v_claims_tableau
-- 5. Build dashboards from the live data source
--
-- Optional CSV export (fallback only):
-- SELECT *
-- FROM v_claims_tableau
-- INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/claims_analysis.csv'
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n';

DROP VIEW IF EXISTS v_claims_tableau;
CREATE VIEW v_claims_tableau AS
SELECT
    c.claim_id,
    c.claim_date,
    DATE_FORMAT(c.claim_date, '%Y-%m') AS claim_month,
    YEAR(c.claim_date) AS claim_year,
    MONTH(c.claim_date) AS claim_month_num,

    p.patient_id,
    p.age,
    p.sex,
    p.smoking_status,
    p.region,
    p.bmi,
    p.num_dependents,

    h.hospital_id,
    h.hospital_name,
    h.location,
    h.hospital_type,

    pr.provider_id,
    pr.provider_name,
    pr.specialty,

    d.diagnosis_id,
    d.diagnosis_name,
    d.diagnosis_code,
    d.severity_level,

    c.claim_amount,
    c.claim_status,

    CASE
        WHEN c.claim_amount < 3000 THEN 'Low'
        WHEN c.claim_amount < 7000 THEN 'Medium'
        WHEN c.claim_amount < 15000 THEN 'High'
        ELSE 'Very High'
    END AS cost_tier,

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

    CASE
        WHEN c.claim_status = 'Denied' THEN 1
        ELSE 0
    END AS denial_flag
FROM claims c
LEFT JOIN patients p
    ON p.patient_id = c.patient_id
LEFT JOIN hospitals h
    ON h.hospital_id = c.hospital_id
LEFT JOIN claim_details cd
    ON cd.claim_id = c.claim_id
LEFT JOIN diagnoses d
    ON d.diagnosis_id = cd.diagnosis_id
LEFT JOIN providers pr
    ON pr.provider_id = cd.provider_id;

SELECT 'Tableau live view ready: v_claims_tableau.' AS status;
SELECT COUNT(*) AS tableau_live_rows FROM v_claims_tableau;
