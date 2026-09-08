-- ================================================================
-- Section 1: Schema Creation for MySQL 8.0
-- Healthcare Insurance Claim Analysis
-- ================================================================

CREATE DATABASE IF NOT EXISTS healthcare_claims_db;
USE healthcare_claims_db;

-- Drop tables in reverse dependency order if rerunning the script.
DROP TABLE IF EXISTS claim_details;
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS diagnoses;
DROP TABLE IF EXISTS providers;
DROP TABLE IF EXISTS hospitals;
DROP TABLE IF EXISTS patients;

-- ================================================================
-- patients
-- ================================================================
CREATE TABLE patients (
    patient_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    age INT UNSIGNED NOT NULL,
    sex ENUM('Male', 'Female', 'Other') NOT NULL,
    bmi DECIMAL(5,2) NOT NULL,
    smoking_status ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    region ENUM('Northwest', 'Northeast', 'Southeast', 'Southwest', 'Midwest', 'West') NOT NULL,
    num_dependents INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (patient_id),
    CONSTRAINT chk_patients_age CHECK (age > 0),
    CONSTRAINT chk_patients_bmi CHECK (bmi > 0),
    CONSTRAINT chk_patients_dependents CHECK (num_dependents >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_patients_region ON patients(region);
CREATE INDEX idx_patients_smoking_status ON patients(smoking_status);

-- ================================================================
-- hospitals
-- ================================================================
CREATE TABLE hospitals (
    hospital_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    hospital_name VARCHAR(150) NOT NULL,
    location VARCHAR(150) NOT NULL,
    hospital_type ENUM('General', 'Specialty', 'Teaching', 'Community') NOT NULL DEFAULT 'General',
    bed_count INT UNSIGNED NOT NULL,
    PRIMARY KEY (hospital_id),
    CONSTRAINT chk_hospitals_bed_count CHECK (bed_count >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_hospitals_name ON hospitals(hospital_name);
CREATE INDEX idx_hospitals_type ON hospitals(hospital_type);

-- ================================================================
-- providers
-- ================================================================
CREATE TABLE providers (
    provider_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    provider_name VARCHAR(150) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    hospital_id BIGINT UNSIGNED NOT NULL,
    years_experience INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (provider_id),
    CONSTRAINT fk_providers_hospital FOREIGN KEY (hospital_id)
        REFERENCES hospitals(hospital_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_providers_experience CHECK (years_experience >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_providers_hospital_id ON providers(hospital_id);
CREATE INDEX idx_providers_specialty ON providers(specialty);

-- ================================================================
-- diagnoses
-- ================================================================
CREATE TABLE diagnoses (
    diagnosis_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    diagnosis_name VARCHAR(150) NOT NULL,
    diagnosis_code VARCHAR(20) NOT NULL,
    severity_level ENUM('Low', 'Moderate', 'High', 'Critical') NOT NULL DEFAULT 'Moderate',
    avg_treatment_cost DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (diagnosis_id),
    CONSTRAINT chk_diagnoses_cost CHECK (avg_treatment_cost >= 0)
) ENGINE=InnoDB;

CREATE UNIQUE INDEX uq_diagnoses_code ON diagnoses(diagnosis_code);
CREATE INDEX idx_diagnoses_severity ON diagnoses(severity_level);

-- ================================================================
-- claims
-- ================================================================
CREATE TABLE claims (
    claim_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    patient_id BIGINT UNSIGNED NOT NULL,
    claim_date DATE NOT NULL,
    claim_amount DECIMAL(12,2) NOT NULL,
    claim_status ENUM('Approved', 'Denied', 'Pending') NOT NULL DEFAULT 'Pending',
    hospital_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (claim_id),
    CONSTRAINT fk_claims_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_claims_hospital FOREIGN KEY (hospital_id)
        REFERENCES hospitals(hospital_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_claims_amount CHECK (claim_amount >= 0),
    CONSTRAINT chk_claims_date CHECK (claim_date IS NOT NULL)
) ENGINE=InnoDB;

CREATE INDEX idx_claims_patient_id ON claims(patient_id);
CREATE INDEX idx_claims_hospital_id ON claims(hospital_id);
CREATE INDEX idx_claims_claim_date ON claims(claim_date);
CREATE INDEX idx_claims_status ON claims(claim_status);

-- ================================================================
-- claim_details
-- ================================================================
CREATE TABLE claim_details (
    detail_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    claim_id BIGINT UNSIGNED NOT NULL,
    diagnosis_id BIGINT UNSIGNED NOT NULL,
    provider_id BIGINT UNSIGNED NOT NULL,
    procedure_cost DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    service_date DATE NOT NULL,
    PRIMARY KEY (detail_id),
    CONSTRAINT fk_claim_details_claim FOREIGN KEY (claim_id)
        REFERENCES claims(claim_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_claim_details_diagnosis FOREIGN KEY (diagnosis_id)
        REFERENCES diagnoses(diagnosis_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_claim_details_provider FOREIGN KEY (provider_id)
        REFERENCES providers(provider_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_claim_details_cost CHECK (procedure_cost >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_claim_details_claim_id ON claim_details(claim_id);
CREATE INDEX idx_claim_details_diagnosis_id ON claim_details(diagnosis_id);
CREATE INDEX idx_claim_details_provider_id ON claim_details(provider_id);
CREATE INDEX idx_claim_details_service_date ON claim_details(service_date);

-- ================================================================
-- Validation queries
-- ================================================================
SELECT 'Database schema created successfully.' AS status;
SHOW TABLES;
