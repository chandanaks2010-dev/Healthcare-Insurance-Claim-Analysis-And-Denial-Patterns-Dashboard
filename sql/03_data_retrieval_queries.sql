-- ================================================================
-- Section 3: Multi-table Retrieval and Basic Analytics
-- Healthcare Insurance Claim Analysis
-- ================================================================

USE healthcare_claims_db;

-- Query 1: Patient-level portfolio summary
SELECT
    p.patient_id,
    p.age,
    p.sex,
    p.smoking_status,
    p.region,
    COUNT(c.claim_id) AS total_claims,
    SUM(c.claim_amount) AS total_claim_cost,
    AVG(c.claim_amount) AS avg_claim_value
FROM patients p
LEFT JOIN claims c
    ON p.patient_id = c.patient_id
GROUP BY p.patient_id, p.age, p.sex, p.smoking_status, p.region
ORDER BY total_claim_cost DESC;

-- Query 2: Claim status by date range
SELECT
    c.claim_status,
    COUNT(*) AS claim_count,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_claim_amount
FROM claims c
WHERE c.claim_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.claim_status
ORDER BY total_claim_amount DESC;

-- Query 3: Hospital capacity utilization
SELECT
    h.hospital_name,
    h.location,
    h.bed_count,
    COUNT(c.claim_id) AS total_claims,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(COUNT(c.claim_id) / h.bed_count * 100, 2) AS claims_per_bed_pct
FROM hospitals h
LEFT JOIN claims c
    ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.hospital_name, h.location, h.bed_count
ORDER BY total_claims DESC;

-- Query 4: Provider specialty distribution across hospitals
SELECT
    pr.specialty,
    h.hospital_name,
    COUNT(DISTINCT pr.provider_id) AS provider_count,
    COUNT(DISTINCT cd.claim_id) AS associated_claims
FROM providers pr
LEFT JOIN hospitals h
    ON pr.hospital_id = h.hospital_id
LEFT JOIN claim_details cd
    ON pr.provider_id = cd.provider_id
GROUP BY pr.specialty, h.hospital_name
ORDER BY associated_claims DESC;

-- Query 5: Claim-to-diagnosis mapping and procedure cost summary
SELECT
    c.claim_id,
    p.patient_id,
    d.diagnosis_name,
    d.severity_level,
    cd.procedure_cost,
    h.hospital_name
FROM claims c
JOIN patients p
    ON p.patient_id = c.patient_id
JOIN claim_details cd
    ON cd.claim_id = c.claim_id
JOIN diagnoses d
    ON d.diagnosis_id = cd.diagnosis_id
JOIN hospitals h
    ON h.hospital_id = c.hospital_id
ORDER BY c.claim_id, cd.procedure_cost DESC;
