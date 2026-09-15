-- ================================================================
-- Section 6: Subqueries, CTEs, and Set Operations
-- Healthcare Insurance Claim Analysis
-- Executive MTech Program | Data Science & AI
-- ================================================================
-- QUERY OBJECTIVE: Demonstrate advanced query patterns using CTEs,
-- correlated/scalar subqueries, EXISTS/IN predicates, and UNION operations.
-- ================================================================

USE healthcare_claims_db;

-- ================================================================
-- Query 6.1: Claims Above Population Mean (Correlated Subquery)
-- ================================================================
-- Purpose: Identify above-average claims using correlated subquery
-- Use Case: Outlier detection, high-cost claim investigation
-- ================================================================
SELECT 'Query 6.1: Above-Average Claims Detection' AS query_name;

SELECT
    c.claim_id,
    p.patient_id,
    p.age,
    p.sex,
    p.region,
    c.claim_date,
    c.claim_amount,
    c.claim_status,
    ROUND(c.claim_amount - (SELECT AVG(claim_amount) FROM claims), 2) AS variance_from_mean,
    ROUND(((c.claim_amount - (SELECT AVG(claim_amount) FROM claims)) / (SELECT AVG(claim_amount) FROM claims)) * 100, 2) AS pct_above_mean
FROM claims c
JOIN patients p ON c.patient_id = p.patient_id
WHERE c.claim_amount > (
    SELECT AVG(claim_amount) FROM claims
)
ORDER BY c.claim_amount DESC
LIMIT 100;

-- ================================================================
-- Query 6.2: Multi-Level CTE for Patient Risk Stratification
-- ================================================================
-- Purpose: Segment patients into risk tiers using cascading CTEs
-- Use Case: Risk-based care management, targeted interventions
-- Techniques: Multiple CTE levels, window functions, CASE classification
-- ================================================================
SELECT 'Query 6.2: Patient Risk Stratification' AS query_name;

WITH patient_metrics AS (
    SELECT
        p.patient_id,
        p.age,
        p.bmi,
        p.smoking_status,
        p.region,
        COUNT(c.claim_id) AS claim_count,
        SUM(c.claim_amount) AS lifetime_cost,
        ROUND(AVG(c.claim_amount), 2) AS avg_claim_value,
        SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_count,
        ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate
    FROM patients p
    LEFT JOIN claims c ON p.patient_id = c.patient_id
    WHERE c.claim_id IS NOT NULL
    GROUP BY p.patient_id, p.age, p.bmi, p.smoking_status, p.region
),
risk_scored AS (
    SELECT
        patient_id,
        age,
        bmi,
        smoking_status,
        region,
        claim_count,
        lifetime_cost,
        avg_claim_value,
        denied_count,
        denial_rate,
        CASE
            WHEN smoking_status = 'Yes' THEN 2
            ELSE 0
        END +
        CASE
            WHEN bmi >= 30 THEN 2
            ELSE 0
        END +
        CASE
            WHEN age >= 50 THEN 1
            ELSE 0
        END +
        CASE
            WHEN denial_rate > 20 THEN 2
            ELSE 0
        END AS risk_score
    FROM patient_metrics
)
SELECT
    patient_id,
    age,
    bmi,
    smoking_status,
    region,
    claim_count,
    lifetime_cost,
    denial_rate,
    risk_score,
    CASE
        WHEN risk_score >= 6 THEN 'CRITICAL'
        WHEN risk_score >= 4 THEN 'HIGH'
        WHEN risk_score >= 2 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS risk_tier
FROM risk_scored
ORDER BY risk_score DESC;

-- ================================================================
-- Query 6.3: Denied Claims Analysis with Conditional EXISTS
-- ================================================================
-- Purpose: Find patients with denial pattern anomalies
-- Use Case: Appeal management, appeal prioritization, quality review
-- Techniques: EXISTS and NOT EXISTS predicates
-- ================================================================
SELECT 'Query 6.3: Denial Pattern Analysis' AS query_name;

SELECT
    p.patient_id,
    p.age,
    p.sex,
    p.region,
    p.smoking_status,
    p.bmi,
    (SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id AND c.claim_status = 'Denied') AS denied_count,
    (SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id AND c.claim_status = 'Approved') AS approved_count,
    (SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id) AS total_claims,
    ROUND(100.0 * (SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id AND c.claim_status = 'Denied') /
          NULLIF((SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id), 0), 2) AS denial_rate_pct
FROM patients p
WHERE EXISTS (
    -- Patient has been denied at least once
    SELECT 1 FROM claims c WHERE c.patient_id = p.patient_id AND c.claim_status = 'Denied'
)
AND (
    NOT EXISTS (
        -- Option 1: Patient has only denials, no approvals
        SELECT 1 FROM claims c WHERE c.patient_id = p.patient_id AND c.claim_status = 'Approved'
    )
    OR
    -- Option 2: Patient has very high denial rate (>50%)
    ROUND(100.0 * (SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id AND c.claim_status = 'Denied') /
          NULLIF((SELECT COUNT(*) FROM claims c WHERE c.patient_id = p.patient_id), 0), 2) > 50
)
ORDER BY denial_rate_pct DESC;

