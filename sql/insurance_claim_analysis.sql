-- ================================================================
-- COMPREHENSIVE HEALTHCARE INSURANCE CLAIM ANALYSIS SUITE
-- ================================================================
-- Project: Healthcare Insurance Claim Analysis & Denial Patterns
-- Program: Executive MTech Program | Data Science & AI
-- Database: MySQL 8.0+
-- Last Updated: September 2026
-- ================================================================
--
-- COMPLETE ANALYTICS PIPELINE (8 SECTIONS)
-- ================================================================
-- This master script documents the complete 8-section SQL analytics
-- suite for healthcare claims analysis. Individual sections are 
-- maintained in separate files for modularity and maintainability.
--
-- SECTION BREAKDOWN:
-- ================================================================
--
-- 00_data_profiling.sql
--    Purpose: Source data quality assessment, distribution analysis
--    Deliverable: Data profiling report with NULL audits, outlier detection
--    Content: 9 queries covering record-level, percentile, and quality metrics
--
-- 01_schema_creation.sql
--    Purpose: Database DDL with 3NF normalized schema (6 tables)
--    Deliverable: Complete relational model with constraints, indexes
--    Content: patients, hospitals, providers, diagnoses, claims, claim_details
--    Enhancement: Geographical fields (state, city, latitude, longitude) for Tableau
--
-- 02_data_loading.sql
--    Purpose: ETL pipeline with data transformation and validation
--    Deliverable: Reproducible load process from raw CSV to normalized tables
--    Content: Staging, transformation, population of 6 tables, validation checks
--    Enhancement: Geographical enrichment mapping regions to US cities/coordinates
--
-- 03_data_retrieval_queries.sql
--    Purpose: Multi-table JOIN queries for relational algebra demonstration
--    Deliverable: 5 sophisticated queries with business context
--    Queries:
--      3.1: Complete claim profile (all dimensions)
--      3.2: Provider performance analysis
--      3.3: Geographical claim distribution (Tableau-ready)
--      3.4: Diagnosis-specific cost analysis
--      3.5: Patient demographic risk profiling
--
-- 04_aggregation_analysis.sql
--    Purpose: GROUP BY, HAVING, and conditional aggregate analysis
--    Deliverable: 5 business intelligence queries
--    Queries:
--      4.1: Hospital performance scorecard
--      4.2: High-risk patient segments
--      4.3: Diagnosis severity impact
--      4.4: Regional-demographic cross-tabulation
--      4.5: Provider utilization and performance
--
-- 05_window_functions.sql
--    Purpose: Advanced ranking, cumulative, and trend analysis
--    Deliverable: 5 window function queries including Pareto analysis
--    Queries:
--      5.1: Hospital cost ranking and quartiles (RANK, NTILE)
--      5.2: Sequential claim numbering (ROW_NUMBER, PARTITION BY)
--      5.3: Diagnosis cost tier classification (DENSE_RANK)
--      5.4: Month-over-month trend with LAG/LEAD
--      5.5: PARETO ANALYSIS (80/20 rule, running totals) - KEY INSIGHT QUERY
--
-- 06_subqueries_cte.sql
--    Purpose: CTEs, correlated subqueries, EXISTS/IN, UNION operations
--    Deliverable: 5+ complex queries demonstrating advanced patterns
--    Queries:
--      6.1: Above-average claims (correlated subquery)
--      6.2: Multi-level CTE for risk stratification
--      6.3: Denial pattern analysis (EXISTS/NOT EXISTS)
--      6.4: Smoker vs non-smoker cohort comparison (UNION ALL)
--      6.5: Multi-level cost analysis (derived tables)
--      6.6: Recursive CTE hierarchy (optional, Task 2.5a)
--
-- 07_statistical_analysis.sql
--    Purpose: Descriptive statistics, percentiles, distributions, Pareto
--    Deliverable: 5 statistical queries for BI reporting
--    Queries:
--      7.1: Descriptive statistics (COUNT, MIN, MAX, AVG, STDDEV, VARIANCE)
--      7.2: Percentile distribution (P10-P99, IQR)
--      7.3: Coefficient of variation by hospital
--      7.4: Pareto analysis - cost concentration (80/20 principle)
--      7.5: Demographic segmentation statistics
--
-- 08_tableau_live_view (SECTION 8 - This File)
--    Purpose: Denormalized view for Tableau live connection
--    Deliverable: v_claims_tableau with all dimensional and calculated fields
--    Enhancement: Includes geographical fields for map visualization
--
-- ================================================================
-- EXECUTION ORDER FOR COMPLETE SETUP:
-- ================================================================
--  1. Run 00_data_profiling.sql (after loading staging_claims from CSV)
--  2. Run 01_schema_creation.sql (create schema)
--  3. Run 02_data_loading.sql (load and transform data)
--  4. Run 03-07_*.sql as needed for reporting
--  5. Run this file (insurance_claim_analysis.sql) for Tableau view
--
-- ================================================================

