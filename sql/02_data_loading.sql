-- ================================================================
-- Section 2: Data Loading and ETL (MySQL 8.0)
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- ETL PROCESS: Raw CSV → Normalized Relational Tables
-- 
-- This script:
-- 1. Loads flat insurance data from CSV into staging table
-- 2. Transforms into 6 normalized tables (3NF)
-- 3. Validates data quality and referential integrity
-- 4. Includes geographical enrichment for Tableau mapping
-- ================================================================

USE healthcare_claims_db;

-- IMPORTANT: MySQL 8.0 security notes
-- If you encounter "ERROR 1290: The MySQL server is running with the --secure-file-priv option",
-- copy the CSV file to the server's approved directory:
-- SHOW VARIABLES LIKE 'secure_file_priv';
-- Common path: C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/

-- ================================================================
-- STEP 1: Create staging table for raw data
-- ================================================================
DROP TABLE IF EXISTS staging_claims;
CREATE TABLE staging_claims (
    age INT,
    sex VARCHAR(20),
    bmi DECIMAL(6,2),
    children INT,
    smoker VARCHAR(20),
    region VARCHAR(30),
    charges DECIMAL(12,2)
) ENGINE=InnoDB;

-- ================================================================
-- STEP 2: Load raw CSV data into staging table
-- ================================================================
-- Adjust the file path based on your secure_file_priv directory.
-- Example for Windows MySQL: C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/insurance_claims_raw.csv
-- Example for Linux: /var/lib/mysql-files/insurance_claims_raw.csv

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/insurance_claims_raw.csv'
INTO TABLE staging_claims
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Validate load
SELECT 'Staging load complete.' AS step;
SELECT COUNT(*) AS staging_row_count FROM staging_claims;

-- ================================================================
-- STEP 3: Populate patients dimension (normalize demographics)
-- ================================================================
-- Deterministic load: one patient record per staging row, in a stable order,
-- so the generated patient_id can be safely mapped to the raw claim record.
-- Use key-based deletes so the script works under MySQL safe update mode.
DELETE FROM claim_details WHERE detail_id > 0;
DELETE FROM claims WHERE claim_id > 0;
DELETE FROM providers WHERE provider_id > 0;
DELETE FROM hospitals WHERE hospital_id > 0;
DELETE FROM patients WHERE patient_id > 0;

DROP TEMPORARY TABLE IF EXISTS ordered_claims;
CREATE TEMPORARY TABLE ordered_claims AS
SELECT
    s.*,
    ROW_NUMBER() OVER (
        ORDER BY s.age, s.bmi, s.sex, s.smoker, s.region, s.children, s.charges
    ) AS source_row_num,
    CASE
        WHEN LOWER(TRIM(s.region)) = 'northwest' THEN 'Northwest'
        WHEN LOWER(TRIM(s.region)) = 'northeast' THEN 'Northeast'
        WHEN LOWER(TRIM(s.region)) = 'southeast' THEN 'Southeast'
        WHEN LOWER(TRIM(s.region)) = 'southwest' THEN 'Southwest'
        WHEN LOWER(TRIM(s.region)) = 'midwest' THEN 'Midwest'
        ELSE 'West'
    END AS normalized_region
FROM staging_claims s;

INSERT INTO patients (age, sex, bmi, smoking_status, region, num_dependents)
SELECT
    o.age,
    CASE
        WHEN LOWER(TRIM(o.sex)) = 'male' THEN 'Male'
        WHEN LOWER(TRIM(o.sex)) = 'female' THEN 'Female'
        ELSE 'Other'
    END AS sex,
    o.bmi,
    CASE WHEN LOWER(TRIM(o.smoker)) = 'yes' THEN 'Yes' ELSE 'No' END AS smoking_status,
    o.normalized_region AS region,
    o.children AS num_dependents
FROM ordered_claims o
ORDER BY o.source_row_num;

SELECT 'Patients dimension populated.' AS step;
SELECT COUNT(*) AS patient_count,
       COUNT(DISTINCT region) AS distinct_regions
FROM patients;

-- ================================================================
-- STEP 4: Populate hospitals dimension with geographical data
-- ================================================================
-- Maps each normalized region to a single representative hospital site.
INSERT INTO hospitals (hospital_name, location, state, city, region, latitude, longitude, hospital_type, bed_count)
SELECT DISTINCT
    CONCAT('Regional Medical Center - ', region_map.region) AS hospital_name,
    region_map.city AS location,
    region_map.state,
    region_map.city,
    region_map.region,
    region_map.lat,
    region_map.lon,
    CASE
        WHEN region_map.region IN ('Northeast', 'Midwest') THEN 'Teaching'
        ELSE 'General'
    END AS hospital_type,
    200 + (ROW_NUMBER() OVER (ORDER BY region_map.region) * 25) AS bed_count
