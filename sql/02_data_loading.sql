-- ================================================================
-- Section 2: Data Loading and ETL (MySQL 8.0)
-- Healthcare Insurance Claim Analysis
-- ================================================================

USE healthcare_claims_db;

-- IMPORTANT:
-- MySQL 8.0 enforces the secure_file_priv setting. If the server blocks
-- LOAD DATA INFILE, copy the CSV into the directory reported by:
-- SHOW VARIABLES LIKE 'secure_file_priv';
-- and/or use LOAD DATA LOCAL INFILE (if local_infile is enabled).
--
-- The repo expects the file here on this machine:
-- C:/Sem1/Healthcare-Insurance-Claim-Analysis-And-Denial-Patterns-Dashboard/data/raw/insurance_claims_raw.csv
-- If your MySQL server runs on a different machine, update the path below.

-- Optional staging table for the raw flat file.
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

-- Load raw dataset into staging table.
-- MySQL may reject LOAD DATA INFILE unless the path is inside secure_file_priv.
-- If needed, copy the file to that approved directory and point the path there.
-- Example:
-- SHOW VARIABLES LIKE 'secure_file_priv';
-- Then use the output directory + file name below.
--
-- If the server still blocks access, run this instead:
-- SET GLOBAL local_infile = 1;
-- LOAD DATA LOCAL INFILE 'C:/Sem1/Healthcare-Insurance-Claim-Analysis-And-Denial-Patterns-Dashboard/data/raw/insurance_claims_raw.csv'
-- INTO TABLE staging_claims
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/insurance_claims_raw.csv'
INTO TABLE staging_claims
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- ================================================================
-- Example transformation flow
-- ================================================================
-- The source file is a denormalized insurance table. The example below
-- creates a reproducible ETL pattern for loading into the normalized model.

-- 1) Populate patients dimension
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
FROM staging_claims s;

-- 2) Populate hospitals dimension
INSERT INTO hospitals (hospital_name, location, hospital_type, bed_count)
SELECT DISTINCT
    CONCAT('Hospital_', region) AS hospital_name,
    CASE
        WHEN region = 'Northwest' THEN 'Seattle'
        WHEN region = 'Northeast' THEN 'Boston'
        WHEN region = 'Southeast' THEN 'Atlanta'
        WHEN region = 'Southwest' THEN 'Phoenix'
        WHEN region = 'Midwest' THEN 'Chicago'
        ELSE 'San Francisco'
    END AS location,
    'General' AS hospital_type,
    200 + FLOOR(RAND() * 250) AS bed_count
FROM (
    SELECT DISTINCT region FROM patients
) p;

-- 3) Populate providers (synthetic but deterministic enough for demonstration)
INSERT INTO providers (provider_name, specialty, hospital_id, years_experience)
SELECT
    CONCAT('Provider_', p.patient_id, '_', ROW_NUMBER() OVER (PARTITION BY p.region ORDER BY p.patient_id)) AS provider_name,
    CASE
        WHEN MOD(p.patient_id, 4) = 0 THEN 'Cardiology'
        WHEN MOD(p.patient_id, 4) = 1 THEN 'Orthopedics'
        WHEN MOD(p.patient_id, 4) = 2 THEN 'Internal Medicine'
        ELSE 'General Practice'
    END AS specialty,
    h.hospital_id,
    3 + MOD(p.patient_id, 20) AS years_experience
FROM patients p
JOIN hospitals h ON h.location = CASE
    WHEN p.region = 'Northwest' THEN 'Seattle'
    WHEN p.region = 'Northeast' THEN 'Boston'
    WHEN p.region = 'Southeast' THEN 'Atlanta'
    WHEN p.region = 'Southwest' THEN 'Phoenix'
    WHEN p.region = 'Midwest' THEN 'Chicago'
    ELSE 'San Francisco'
END;

-- 4) Populate diagnoses dimension (example set of common high-cost diagnoses)
INSERT INTO diagnoses (diagnosis_name, diagnosis_code, severity_level, avg_treatment_cost)
VALUES
    ('Hypertension', 'I10', 'Moderate', 4200.00),
    ('Type 2 Diabetes', 'E11', 'High', 8500.00),
    ('Asthma', 'J45', 'Moderate', 3100.00),
    ('Pneumonia', 'J18', 'High', 12000.00),
    ('Arthritis', 'M15', 'Low', 2600.00),
    ('Coronary Artery Disease', 'I25', 'Critical', 18500.00);

-- 5) Create claims from staging data using patient and hospital mappings.
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
   AND p.bmi = s.bmi
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
JOIN hospitals h
    ON h.location = CASE
        WHEN LOWER(TRIM(s.region)) = 'northwest' THEN 'Seattle'
        WHEN LOWER(TRIM(s.region)) = 'northeast' THEN 'Boston'
        WHEN LOWER(TRIM(s.region)) = 'southeast' THEN 'Atlanta'
        WHEN LOWER(TRIM(s.region)) = 'southwest' THEN 'Phoenix'
        WHEN LOWER(TRIM(s.region)) = 'midwest' THEN 'Chicago'
        ELSE 'San Francisco'
    END;

-- 6) Populate claim_details as a bridge table (example mapping)
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
    c.claim_date
FROM claims c
JOIN patients p ON p.patient_id = c.patient_id
JOIN diagnoses d ON d.diagnosis_id = (
    (MOD(c.claim_id, 6) + 1)
)
JOIN providers pr ON pr.hospital_id = c.hospital_id
WHERE pr.specialty IN ('Cardiology', 'Orthopedics', 'Internal Medicine', 'General Practice');

-- ================================================================
-- Validation checks
-- ================================================================
SELECT 'ETL load complete.' AS status;
SELECT COUNT(*) AS total_patients FROM patients;
SELECT COUNT(*) AS total_claims FROM claims;
SELECT COUNT(*) AS total_claim_details FROM claim_details;
SELECT COUNT(*) AS total_hospitals FROM hospitals;

SELECT
    'NULL check' AS validation_type,
    SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS patient_nulls,
    SUM(CASE WHEN claim_id IS NULL THEN 1 ELSE 0 END) AS claim_nulls,
    SUM(CASE WHEN diagnosis_id IS NULL THEN 1 ELSE 0 END) AS diagnosis_nulls
FROM (
    SELECT patient_id, NULL AS claim_id, NULL AS diagnosis_id FROM patients
    UNION ALL
    SELECT NULL, claim_id, NULL FROM claims
    UNION ALL
    SELECT NULL, NULL, diagnosis_id FROM diagnoses
) x;