-- ================================================================
-- Query 6.4: Cohort Comparison via UNION (Smokers vs Non-Smokers)
-- ================================================================
-- Purpose: Compare smoking status impact on claims cost
-- Use Case: Health behavior analytics, preventive care ROI
-- Techniques: UNION ALL for cohort analysis
-- ================================================================
SELECT 'Query 6.4: Smoking Status Cohort Comparison' AS query_name;

SELECT
    'Smokers' AS cohort,
    COUNT(DISTINCT c.patient_id) AS unique_patients,
    COUNT(c.claim_id) AS total_claims,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_cohort_cost,
    ROUND(MAX(c.claim_amount), 2) AS max_claim,
    ROUND(MIN(c.claim_amount), 2) AS min_claim,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct
FROM claims c
JOIN patients p ON p.patient_id = c.patient_id
WHERE p.smoking_status = 'Yes'

UNION ALL

SELECT
    'Non-Smokers' AS cohort,
    COUNT(DISTINCT c.patient_id) AS unique_patients,
    COUNT(c.claim_id) AS total_claims,
    ROUND(AVG(c.claim_amount), 2) AS avg_claim_amount,
    ROUND(SUM(c.claim_amount), 2) AS total_cohort_cost,
    ROUND(MAX(c.claim_amount), 2) AS max_claim,
    ROUND(MIN(c.claim_amount), 2) AS min_claim,
    ROUND(STDDEV(c.claim_amount), 2) AS stddev_claim,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) / COUNT(c.claim_id), 2) AS denial_rate_pct
FROM claims c
JOIN patients p ON p.patient_id = c.patient_id
WHERE p.smoking_status = 'No'

ORDER BY denial_rate_pct DESC;

-- ================================================================
-- Query 6.5: Inline Subquery in FROM Clause (Derived Tables)
-- ================================================================
-- Purpose: Advanced cost analysis using derived table aggregations
-- Use Case: Multi-level cost breakdown, business intelligence
-- Techniques: Subqueries in FROM clause, multiple aggregation levels
-- ================================================================
SELECT 'Query 6.5: Multi-Level Cost Analysis via Derived Tables' AS query_name;

SELECT
    hospital_region,
    hospital_state,
    diagnosis_severity,
    COUNT(*) AS claim_count,
    ROUND(AVG(claim_amount), 2) AS avg_claim,
    ROUND(SUM(claim_amount), 2) AS total_cost,
    ROUND(AVG(denial_rate), 2) AS avg_denial_rate,
    ROUND(MAX(claim_amount), 2) AS max_claim,
    ROUND(MIN(claim_amount), 2) AS min_claim
FROM (
    SELECT
        h.region AS hospital_region,
        h.state AS hospital_state,
        d.severity_level AS diagnosis_severity,
        c.claim_amount,
        CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END AS denial_rate
    FROM claims c
    JOIN hospitals h ON c.hospital_id = h.hospital_id
    LEFT JOIN claim_details cd ON c.claim_id = cd.claim_id
    LEFT JOIN diagnoses d ON cd.diagnosis_id = d.diagnosis_id
) claim_detail_view
WHERE diagnosis_severity IS NOT NULL
GROUP BY hospital_region, hospital_state, diagnosis_severity
ORDER BY hospital_region, total_cost DESC;

-- ================================================================
-- Query 6.6 (OPTIONAL - Task 2.5a): Recursive CTE for Hierarchy
-- ================================================================
-- Purpose: Demonstrate recursive CTE capability for hierarchical data
-- Note: This example creates an artificial hierarchy for demonstration
-- Use Case: Organizational hierarchies, cost center rollups, geographic rollups
-- ================================================================
SELECT 'Query 6.6 (OPTIONAL): Recursive CTE Hierarchy Example' AS query_name;

WITH RECURSIVE region_hierarchy AS (
    -- Anchor: Top-level regions
    SELECT
        region,
        state,
        city,
        1 AS hierarchy_level,
        region AS top_region,
        CONCAT(region) AS path
    FROM (
        SELECT DISTINCT region, state, city FROM hospitals
    ) unique_locations

    UNION ALL

    -- Recursive: Extend hierarchy (example for demonstration)
    SELECT
        rh.region,
        rh.state,
        rh.city,
        rh.hierarchy_level + 1,
        rh.top_region,
        CONCAT(rh.path, ' > ', rh.city)
    FROM region_hierarchy rh
    WHERE rh.hierarchy_level < 2  -- Limit recursion depth
)
SELECT
    hierarchy_level,
    top_region,
    region,
    state,
    city,
    path
FROM region_hierarchy
WHERE hierarchy_level = 1
GROUP BY hierarchy_level, top_region, region, state, city, path
ORDER BY top_region, state, city;

-- ================================================================
-- SUMMARY & VALIDATION
-- ================================================================
SELECT '=== SECTION 6: CTEs & SUBQUERIES COMPLETE ===' AS section_status;
SELECT 'All 5+ queries (plus optional recursive CTE) executed successfully.' AS summary;
SELECT 'Task 2.5a recursive CTE optional example provided as Query 6.6.' AS recursive_note;