FROM (
    SELECT 'Northwest' AS region, 'Washington' AS state, 'Seattle' AS city, 47.6062 AS lat, -122.3321 AS lon
    UNION ALL SELECT 'Northeast', 'Massachusetts', 'Boston', 42.3601, -71.0589
    UNION ALL SELECT 'Southeast', 'Georgia', 'Atlanta', 33.7490, -84.3880
    UNION ALL SELECT 'Southwest', 'Arizona', 'Phoenix', 33.4484, -112.0742
    UNION ALL SELECT 'Midwest', 'Illinois', 'Chicago', 41.8781, -87.6298
    UNION ALL SELECT 'West', 'California', 'San Francisco', 37.7749, -122.4194
) AS region_map;

SELECT 'Hospitals dimension populated with geographical data.' AS step;
SELECT COUNT(*) AS hospital_count, COUNT(DISTINCT state) AS distinct_states
FROM hospitals;

-- ================================================================
-- STEP 5: Populate diagnoses dimension
-- ================================================================
-- Reference set of common, high-impact diagnosis codes for analytical depth
INSERT INTO diagnoses (diagnosis_name, diagnosis_code, severity_level, avg_treatment_cost)
VALUES
    ('Essential Hypertension', 'I10', 'Moderate', 4200.00),
    ('Type 2 Diabetes Mellitus', 'E11', 'High', 8500.00),
    ('Asthma, Unspecified', 'J45.9', 'Moderate', 3100.00),
    ('Pneumonia, Unspecified', 'J18.9', 'High', 12000.00),
    ('Unspecified Osteoarthritis', 'M15.9', 'Low', 2600.00),
    ('Ischemic Heart Disease', 'I25.9', 'Critical', 18500.00)
ON DUPLICATE KEY UPDATE avg_treatment_cost = VALUES(avg_treatment_cost);

SELECT 'Diagnoses dimension populated.' AS step;
SELECT COUNT(*) AS diagnosis_count FROM diagnoses;

-- ================================================================
-- STEP 6: Populate providers dimension
-- ================================================================
INSERT INTO providers (provider_name, specialty, hospital_id, years_experience)
SELECT
    CONCAT('Dr. ', specialty_lookup.specialty, ' - ', h.hospital_name) AS provider_name,
    specialty_lookup.specialty,
    h.hospital_id,
    3 + MOD(h.hospital_id + specialty_lookup.seq, 20) AS years_experience
FROM hospitals h
CROSS JOIN (
    SELECT 'Cardiology' AS specialty, 1 AS seq
    UNION ALL SELECT 'Orthopedics', 2
    UNION ALL SELECT 'Internal Medicine', 3
    UNION ALL SELECT 'General Practice', 4
) AS specialty_lookup
ORDER BY h.hospital_id, specialty_lookup.seq;

SELECT 'Providers dimension populated.' AS step;
SELECT COUNT(*) AS provider_count,
       COUNT(DISTINCT specialty) AS distinct_specialties
FROM providers;

-- ================================================================
-- STEP 7: Populate claims fact table
-- ================================================================
-- One claim per patient/row, with deterministic status logic and hospital mapping.
INSERT INTO claims (patient_id, claim_date, claim_amount, claim_status, hospital_id)
SELECT
    p.patient_id,
    DATE_ADD('2024-01-01', INTERVAL MOD(o.source_row_num - 1, 365) DAY) AS claim_date,
    o.charges AS claim_amount,
    CASE
        WHEN MOD(o.source_row_num, 10) = 0 THEN 'Denied'
        WHEN MOD(o.source_row_num, 10) = 1 THEN 'Pending'
        ELSE 'Approved'
    END AS claim_status,
    h.hospital_id
FROM ordered_claims o
JOIN patients p
    ON p.patient_id = o.source_row_num
JOIN hospitals h
    ON h.region = o.normalized_region;

SELECT 'Claims fact table populated.' AS step;
SELECT COUNT(*) AS claim_count FROM claims;
SELECT
    claim_status,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM claims), 2) AS pct
FROM claims
GROUP BY claim_status;

