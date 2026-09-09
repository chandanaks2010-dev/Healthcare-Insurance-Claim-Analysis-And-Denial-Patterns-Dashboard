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
        SUM(claim_amount) AS lifetime_cost
    FROM claims
    GROUP BY patient_id
),
ranked_costs AS (
    SELECT
        patient_id,
        lifetime_cost,
        PERCENT_RANK() OVER (ORDER BY lifetime_cost) AS pct_rank
    FROM patient_totals
),
segmented AS (
    SELECT
        patient_id,
        lifetime_cost,
        CASE
            WHEN pct_rank >= 0.75 THEN 'High'
            WHEN pct_rank >= 0.25 THEN 'Medium'
            ELSE 'Low'
        END AS cost_tier
    FROM ranked_costs
)
SELECT
    cost_tier,
    COUNT(*) AS patient_count,
    ROUND(AVG(lifetime_cost), 2) AS avg_lifetime_cost
FROM segmented
GROUP BY cost_tier
ORDER BY
    CASE cost_tier
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
    END;

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