USE healthcare_claims_db;

-- ================================================================
-- SECTION 8: TABLEAU LIVE DATA VIEW (PREFERRED CONNECTION METHOD)
-- ================================================================
-- This view combines all 6 relational tables into a single denormalized
-- structure optimized for Tableau's live connection mode.
--
-- KEY FEATURES:
-- - Includes all dimensional attributes (patient, hospital, provider, diagnosis)
-- - Includes geographical coordinates (latitude, longitude) for mapping
-- - Includes calculated fields (cost_tier, age_group, bmi_category, denial_flag)
-- - Supports real-time updates via live database connection
--
-- TABLEAU CONFIGURATION:
-- 1. Connect to MySQL database: healthcare_claims_db
-- 2. Select view: v_claims_tableau
-- 3. Use geographical fields (state, city, latitude, longitude, region)
--    for Map visualization layers
-- 4. Use calculated fields for filtering and drilling:
--    - age_group, bmi_category for demographic analysis
--    - cost_tier for financial segmentation
--    - denial_flag for outcome analysis by dimension
--
-- ================================================================

DROP VIEW IF EXISTS v_claims_tableau;
CREATE VIEW v_claims_tableau AS
SELECT
    -- ======== CLAIM DIMENSIONS ========
    c.claim_id,
    c.claim_date,
    DATE_FORMAT(c.claim_date, '%Y-%m') AS claim_month,
    YEAR(c.claim_date) AS claim_year,
    MONTH(c.claim_date) AS claim_month_num,

    -- ======== PATIENT DIMENSIONS ========
    p.patient_id,
    p.age,
    p.sex,
    p.smoking_status,
    p.region AS patient_region,
    p.bmi,
    p.num_dependents,

    -- ======== HOSPITAL DIMENSIONS + GEOGRAPHICAL DATA FOR TABLEAU MAPPING ========
    h.hospital_id,
    h.hospital_name,
    h.location,
    h.hospital_type,
    h.state,
    h.city,
    h.region,
    h.latitude,
    h.longitude,

    -- ======== PROVIDER DIMENSIONS ========
    pr.provider_id,
    pr.provider_name,
    pr.specialty,

    -- ======== DIAGNOSIS DIMENSIONS ========
    d.diagnosis_id,
    d.diagnosis_name,
    d.diagnosis_code,
    d.severity_level,

    -- ======== FINANCIAL METRICS ========
    c.claim_amount,
    c.claim_status,
    COALESCE(cd_agg.procedure_cost, 0) AS procedure_cost,

    -- ======== CALCULATED FIELDS FOR ANALYTICS & FILTERING ========
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
    END AS denial_flag,

    CASE
        WHEN c.claim_status = 'Denied' THEN c.claim_amount
        ELSE 0
    END AS denied_amount

FROM claims c
LEFT JOIN patients p
    ON p.patient_id = c.patient_id
LEFT JOIN hospitals h
    ON h.hospital_id = c.hospital_id
LEFT JOIN (
    SELECT
        claim_id,
        MAX(diagnosis_id) AS diagnosis_id,
        MAX(provider_id) AS provider_id,
        MAX(procedure_cost) AS procedure_cost
    FROM claim_details
    GROUP BY claim_id
) AS cd_agg
    ON cd_agg.claim_id = c.claim_id
LEFT JOIN diagnoses d
    ON d.diagnosis_id = cd_agg.diagnosis_id
LEFT JOIN providers pr
    ON pr.provider_id = cd_agg.provider_id;

-- ================================================================
-- VIEW VALIDATION AND STATISTICS
-- ================================================================
SELECT '=== TABLEAU LIVE VIEW CREATION STATUS ===' AS step;
SELECT 'View v_claims_tableau created successfully.' AS status;

