-- ================================================================
-- Section 4: Aggregation and Conditional Analysis
-- Healthcare Insurance Claim Analysis
-- ================================================================

USE healthcare_claims_db;

-- Query 1: Hospital performance scorecard
SELECT
    h.hospital_name,
    h.hospital_type,
    COUNT(c.claim_id) AS claim_volume,
    ROUND(AVG(c.claim_amount), 2) AS avg_cost_per_claim,
    ROUND(
        SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) * 100.0 / COUNT(c.claim_id),
        2
    ) AS denial_rate_pct
FROM hospitals h
JOIN claims c
    ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.hospital_name, h.hospital_type
HAVING COUNT(c.claim_id) > 5
ORDER BY denial_rate_pct DESC;

-- Query 2: High-volume hospitals
SELECT
    h.hospital_name,
    COUNT(c.claim_id) AS total_claims,
    ROUND(SUM(c.claim_amount), 2) AS total_cost,
    ROUND(AVG(c.claim_amount), 2) AS avg_cost
FROM hospitals h
JOIN claims c
    ON h.hospital_id = c.hospital_id
GROUP BY h.hospital_id, h.hospital_name
HAVING COUNT(c.claim_id) >= 10
ORDER BY total_cost DESC;

-- Query 3: Denial rate by diagnosis severity
SELECT
    d.severity_level,
    COUNT(c.claim_id) AS total_claims,
    ROUND(
        SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) * 100.0 / COUNT(c.claim_id),
        2
    ) AS denial_rate_pct,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount
FROM claim_details cd
JOIN diagnoses d
    ON d.diagnosis_id = cd.diagnosis_id
JOIN claims c
    ON c.claim_id = cd.claim_id
GROUP BY d.severity_level
ORDER BY denial_rate_pct DESC;

-- Query 4: Cross-tabulation: avg cost by region and smoking status
SELECT
    p.region,
    p.smoking_status,
    COUNT(c.claim_id) AS claim_count,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_claim_cost
FROM patients p
LEFT JOIN claims c
    ON p.patient_id = c.patient_id
GROUP BY p.region, p.smoking_status
ORDER BY p.region, p.smoking_status;
