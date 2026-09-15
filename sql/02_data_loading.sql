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
INSERT INTO patients (age, sex, bmi, smoking_status, region, num_dependents)
SELECT DISTINCT
    s.age,
    CASE
        WHEN LOWER(TRIM(s.sex)) = 'male' THEN 'Male'
        WHEN LOWER(TRIM(s.sex)) = 'female' THEN 'Female'
        ELSE 'Other'
    END AS sex,
    s.bmi,
    CASE WHEN LOWER(TRIM(s.smoker)) = 'yes' THEN 'Yes' ELSE 'No' END AS smoking_status,
    CASE
        WHEN LOWER(TRIM(s.region)) = 'northwest' THEN 'Northwest'
        WHEN LOWER(TRIM(s.region)) = 'northeast' THEN 'Northeast'
        WHEN LOWER(TRIM(s.region)) = 'southeast' THEN 'Southeast'
        WHEN LOWER(TRIM(s.region)) = 'southwest' THEN 'Southwest'
        WHEN LOWER(TRIM(s.region)) = 'midwest' THEN 'Midwest'
        ELSE 'West'
    END AS region,
    s.children
FROM staging_claims s
ORDER BY s.age, s.bmi, s.region;

SELECT 'Patients dimension populated.' AS step;
SELECT COUNT(*) AS patient_count, 
       COUNT(DISTINCT region) AS distinct_regions 
FROM patients;

-- ================================================================
-- STEP 4: Populate hospitals dimension with geographical data
-- ================================================================
-- Maps regions to US states and cities for Tableau geographical visualization
-- Includes latitude/longitude for enhanced geospatial analysis

INSERT INTO hospitals (hospital_name, location, state, city, region, latitude, longitude, hospital_type, bed_count)
SELECT DISTINCT
    CONCAT('Regional Medical Center - ', p_distinct.region) AS hospital_name,
    p_distinct.city AS location,
    p_distinct.state,
    p_distinct.city,
    p_distinct.region,
    p_distinct.lat,
    p_distinct.lon,
    CASE
        WHEN MOD(SUBSTRING_INDEX(p_distinct.region, ' ', 1), 2) = 0 THEN 'Teaching'
        ELSE 'General'
    END AS hospital_type,
    200 + FLOOR(RAND() * 250) AS bed_count
FROM (
    SELECT DISTINCT
        CASE
            WHEN region = 'Northwest' THEN 'Washington'
            WHEN region = 'Northeast' THEN 'Massachusetts'
            WHEN region = 'Southeast' THEN 'Georgia'
            WHEN region = 'Southwest' THEN 'Arizona'
            WHEN region = 'Midwest' THEN 'Illinois'
            ELSE 'California'
        END AS state,
        CASE
            WHEN region = 'Northwest' THEN 'Seattle'
            WHEN region = 'Northeast' THEN 'Boston'
            WHEN region = 'Southeast' THEN 'Atlanta'
            WHEN region = 'Southwest' THEN 'Phoenix'
            WHEN region = 'Midwest' THEN 'Chicago'
            ELSE 'San Francisco'
        END AS city,
        CASE
            WHEN region = 'Northwest' THEN 47.6062
            WHEN region = 'Northeast' THEN 42.3601
            WHEN region = 'Southeast' THEN 33.7490
            WHEN region = 'Southwest' THEN 33.4484
            WHEN region = 'Midwest' THEN 41.8781
            ELSE 37.7749
        END AS lat,
        CASE
            WHEN region = 'Northwest' THEN -122.3321
            WHEN region = 'Northeast' THEN -71.0589
            WHEN region = 'Southeast' THEN -84.3880
            WHEN region = 'Southwest' THEN -112.0742
            WHEN region = 'Midwest' THEN -87.6298
            ELSE -122.4194
        END AS lon,
        region
    FROM patients
) p_distinct;

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
    CONCAT('Dr_', SUBSTRING_INDEX(p.region, ' ', 1), '_P', p.patient_id) AS provider_name,
    CASE
        WHEN MOD(p.patient_id, 4) = 0 THEN 'Cardiology'
        WHEN MOD(p.patient_id, 4) = 1 THEN 'Orthopedics'
        WHEN MOD(p.patient_id, 4) = 2 THEN 'Internal Medicine'
        ELSE 'General Practice'
    END AS specialty,
    h.hospital_id,
    3 + MOD(p.patient_id, 20) AS years_experience
FROM (
    SELECT DISTINCT p1.patient_id, p1.region
    FROM patients p1
    LIMIT 50  -- Create ~50 providers for realism
) p
JOIN hospitals h ON h.region = p.region;

SELECT 'Providers dimension populated.' AS step;
SELECT COUNT(*) AS provider_count, COUNT(DISTINCT specialty) AS distinct_specialties 
FROM providers;

-- ================================================================
-- STEP 7: Populate claims fact table
-- ================================================================
-- Links patients to claims with appropriate cost tiers and status distribution
INSERT INTO claims (patient_id, claim_date, claim_amount, claim_status, hospital_id)
SELECT
    p.patient_id,
    DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS claim_date,
    s.charges AS claim_amount,
    CASE
        WHEN RAND() < 0.15 THEN 'Denied'
        WHEN RAND() < 0.85 THEN 'Approved'
        ELSE 'Pending'
    END AS claim_status,
    h.hospital_id
FROM staging_claims s
JOIN patients p
    ON p.age = s.age
   AND ABS(p.bmi - s.bmi) < 0.5
   AND p.region = CASE
        WHEN LOWER(TRIM(s.region)) = 'northwest' THEN 'Northwest'
        WHEN LOWER(TRIM(s.region)) = 'northeast' THEN 'Northeast'
        WHEN LOWER(TRIM(s.region)) = 'southeast' THEN 'Southeast'
        WHEN LOWER(TRIM(s.region)) = 'southwest' THEN 'Southwest'
        WHEN LOWER(TRIM(s.region)) = 'midwest' THEN 'Midwest'
        ELSE 'West'
    END
   AND p.smoking_status = CASE WHEN LOWER(TRIM(s.smoker)) = 'yes' THEN 'Yes' ELSE 'No' END
   AND p.num_dependents = s.children
JOIN hospitals h ON h.region = p.region;

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
-- Many-to-many linking claims to diagnoses and procedures
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
JOIN patients p ON p.patient_id = c.patient_id
JOIN diagnoses d ON d.diagnosis_id = (
    CASE
        WHEN MOD(c.claim_id, 6) = 1 THEN 1
        WHEN MOD(c.claim_id, 6) = 2 THEN 2
        WHEN MOD(c.claim_id, 6) = 3 THEN 3
        WHEN MOD(c.claim_id, 6) = 4 THEN 4
        WHEN MOD(c.claim_id, 6) = 5 THEN 5
        ELSE 6
    END
)
JOIN providers pr ON pr.hospital_id = c.hospital_id AND pr.specialty IN (
    'Cardiology', 'Orthopedics', 'Internal Medicine', 'General Practice'
);

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
