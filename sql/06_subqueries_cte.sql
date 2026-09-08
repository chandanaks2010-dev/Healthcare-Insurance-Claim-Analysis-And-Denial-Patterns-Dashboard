-- ================================================================
-- Section 6: Subqueries, CTEs, and Set Operations
-- Healthcare Insurance Claim Analysis
-- ================================================================

USE healthcare_claims_db;

-- Query 1: Patients with claims above population mean (correlated subquery pattern)
SELECT
    p.patient_id,
    p.age,
    p.region,
    c.claim_id,
    c.claim_amount
FROM patients p
JOIN claims c
    ON c.patient_id = p.patient_id
WHERE c.claim_amount > (
    SELECT AVG(claim_amount)
    FROM claims
)
ORDER BY c.claim_amount DESC;

-- Query 2: Multi-level CTE for patient lifetime cost segmentation
WITH patient_totals AS (
    SELECT
        patient_id,
        SUM(claim_amount) AS lifetime_cost,
        COUNT(*) AS claim_count
    FROM claims
    GROUP BY patient_id
),
segment_thresholds AS (
    SELECT
        MIN(lifetime_cost) AS min_cost,
        MAX(lifetime_cost) AS max_cost,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY lifetime_cost) AS p25,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY lifetime_cost) AS p75
    FROM patient_totals
),
segmented AS (
    SELECT
        pt.patient_id,
        pt.lifetime_cost,
        CASE
            WHEN pt.lifetime_cost >= (SELECT p75 FROM segment_thresholds) THEN 'High'
            WHEN pt.lifetime_cost >= (SELECT p25 FROM segment_thresholds) THEN 'Medium'
            ELSE 'Low'
        END AS cost_tier
    FROM patient_totals pt
)
SELECT
    cost_tier,
    COUNT(*) AS patient_count,
    ROUND(AVG(lifetime_cost), 2) AS avg_lifetime_cost
FROM segmented
GROUP BY cost_tier
ORDER BY cost_tier;

-- Query 3: Patients with denied claims but no approved claims
SELECT
    p.patient_id,
    p.region,
    p.age
FROM patients p
WHERE EXISTS (
    SELECT 1
    FROM claims c
    WHERE c.patient_id = p.patient_id
      AND c.claim_status = 'Denied'
)
AND NOT EXISTS (
    SELECT 1
    FROM claims c
    WHERE c.patient_id = p.patient_id
      AND c.claim_status = 'Approved'
);

-- Query 4: UNION-based cohort comparison (smokers vs non-smokers)
SELECT
    'Smokers' AS cohort,
    COUNT(*) AS patient_count,
    ROUND(AVG(claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(claim_amount), 2) AS total_cost
FROM (
    SELECT c.claim_amount
    FROM claims c
    JOIN patients p
        ON p.patient_id = c.patient_id
    WHERE p.smoking_status = 'Yes'
) s
UNION ALL
SELECT
    'Non-Smokers' AS cohort,
    COUNT(*) AS patient_count,
    ROUND(AVG(claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(claim_amount), 2) AS total_cost
FROM (
    SELECT c.claim_amount
    FROM claims c
    JOIN patients p
        ON p.patient_id = c.patient_id
    WHERE p.smoking_status = 'No'
) ns;