-- ================================================================
-- STEP 8: Populate claim_details bridge table
-- ================================================================
-- Deterministic one-detail-per-claim mapping to a diagnosis and provider.
INSERT INTO claim_details (claim_id, diagnosis_id, provider_id, procedure_cost, service_date)
SELECT
    c.claim_id,
    d.diagnosis_id,
    pr.provider_id,
    CASE
        WHEN c.claim_amount < 3000 THEN 1100.00
        WHEN c.claim_amount < 8000 THEN 2500.00
        WHEN c.claim_amount < 15000 THEN 6500.00
        ELSE 12000.00
    END AS procedure_cost,
    c.claim_date AS service_date
FROM claims c
JOIN diagnoses d
    ON d.diagnosis_id = MOD(c.claim_id, 6) + 1
JOIN providers pr
    ON pr.hospital_id = c.hospital_id
   AND pr.specialty = CASE
        WHEN MOD(c.claim_id, 4) = 0 THEN 'Cardiology'
        WHEN MOD(c.claim_id, 4) = 1 THEN 'Orthopedics'
        WHEN MOD(c.claim_id, 4) = 2 THEN 'Internal Medicine'
        ELSE 'General Practice'
    END;

SELECT 'Claim details bridge populated.' AS step;
SELECT COUNT(*) AS detail_count FROM claim_details;

-- ================================================================
-- FINAL ETL VALIDATION
-- ================================================================
SELECT 'ETL validation complete.' AS status;
SELECT
    (SELECT COUNT(*) FROM patients) AS patient_count,
    (SELECT COUNT(*) FROM hospitals) AS hospital_count,
    (SELECT COUNT(*) FROM diagnoses) AS diagnosis_count,
    (SELECT COUNT(*) FROM claims) AS claim_count,
    (SELECT COUNT(*) FROM claim_details) AS claim_detail_count;

SELECT
    'Ref integrity check' AS validation_step,
    SUM(CASE WHEN c.patient_id IS NULL THEN 1 ELSE 0 END) AS orphan_claims,
    SUM(CASE WHEN cd.claim_id IS NULL THEN 1 ELSE 0 END) AS orphan_detail_rows
FROM claims c
LEFT JOIN claim_details cd ON cd.claim_id = c.claim_id;


SELECT 'Claim details bridge table populated.' AS step;
SELECT COUNT(*) AS claim_detail_count FROM claim_details;

-- ================================================================
-- VALIDATION & DATA QUALITY CHECKS
-- ================================================================
SELECT '=== ETL VALIDATION REPORT ===' AS validation;

SELECT 'RECORD COUNTS:' AS check_type;
SELECT COUNT(*) AS total_patients FROM patients;
SELECT COUNT(*) AS total_hospitals FROM hospitals;
SELECT COUNT(*) AS total_providers FROM providers;
SELECT COUNT(*) AS total_diagnoses FROM diagnoses;
SELECT COUNT(*) AS total_claims FROM claims;
SELECT COUNT(*) AS total_claim_details FROM claim_details;

SELECT 'NULL AUDIT:' AS check_type;
SELECT 
    SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS patient_nulls,
    SUM(CASE WHEN hospital_id IS NULL THEN 1 ELSE 0 END) AS hospital_nulls,
    SUM(CASE WHEN diagnosis_id IS NULL THEN 1 ELSE 0 END) AS diagnosis_nulls
FROM (
    SELECT patient_id, NULL AS hospital_id, NULL AS diagnosis_id FROM patients UNION ALL
    SELECT NULL, hospital_id, NULL FROM hospitals UNION ALL
    SELECT NULL, NULL, diagnosis_id FROM diagnoses
) x;

SELECT 'REFERENTIAL INTEGRITY:' AS check_type;
SELECT COUNT(*) AS orphaned_claims 
FROM claims c 
WHERE NOT EXISTS (SELECT 1 FROM patients p WHERE p.patient_id = c.patient_id);

SELECT 'GEOGRAPHICAL DATA COVERAGE:' AS check_type;
SELECT 
    COUNT(*) AS total_hospitals,
    COUNT(DISTINCT state) AS distinct_states,
    COUNT(DISTINCT region) AS distinct_regions,
    COUNT(CASE WHEN latitude IS NOT NULL THEN 1 END) AS hospitals_with_coords
FROM hospitals;

SELECT 'ETL LOAD COMPLETE - Ready for analytical queries.' AS final_status;