SELECT COUNT(*) AS total_tableau_rows FROM v_claims_tableau;
SELECT COUNT(DISTINCT state) AS distinct_states FROM v_claims_tableau WHERE state IS NOT NULL;
SELECT COUNT(DISTINCT region) AS distinct_regions FROM v_claims_tableau WHERE region IS NOT NULL;
SELECT COUNT(DISTINCT latitude) AS records_with_coordinates FROM v_claims_tableau WHERE latitude IS NOT NULL;

-- ================================================================
-- TABLEAU WORKSHEET RECOMMENDATIONS
-- ================================================================
-- Based on the v_claims_tableau view, the following worksheets are recommended:
--
-- 1. GEOGRAPHICAL MAP DASHBOARD (Primary)
--    - Marks: State/City with Latitude/Longitude
--    - Color: Denial Rate (%), Size: Claim Volume
--    - Filters: Region, Hospital Type, Diagnosis Severity
--    - KPIs: Total Claims, Total Cost, Denial Rate, Avg Claim
--
-- 2. CLAIMS PERFORMANCE BY REGION
--    - Rows: Region; Columns: Claim Status
--    - Color: Avg Claim Amount, Size: Claim Count
--    - Includes: Approval rate, avg cost by region
--
-- 3. PATIENT DEMOGRAPHIC RISK ANALYSIS
--    - Rows: Age Group; Columns: BMI Category
--    - Color: Denial Rate (%), Smoke Status filter
--    - Insight: High-risk demographic segments
--
-- 4. HOSPITAL NETWORK PERFORMANCE
--    - Bar chart: Hospital Name, Measure: Total Claims/Cost/Denial Rate
--    - Sorted by Denial Rate DESC
--    - Filters: Region, Hospital Type
--
-- 5. DIAGNOSIS-BASED COST & DENIAL TRENDS
--    - Rows: Diagnosis Name; Columns: Severity Level
--    - Color: Avg Claim Cost, Size: Denial Flag count
--    - Insight: High-risk diagnosis patterns
--
-- 6. PROVIDER PERFORMANCE SCORECARD
--    - Rows: Provider Specialty; Columns: Hospital Region
--    - Color: Denial Rate, Size: Claim Volume
--    - Insight: Provider quality metrics by location
--
-- 7. TIME-SERIES ANALYSIS (Monthly Trends)
--    - Line chart: Claim Month on X-axis
--    - Measures: Total Claims, Total Cost, Denial Rate
--    - Insight: Seasonal patterns, trend forecasting
--
-- 8. DENIAL REASONS DEEP DIVE
--    - Filter: Denial Flag = 1
--    - Rows: Patient Region; Columns: Diagnosis Severity
--    - Color: Count of Denials
--    - Insight: Denial concentration by dimension
--
-- ================================================================
-- PROJECT COMPLETION CHECKLIST
-- ================================================================
-- ✓ Schema: 3NF normalized design (01_schema_creation.sql)
-- ✓ ETL: Reproducible data load with validation (02_data_loading.sql)
-- ✓ Retrieval: 5+ multi-table JOIN queries (03_data_retrieval_queries.sql)
-- ✓ Aggregation: 5+ GROUP BY/HAVING queries (04_aggregation_analysis.sql)
-- ✓ Window Functions: 5+ ranking/trend queries (05_window_functions.sql)
-- ✓ CTEs/Subqueries: 5+ advanced pattern queries (06_subqueries_cte.sql)
-- ✓ Statistics: 5+ statistical/Pareto queries (07_statistical_analysis.sql)
-- ✓ Tableau View: Denormalized view with geo fields (Section 8 - THIS FILE)
-- ✓ Geographical Mapping: State, city, latitude, longitude included
-- ✓ Professional Documentation: Comprehensive header and section notes
--
-- DELIVERABLES SUMMARY:
-- - 8 SQL sections covering complete analytics pipeline
-- - 3NF normalized schema with geographical enhancement
-- - 35+ analytical queries demonstrating SQL mastery
-- - Tableau-ready denormalized view for live connection
-- - Professional documentation and execution guidelines
--
-- ================================================================

SELECT '=== HEALTHCARE INSURANCE CLAIM ANALYSIS SUITE - COMPLETE ===' AS final_status;
SELECT 'All 8 sections ready for production analytics and Tableau dashboard.' AS completion_note;
SELECT 'Geographical fields (latitude, longitude) enabled for map visualization.' AS geo_note;
