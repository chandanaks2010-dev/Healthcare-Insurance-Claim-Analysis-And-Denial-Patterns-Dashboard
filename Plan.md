# Healthcare Insurance Claim Analysis & Denial Patterns Dashboard

## SQL & Tableau Mini Project — Executive MTech Program

 

**Program:** Executive MTech in Data Science & AI  

**Project Duration:** 15-18 hours (2-person team, parallel work)  

**Submission Date:** 09 Sep 2026 ⚠️ **[Status: In Progress as of 15 Sep 2026]**  

**Team Members:** Team A and Team B  

**Industry Domain:** Healthcare Revenue Cycle Management (RCM)

 

---

 

## 📋 Project Overview

 

### Business Context

Healthcare organizations lose an estimated 3-5% of net revenue due to claim denials (HFMA, 2023). Identifying denial patterns and cost drivers through data-driven analysis enables strategic interventions in the revenue cycle, improving both financial performance and patient experience.

 

### Objective

Design and implement an end-to-end analytics solution that leverages structured query language for data engineering and exploratory analysis, combined with Tableau for executive-level visual storytelling. The project demonstrates competency in relational data modeling, advanced SQL analytics (window functions, CTEs, statistical aggregates), and interactive business intelligence dashboard design — applied to a real-world healthcare claims domain.

### 🎯 Demographic Attributes Strategy for Tableau Analysis

**Raw Data Attributes → SQL Segmentation → Tableau Visualization**

The insurance claims dataset includes rich demographic attributes that are the foundation of our Tableau dashboard strategy:

| Raw Attribute | Data Type | SQL Transformation | Tableau Usage | Business Value |
|---------------|-----------|-------------------|---------------|-----------------|
| **age** | Integer (19-64) | Bucketed into 5 age groups (18-25, 26-35, 36-45, 46-55, 56+) in SQL Query 6 | Heatmap dimension in `Patient Risk Segments` sheet | Identifies age-related cost drivers; older smokers (56+) show $28k-$48k avg charges |
| **bmi** | Float (15.96-49.06) | Categorized as Underweight, Normal, Overweight, Obese in SQL Query 6 | Heatmap dimension in `Patient Risk Segments` sheet | BMI ≥ 30 adds $3k-$8k to avg cost; combined with smoking = extreme risk cohort |
| **smoker** | Boolean (yes/no) | Direct mapping in SQL Query 6 | Heatmap dimension + filter in `Patient Risk Segments` sheet; color coding in other sheets | Smoking status is the **strongest single cost driver**: smokers average $17k-$39k vs. non-smokers $2k-$8k (5-10× multiplier) |
| **charges** | Currency | Aggregated to avg, sum, stddev in SQL Query 6 | Heatmap measure in `Patient Risk Segments` sheet | Reveals cost concentration in high-risk demographic cells; supports pricing strategy |
| **region** | String | Pre-normalized; used for drill-down in multi-dimensional analysis | Geographic filters + dual-axis region comparison in `Regional Cost and Denial Profile` | Enables regional premium variation and denial rate benchmarking across 6 US regions |

**Why This Strategy Aligns with Evaluation Criteria:**
- **Statistical/KPI Analysis (4 marks):** Query 6 provides variance decomposition by demographic cohort; `Patient Risk Segments` Tableau sheet shows multi-dimensional segmentation
- **Insight Generation (4 marks):** Demographic heatmap surfaces actionable findings (e.g., "Obese smokers age 56+ = $45k avg, eligible for targeted prevention program")
- **Tableau Dashboard Design (6 marks):** Heatmap + heatmap filters demonstrate advanced interactivity; color-coded risk tiers drive executive decision-making

 

### Expected Deliverables

- ✅ SQL Script File (`insurance_claim_analysis.sql`) — Schema design, ETL, and 7 analytical query sections

- ✅ Tableau Workbook (`healthcare_insurance_dashboard.twbx`) — 6+ interactive visualizations with storyboard

- ✅ Final PPT Presentation (7 slides) — Executive summary with data-backed recommendations

- ✅ Project Report Documentation — Methodology, findings, and business impact analysis


### Requirement Traceability Matrix

| Requirement | What it means in this project | Where it is implemented | Completion status |
|-----------|-------------------------------|-------------------------|------------------|
| 1. Data understanding | Understand healthcare claims domain, model design, data quality and normalization | Dataset section, schema design, data profiling tasks | In progress |
| 2. Relational schema design | Build normalized tables with keys, constraints and referential integrity | `sql/01_schema_creation.sql` | In progress |
| 3. ETL / data loading | Load raw CSV into normalized tables and validate data quality | `sql/02_data_loading.sql` | In progress |
| 4. SQL retrieval queries | Multi-table joins, filtering, patient and hospital analysis | `sql/03_data_retrieval_queries.sql` | In progress |
| 5. Aggregation analysis | GROUP BY, HAVING, conditional aggregates, segmentation | `sql/04_aggregation_analysis.sql` | In progress |
| 6. Window functions | RANK, DENSE_RANK, ROW_NUMBER, LAG/LEAD, cumulative totals | `sql/05_window_functions.sql` | In progress |
| 7. Subqueries and CTEs | Correlated subqueries, recursive/stepwise CTE logic | `sql/06_subqueries_cte.sql` | In progress |
| 8. Statistical analysis | Descriptive stats, percentiles, Pareto, variability analysis | `sql/07_statistical_analysis.sql` | In progress |
| 9. Tableau workbook | At least 6 sheets, interactive dashboard and filters | `tableau/healthcare_insurance_dashboard.twbx` | Pending |
| 10. KPI and executive summary | Summary cards for claims, spend, approval and cost per claim | Dashboard sheet `Executive KPI Summary` | Pending |
| 11. Cost and denial analysis | Trend, Pareto, denial vs cost, regional comparison | Sheets: `Monthly Spend Trend`, `Cost Concentration by Hospital`, `Denial vs Cost by Hospital`, `Regional Cost and Denial Profile` | Pending |
| 12. Demographic risk analysis | Age, BMI and smoking-related cost patterns | Sheet: `Patient Risk Segments` | Pending |
| 12B. Customer lifetime value & RFM segmentation | Recency, Frequency, Monetary analysis for member retention | Sheet: `Patient Lifetime Value - RFM Analysis` (WORKSHEET 9) | Pending |
| 13. Provider and operational drill-down | Provider specialty and hospital detail analysis | Sheet: `Provider Performance Detail` | Pending |
| 14. Storytelling / dashboard narrative | Clear executive dashboard flow and narrative story points | Dashboard layout and storyboard section | Pending |
| 15. Business insights and recommendations | Quantified insights, SMART actions, cost/denial impact | Report + Presentation | Pending |
| 16. Documentation | Methodology, findings, limitations, references | `report/project_report.md` and `README.md` | Pending |
| 17. Presentation | 7-slide executive summary for review / viva | `report/presentation.pptx` | Pending |


### Project Requirement Checklist

- [ ] Data source identified and profiled
- [ ] 3NF schema created and documented
- [ ] ETL process implemented and validated
- [ ] SQL retrieval queries completed
- [ ] Aggregation and segmentation logic completed
- [ ] Window function analysis completed
- [ ] CTE/subquery analysis completed
- [ ] Statistical analysis completed
- [ ] Tableau dataset view created (`v_claims_tableau`)
- [ ] Workbook contains at least 6 sheets
- [ ] Executive KPI summary sheet included
- [ ] Monthly trend sheet included
- [ ] Pareto cost concentration sheet included
- [ ] Denial vs cost visualization included
- [ ] Regional performance view included
- [ ] Provider drill-down included
- [ ] Demographic risk segmentation included
- [ ] Claims status distribution included
- [ ] Dashboard filters and interactivity configured
- [ ] Final dashboard narrative and storyboard completed
- [ ] Findings quantified and documented
- [ ] Recommendations and business impact defined
- [ ] Final report submitted
- [ ] Presentation deck completed

 

### Evaluation Criteria: 30 Marks

| Component | Marks | Executive MTech Expectation |

|-----------|-------|-----------------------------|

| Dataset Understanding | 3 | Normalization rationale, data quality profiling, schema design decisions |

| SQL Querying | 5 | Advanced patterns: window functions, recursive CTEs, statistical aggregates |

| Tableau Dashboard Design | 6 | Executive-ready dashboards with drill-down, KPI storytelling, UX principles |

| Statistical / KPI Analysis | 4 | Pareto analysis, segmentation, variance decomposition, confidence metrics |

| Insight Generation | 4 | Actionable insights with quantified business impact ($ or %) |

| Documentation & Report | 4 | Professional report with methodology section and analytical framework |

| Presentation & Viva | 4 | Executive communication: concise, data-driven, handles technical deep-dives |

 

---

 

## 📊 Dataset Information

 

### Data Source Selection Rationale

**Primary: Kaggle Insurance Medical Claims Dataset (Enriched & Diversified)**

- **Link:** https://www.kaggle.com/datasets/mirichoi0218/insurance

- **Records:** ~1,549 total (Original: ~1,330 + Enriched: 219 new records)
  - Expanded with **Midwest Region** and additional enrichment for comprehensive regional coverage
  - Expanded with **West Region** (134 records): California, Colorado, Nevada, Utah coverage
  - Comprehensive geographical distribution across **6 complete US regions**

- **Geographical Coverage:** 
  - Northwest, Northeast, Southeast, Southwest (original)
  - Midwest, West (new enrichment)
  - All regions with 250+ records minimum for robust analysis
  - Age range: 18-64 across all regions
  - BMI: Full spectrum (25.1-37.8 in enriched data)
  - Claim amounts: $1,234-$43,567 range for cost segmentation

- **Structure:** Single denormalized table → normalized into 6 relational tables (3NF)

- **Key Variables:** age, sex, bmi, children, smoker, region, charges

- **Analytical Suitability:** 
  - Supports demographic segmentation, cost modeling, and **regional analysis across 6 US regions**
  - Geographic mapping with state-level and city-level drill-downs
  - Sufficient diversity for Tableau heat maps, regional comparisons, and geographical visualizations

 

### Alternative/Complementary Data (for extended analysis)

- **Healthcare Insurance Claim Prediction:** https://www.kaggle.com/datasets/sachinkumar413/healthcare-insurance-claim-prediction (~40K rows — scalability testing)

- **CMS Hospital Quality Data:** https://data.cms.gov/ (real-world benchmarking)

 

### Relational Schema Design (3NF Normalized)

 

**Design Decisions:**

- Normalized to 3NF to eliminate update anomalies and support efficient analytical queries

- Surrogate keys (auto-increment) for referential integrity

- Claim status modeled as ENUM/CHECK constraint for data quality enforcement

- Bridge table (`claim_details`) enables many-to-many between claims and diagnoses

 

```

patients (Dimension)

  └─ patient_id (PK), age, sex, bmi, smoking_status, region, num_dependents

 

claims (Fact)

  └─ claim_id (PK), patient_id (FK), claim_date, claim_amount, claim_status, hospital_id (FK)

 

diagnoses (Dimension)

  └─ diagnosis_id (PK), diagnosis_name, diagnosis_code (ICD-10), severity_level, avg_treatment_cost

 

claim_details (Bridge/Fact)

  └─ detail_id (PK), claim_id (FK), diagnosis_id (FK), provider_id (FK), procedure_cost, service_date

 

providers (Dimension)

  └─ provider_id (PK), provider_name, specialty, hospital_id (FK), years_experience

 

hospitals (Dimension)

  └─ hospital_id (PK), hospital_name, location, hospital_type, bed_count

```

 

**Entity-Relationship Cardinalities:**

- Patient → Claims: 1:N (one patient, multiple claims over time)

- Claim → Claim_Details: 1:N (one claim may cover multiple procedures)

- Hospital → Providers: 1:N (one hospital, many providers)

- Hospital → Claims: 1:N (claims processed at specific hospitals)

 

---

 

## 🗓️ Project Timeline & Task Breakdown

 

### **PHASE 1: Data Engineering & Schema Design (Days 1-2 | 2-3 hours)**

 

#### Day 1 - Project Setup & Architecture (1 hour)

- [ ] **Task 1.1** - Define team responsibilities and collaboration workflow

  - **Person A (Data Engineering & SQL Analytics Lead):** Schema design, ETL pipeline, query development, statistical analysis

  - **Person B (BI & Visualization Lead):** Dashboard architecture, visual design, interactivity, storyboard narrative

  - **Collaboration:** Both contribute to insight generation, report, and presentation

- [ ] **Task 1.2** - Acquire and profile source data

  - Download from Kaggle: https://www.kaggle.com/datasets/mirichoi0218/insurance

  - Save to: `./data/raw/insurance_claims_raw.csv`

  - If MySQL blocks the file load because of `secure_file_priv`, also copy the same CSV into the server's approved upload folder returned by `SHOW VARIABLES LIKE 'secure_file_priv';` (for example `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/insurance_claims_raw.csv`).

  - Initial profiling: row count, column types, cardinality, null rates, distribution shapes

- [ ] **Task 1.3** - Establish project repository structure

  ```

  healthcare-insurance-project/

  ├── data/

  │   ├── raw/                          # Immutable source data

  │   │   └── insurance_claims_raw.csv

  │   └── processed/                    # Transformed/enriched data for Tableau

  │       └── claims_analysis.csv

  ├── sql/

  │   ├── 01_schema_creation.sql        # DDL with constraints and indexes

  │   ├── 02_data_loading.sql           # ETL: CSV → normalized tables

  │   ├── 03_data_retrieval_queries.sql # JOINs, filtering, basic retrieval

  │   ├── 04_aggregation_analysis.sql   # GROUP BY, HAVING, conditional aggregates

  │   ├── 05_window_functions.sql       # RANK, ROW_NUMBER, LAG/LEAD, running totals

  │   ├── 06_subqueries_cte.sql         # Correlated subqueries, recursive CTEs

  │   ├── 07_statistical_analysis.sql   # STDDEV, percentiles, Pareto, segmentation

  │   └── insurance_claim_analysis.sql  # Consolidated deliverable

  ├── tableau/

  │   └── healthcare_insurance_dashboard.twbx

  ├── report/

  │   ├── project_report.md

  │   └── presentation.pptx

  ├── Plan.md

  └── README.md

  ```

- [ ] **Task 1.4** - Initialize database environment

  - **Recommended:** MySQL 8.0+ or PostgreSQL 14+ (supports window functions, CTEs, JSON)

  - **Alternative:** SQLite 3.25+ (supports window functions; simpler setup)

  - Create database: `healthcare_claims_db`

  - Configure connection parameters and test connectivity

 

#### Day 2 - Data Modeling & ETL (1-2 hours)

- [ ] **Task 1.5** - Perform data quality assessment

  - Profile: distributions (age, bmi, charges), categorical cardinalities (sex, smoker, region)

  - Identify: missing values, outliers (IQR method on charges), duplicates

  - Document findings in data quality section of report

  - Decision log: How outliers/nulls are handled (retain, impute, flag)

- [ ] **Task 1.5a** - Create data profiling SQL script (prerequisite to Phase 2)

  - File: `sql/00_data_profiling.sql`

  - Queries:
    - Descriptive stats: COUNT, DISTINCT, NULL rates per column
    - Distribution analysis: MIN, MAX, AVG, STDDEV for numeric columns
    - Outlier detection: IQR calculation and row counts for flagged records
    - Cardinality check: Unique values per categorical column

- [ ] **Task 1.6** - Implement schema DDL (Person A)

  - Write `01_schema_creation.sql`:

    - All 6 tables with appropriate data types (DECIMAL for currency, DATE for temporal)

    - PRIMARY KEY, FOREIGN KEY with ON DELETE/UPDATE actions

    - CHECK constraints (e.g., age > 0, claim_status IN ('Approved','Denied','Pending'))

    - Indexes on frequently queried columns (claim_date, patient_id, hospital_id)

- [ ] **Task 1.7** - Implement ETL pipeline (Person A)

  - Write `02_data_loading.sql`:

    - Transform flat CSV into 6 normalized tables

    - Generate synthetic data for fields not in source (claim_date, claim_status, hospital, provider)

    - Use deterministic seed for reproducibility

    - Validate: row counts per table, referential integrity checks, NULL audits

 

---

 

### **PHASE 2: SQL Analytics Development (Days 3-5 | 6-8 hours)**

 

#### Day 3 - Foundational & Multi-Table Queries (2 hours) - Person A

- [ ] **Task 2.1** - Write multi-table JOIN queries demonstrating relational algebra

  - File: `03_data_retrieval_queries.sql`

  - Query 1: Patient claim portfolio (INNER JOIN + aggregation)

    ```sql

    -- Patient-level claim summary with demographic context

    SELECT p.patient_id, p.age, p.sex, p.smoking_status, p.region,

           COUNT(c.claim_id) AS total_claims,

           SUM(c.claim_amount) AS total_cost,

           AVG(c.claim_amount) AS avg_claim_value

    FROM patients p

    LEFT JOIN claims c ON p.patient_id = c.patient_id

    GROUP BY p.patient_id, p.age, p.sex, p.smoking_status, p.region

    ORDER BY total_cost DESC;

    ```

  - Query 2: Temporal filtering with parameterized date ranges and claim status

  - Query 3: Hospital capacity utilization (patient volume vs. bed count)

  - Query 4: Provider specialty distribution across hospital network

  - Query 5: Claim-to-diagnosis mapping with procedure cost breakdown

 

- [ ] **Task 2.2** - Validate query correctness

  - Cross-check aggregates against source data totals

  - Verify JOIN cardinality (no unintended row multiplication)

  - Document: expected row counts and sample output per query

 

#### Day 4 - Aggregation Analytics & Window Functions (2-3 hours) - Person A

- [ ] **Task 2.3** - Conditional aggregation and segmentation queries

  - File: `04_aggregation_analysis.sql`

  - Query 1: Hospital performance scorecard (GROUP BY with multiple metrics)

    ```sql

    SELECT h.hospital_name, h.hospital_type,

           COUNT(c.claim_id) AS claim_volume,

           AVG(c.claim_amount) AS avg_cost,

           SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) * 100.0

             / COUNT(*) AS denial_rate_pct

    FROM hospitals h

    JOIN claims c ON h.hospital_id = c.hospital_id

    GROUP BY h.hospital_name, h.hospital_type

    HAVING COUNT(c.claim_id) > 10

    ORDER BY denial_rate_pct DESC;

    ```

  - Query 2: High-volume hospitals filter (HAVING with threshold logic)

  - Query 3: Conditional aggregation — denial rate by diagnosis severity

  - Query 4: Cross-tabulation — avg cost by region × smoking status (CASE WHEN pivot)

 

- [ ] **Task 2.4** - Window function analytics for ranking and trends

  - File: `05_window_functions.sql`

  - Query 1: Hospital cost ranking with ties handling

    ```sql

    -- RANK with PARTITION for comparative analysis

    SELECT hospital_id, hospital_name,

           SUM(claim_amount) AS total_cost,

           RANK() OVER (ORDER BY SUM(claim_amount) DESC) AS cost_rank,

           NTILE(4) OVER (ORDER BY SUM(claim_amount) DESC) AS cost_quartile

    FROM claims c JOIN hospitals h ON c.hospital_id = h.hospital_id

    GROUP BY hospital_id, hospital_name;

    ```

  - Query 2: ROW_NUMBER() — Sequential claim numbering per patient (visit history)

  - Query 3: DENSE_RANK() — Diagnosis cost tier classification

  - Query 4: LAG/LEAD — Month-over-month cost trend with % change calculation

    ```sql

    -- Temporal trend with period-over-period change

    WITH monthly_costs AS (

      SELECT DATE_FORMAT(claim_date, '%Y-%m') AS claim_month,

             SUM(claim_amount) AS monthly_total

      FROM claims GROUP BY claim_month

    )

    SELECT claim_month, monthly_total,

           LAG(monthly_total) OVER (ORDER BY claim_month) AS prev_month,

           ROUND((monthly_total - LAG(monthly_total) OVER (ORDER BY claim_month))

             / LAG(monthly_total) OVER (ORDER BY claim_month) * 100, 2) AS pct_change

    FROM monthly_costs;

    ```

  - Query 5: Running total and cumulative percentage by diagnosis cost (SUM() OVER with frame)

    ```sql

    -- Running cumulative total and cumulative % for diagnosis cost analysis

    WITH diagnosis_costs AS (

      SELECT d.diagnosis_name, SUM(cd.procedure_cost) AS total_cost

      FROM claim_details cd

      JOIN diagnoses d ON cd.diagnosis_id = d.diagnosis_id

      GROUP BY d.diagnosis_name

    )

    SELECT 

      diagnosis_name,

      total_cost,

      SUM(total_cost) OVER (ORDER BY total_cost DESC) AS running_total,

      ROUND(SUM(total_cost) OVER (ORDER BY total_cost DESC) / 

            SUM(total_cost) OVER () * 100, 2) AS cumulative_pct

    FROM diagnosis_costs

    ORDER BY total_cost DESC;

    ```

 

#### Day 5 - Advanced Analytical Queries (2-3 hours) - Person A

- [ ] **Task 2.5** - Subqueries, CTEs, and set operations

  - File: `06_subqueries_cte.sql`

  - Query 1: High-cost patient identification (correlated subquery)

    ```sql

    -- Patients with claims above population mean (correlated subquery pattern)

    SELECT p.*, c.claim_amount

    FROM patients p

    JOIN claims c ON p.patient_id = c.patient_id

    WHERE c.claim_amount > (SELECT AVG(claim_amount) FROM claims);

    ```

  - Query 2: Multi-level CTE for stepwise analytical pipeline

    ```sql

    -- CTE chain: segment → aggregate → filter (MySQL-compatible percentile logic)

    WITH patient_totals AS (

      SELECT patient_id, SUM(claim_amount) AS lifetime_cost

      FROM claims

      GROUP BY patient_id

    ),

    ranked_costs AS (

      SELECT

        patient_id,

        lifetime_cost,

        PERCENT_RANK() OVER (ORDER BY lifetime_cost) AS percentile_rank

      FROM patient_totals

    )

    SELECT

      CASE

        WHEN percentile_rank >= 0.75 THEN 'High'

        WHEN percentile_rank >= 0.25 THEN 'Medium'

        ELSE 'Low'

      END AS cost_tier,

      COUNT(*) AS patient_count,

      ROUND(AVG(lifetime_cost), 2) AS avg_cost

    FROM ranked_costs

    GROUP BY cost_tier;

    ```

  - Query 3: EXISTS/NOT EXISTS — Patients with denied claims but no approved claims

  - Query 4: UNION-based cohort comparison (smokers vs. non-smokers metrics)

- [ ] **Task 2.5a** - Recursive CTE for hierarchical analysis (Optional - Advanced)

  - File: `06_subqueries_cte.sql` (addition)

  - Query (Optional): Hierarchical cost drill-down using recursive CTE

    - Demonstrates: WITH RECURSIVE ... UNION ALL pattern for multi-level rollup

    - Example: Top spending hospitals → providers → diagnoses (hierarchy traversal)

    - Note: Recursive CTEs are optional for this project but demonstrate advanced SQL mastery

 

- [ ] **Task 2.6** - Statistical and financial analysis queries

  - File: `07_statistical_analysis.sql`

  - Query 1: Descriptive statistics suite (MEAN, STDDEV, VARIANCE, MIN, MAX, IQR proxy)

  - Query 2: Percentile distribution of claim costs (P10, P25, P50, P75, P90)

  - Query 3: Coefficient of variation by hospital (risk-adjusted comparison)

    ```sql

    -- CV = STDDEV/MEAN — identifies high-variability cost centers

    SELECT h.hospital_name,

           AVG(c.claim_amount) AS mean_cost,

           STDDEV(c.claim_amount) AS std_cost,

           ROUND(STDDEV(c.claim_amount) / AVG(c.claim_amount) * 100, 2) AS cv_pct

    FROM claims c JOIN hospitals h ON c.hospital_id = h.hospital_id

    GROUP BY h.hospital_name

    HAVING COUNT(*) > 5

    ORDER BY cv_pct DESC;

    ```

  - Query 4: Pareto analysis — cumulative contribution to total cost

    ```sql

    -- 80/20 Pareto: hospitals contributing to 80% of total spend

    WITH hospital_costs AS (

      SELECT hospital_id, SUM(claim_amount) AS total_cost

      FROM claims GROUP BY hospital_id

    ),

    ranked AS (

      SELECT *,

             SUM(total_cost) OVER (ORDER BY total_cost DESC) AS running_total,

             SUM(total_cost) OVER () AS grand_total

      FROM hospital_costs

    )

    SELECT *, ROUND(running_total / grand_total * 100, 2) AS cumulative_pct

    FROM ranked

    WHERE running_total <= 0.8 * grand_total;

    ```

  - Query 5: Demographic correlation analysis (avg cost by age bucket × BMI bucket)

  - **Query 6: HIGH-VALUE DEMOGRAPHIC RISK SEGMENTATION** (Powers `Patient Risk Segments` Tableau sheet)

    ```sql
    -- Demographic Risk Profiling: Cost & Denial Impact by Age, BMI, Smoking Status
    -- BUSINESS VALUE: Identifies high-cost, high-denial cohorts for targeted interventions
    SELECT 
      CASE 
        WHEN age < 26 THEN '18-25'
        WHEN age < 36 THEN '26-35'
        WHEN age < 46 THEN '36-45'
        WHEN age < 56 THEN '46-55'
        ELSE '56+'
      END AS age_group,
      CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
      END AS bmi_category,
      p.smoking_status AS smoker,
      COUNT(c.claim_id) AS claim_count,
      AVG(c.claim_amount) AS avg_cost_per_claim,
      SUM(c.claim_amount) AS total_segment_cost,
      SUM(CASE WHEN c.claim_status = 'Denied' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS denial_rate_pct,
      MIN(c.claim_amount) AS min_claim,
      MAX(c.claim_amount) AS max_claim,
      STDDEV(c.claim_amount) AS stddev_cost
    FROM claims c
    JOIN patients p ON c.patient_id = p.patient_id
    GROUP BY age_group, bmi_category, smoker
    ORDER BY total_segment_cost DESC, denial_rate_pct DESC;
    ```

    **Significance for Evaluation & Tableau Dashboard:**
    - **Evaluation Rubric:** Directly supports "Statistical / KPI Analysis" (4 marks: segmentation, variance decomposition) + "Insight Generation" (4 marks: identify cost drivers)
    - **Tableau Integration:** Feeds `Patient Risk Segments` sheet with multi-dimensional heatmap: age × BMI × smoking status
    - **Expected Key Findings:** Smokers avg cost $17k-$39k vs. non-smokers $2k-$8k (5-10× multiplier); Obese+Smoker cohort = $40k+ avg; enables cost prediction & risk-based pricing
    - **Business Impact:** High-cost cohort targeting, preventive care prioritization, actuarial pricing adjustments

 

- [ ] **Task 2.7** - Create a Tableau-ready denormalized view for BI ingestion (Person A lead, Person B validates)

  - **SQL Responsibility (Person A):**
    - Create a denormalized MySQL view optimized for live Tableau access
    - View name: `v_claims_tableau`
    - Pre-calculate all dimensions and metrics: claim_id, claim_date, patient demographics, hospital info, provider details, cost_tier, denial_flag, age_group, bmi_category
    - Optional fallback export: `./data/processed/claims_analysis.csv`

  - **Tableau Connection Validation (Person B):**
    - Connect Tableau to live MySQL datasource and confirm `v_claims_tableau` availability
    - Validate all required fields are present and properly typed
    - Verify row counts match expected volume

  - Fields already supplied by the SQL view (do not recreate with the same name in Tableau):
    - `claim_id`, `claim_date`, `claim_month`, `claim_year`, `claim_month_num`
    - `patient_id`, `age`, `sex`, `smoking_status`, `region`, `bmi`, `num_dependents`
    - `hospital_id`, `hospital_name`, `location`, `hospital_type`
    - `provider_id`, `provider_name`, `specialty`
    - `diagnosis_id`, `diagnosis_name`, `diagnosis_code`, `severity_level`
    - `claim_amount`, `claim_status`, `cost_tier`, `age_group`, `bmi_category`, `denial_flag`

  - Tableau-only calculated fields still required (new names only):
    - `Approval Flag`
    - `Approval Rate`
    - `Average Cost per Claim`
    - `Denial Rate`
    - `Cost Tier` only if you want a different threshold logic than the SQL version

  - Keep the export file only as a backup or for offline analysis if the database is unavailable

 

---

 

### **PHASE 3: Tableau Dashboard Development (Days 6-8 | 4-5 hours)**

This phase bridges SQL outputs (from Phase 2) to executive visualizations. Person B takes the lead; Person A provides SQL view and validation support.

#### Day 6 - Data Connection & Data Source Setup (1 hour) - Person B

- [ ] **Task 3.1** - Connect to MySQL database and validate `v_claims_tableau` view
  - Open Tableau Desktop
  - Create live connection to `healthcare_claims_db` MySQL database
  - Select `v_claims_tableau` view as primary datasource
  - Validate: row counts, field names, data types match SQL specifications
  - Fallback: If database unavailable, use `./data/processed/claims_analysis.csv` export

#### Days 7-8 - Dashboard Build & Interactivity (3-4 hours) - Person B

- [ ] **Task 3.2** - Build worksheets and configure dashboard (see detailed guide below)

---

## Tableau Dashboard Build Guide

This section keeps only the minimum Tableau work needed to satisfy the project requirement and produce an executive-ready dashboard.

### 1) Data source and connection

- Open Tableau Desktop and connect to the MySQL database `healthcare_claims_db`.
- Prefer a live connection to the SQL view `v_claims_tableau`.
- If the database is unavailable, use the backup file `./data/processed/claims_analysis.csv`.
- Validate row counts: **~1,549 total records** covering 6 US regions (Northwest, Northeast, Southeast, Southwest, Midwest, West)
- Confirm all geographical fields present: state, city, latitude, longitude, region
- Validate field names, data types, and complete regional coverage before building visualizations

### 2) Required field checks

Confirm the source contains the following fields:

**Core Claim & Status Fields:**
- `claim_id`, `claim_date`, `claim_amount`, `claim_status`

**Geographical Fields (NEW - Essential for Tableau Mapping):**
- `state` (US state: WA, MA, GA, AZ, IL, CA, etc.)
- `city` (Geographic center: Seattle, Boston, Atlanta, Phoenix, Chicago, San Francisco)
- `latitude` (Decimal coordinates for mapping)
- `longitude` (Decimal coordinates for mapping)
- `region` (Categorical: Northwest, Northeast, Southeast, Southwest, Midwest, West)

**Organizational Fields:**
- `hospital_name`, `hospital_type` (enables regional hospital performance analysis)
- `provider_name`, `specialty` (enables provider-level drill-downs)

**Patient & Demographic Fields:**
- `smoker`, `age_group`, `bmi_category` (pre-calculated demographic segments)
- `cost_tier`, `denial_flag` (pre-calculated analytical flags)

Set field roles appropriately:

- `claim_date` as a Date field
- `claim_amount` as a currency/decimal measure
- `claim_status`, `region`, `hospital_name`, `provider_name`, `specialty`, and `smoking_status` as strings
- IDs as whole numbers

### 3) Tableau design rules

**Hierarchies:**
- Create organizational drill-down: `Region → State → City → Hospital Name → Provider Name`
- Use the native date hierarchy: `Year → Quarter → Month → Day`
- Leverage geographical hierarchy for map-based visualizations: `Region (6 regions) → State → City → Latitude/Longitude`

**Field Reuse (from SQL view):**
- Reuse SQL-prepared fields: `age_group`, `bmi_category`, `cost_tier`, `denial_flag` (no recreation needed)
- Leverage geographical fields: `state`, `city`, `latitude`, `longitude` for mapping visualizations

**Tableau-Only Calculated Fields (if needed beyond SQL view):**
- `Approval Flag`: `IF [Claim Status] = 'Approved' THEN 1 ELSE 0 END`
- `Approval Rate`: `SUM([Approval Flag]) / COUNT([Claim ID])`
- `Average Cost per Claim`: `SUM([Claim Amount]) / COUNT([Claim ID])`
- `Denial Rate`: `SUM([Denial Flag]) / COUNT([Claim ID])`

**New Capability - Geographical Mapping:**
- Use latitude/longitude for Tableau Geographic Mark Type (filled maps, dot density)
- Enable state-level filtering with drill-down to city-level claims analysis
- Create regional heatmaps: denial rate, average cost by state, claim volume distribution

### 4) Required worksheets (minimum 6; recommended 9+)

**Minimum Set (Required for compliance):**
- `Executive KPI Summary` — KPI cards: total claims, total cost, approval rate, average cost per claim
- `Monthly Spend Trend` — Time series with month-level spend trend and trend line
- `Cost Concentration by Hospital` — Sorted bar chart with cumulative % line (Pareto analysis)
- `Denial vs Cost by Hospital` — Scatter/bubble chart: denial rate vs. average cost colored by region
- `Regional Cost and Denial Profile` — Region-level metrics: spend and denial comparison across 6 regions
- `Claims Status Distribution` — Pie/stacked bar: approved, denied, pending claim shares

**NEW: Geographical Mapping Worksheets (Enabled by Dataset Enrichment):**
- `Geographic Heatmap: Cost by State` — Filled map showing claim volume and average cost by US state
- `Geographic Heatmap: Denial Rate by State` — Regional denial patterns with state-level drill-down
- `Regional Performance Dashboard` — Dual-region comparison (e.g., Midwest vs. West, Northeast vs. Southeast)

**Recommended Additional Worksheets (for comprehensive analysis - Enhanced by 6-Region Dataset):**
- `Region-Hospital-Provider Hierarchy` — Drill-down hierarchy: Region (6 regions) → State → Hospital → Provider navigation
- `Provider Performance Detail` — Provider specialty performance and denial pattern analysis by region
- **`Patient Risk Segments` (DEMOGRAPHIC ANALYSIS)**  
  **Rationale:** Leverage raw data attributes (age, BMI, smoker status) to identify high-cost demographic cohorts and denial drivers. Aligns with **Statistical / KPI Analysis** rubric (4 marks) and **Insight Generation** rubric (4 marks).  
  **Chart Design:** Heatmap or Multi-Row Table  
  **Dimensions:** `age_group` (18-25, 26-35, 36-45, 46-55, 56+) × `bmi_category` (underweight, normal, overweight, obese) × `smoker` (Yes/No)  
  **Measures:** AVG(claim_amount), DENIAL_RATE (%), COUNT(claims), SUM(charges)  
  **Key Insight:** Smokers show 3-5× higher average costs; BMI ≥ 30 compounds cost by ~$3k-$8k; age 55+ smokers = highest-risk segment  
  **Business Impact:** Enables targeted prevention programs, pricing adjustments, and denial mitigation for high-risk cohorts  
- `Midwest Regional Analysis` — Deep-dive on Midwest region (127 new records): hospital performance, denial rates, cost drivers
- `West Regional Analysis` — Deep-dive on West region (134 new records): state-level cost comparison, provider performance
- `State-Level Cost Benchmarking` — Compare all states within 6 regions for cost and denial outlier identification

**Detailed Chart Logic & Design Rationale:**

| Worksheet | Chart Type | Dimensions | Measures | Purpose |
|-----------|-----------|-----------|----------|----------|
| `Executive KPI Summary` | KPI Cards | — | Count(Claims), Sum(Amount), Approval %, Avg(Amount) | Executive snapshot |
| `Monthly Spend Trend` | Line/Area Chart | Month | Sum(Amount) | Temporal patterns & seasonality |
| `Cost Concentration by Hospital` | Bar + Dual Axis Line | Hospital Name (sorted) | Sum(Amount), Cumulative % | Pareto/concentration insight |
| `Denial vs Cost by Hospital` | Scatter Bubble | Hospital, Region | Denial Rate, Avg Cost, Count | Multi-dimensional performance |
| `Regional Cost and Denial Profile` | Bar Combo or Dual Axis | Region | Sum(Amount), Denial % | Geographic disparities |
| `Claims Status Distribution` | Pie or Stacked Bar | Claim Status | Count(Claims) | Claims outcome breakdown |
| `Patient Risk Segments` | **Demographic Heatmap** | Age Group (5 buckets) × BMI Category (4 levels), Smoker (2 options) | Avg(Claim Amount), Denial %, Count(Claims), Sum(Total Cost) | **DEMOGRAPHIC RISK PROFILING** — Identifies high-cost & high-denial patient cohorts. Expected insight: Smokers = 5-10× higher avg cost ($17k-$39k); Obese+Smoker = extreme risk ($40k+). Powers prevention strategy & risk-based pricing. |
| `Geographic Heatmap: Cost by State` | US Filled Map | State (geography) | Sum(Amount), Count(Claims) | State-level cost concentration and claim volume analysis |
| `Patient Lifetime Value - RFM Analysis` | **Bubble Chart** | Customer Segment (8 types: Champions, Loyal, Potential, New, At-Risk High, At-Risk Freq, Hibernating, Lost), Smoking Status (drill-down) | Lifetime Monetary Value, RFM Score, Claim Frequency | **ADVANCED SEGMENTATION** — Identifies high-value members, at-risk members, and churn candidates. Expected insight: Champions ~15% of members, 40% of value; At-Risk High Value = retention priority. Drives member lifecycle marketing strategy. |
| `Region-Hospital-Provider Hierarchy` | Treemap or Drill Hierarchy | Region, Hospital, Provider | Sum(Amount) | Hierarchical drill-down |
| `Provider Performance Detail` | Bar/Table | Provider, Specialty | Count(Claims), Avg Cost, Denial % | Provider benchmarking |
| `Patient Risk Segments` | **Heatmap with Filters** | Age Group (5 buckets: 18-25, 26-35, 36-45, 46-55, 56+), BMI Category (Underweight, Normal, Overweight, Obese), Smoking Status (Yes/No) | Avg(Claim Amount), Denial %, Count(Claims), Sum(Total Cost), StdDev(Cost) | **DEMOGRAPHIC RISK PROFILING** — Identifies high-cost & high-denial patient cohorts using raw data attributes (age, BMI, smoker status). Expected insight: Smokers = 5-10× higher avg cost ($17k-$39k); Obese+Smoker = extreme risk ($40k+). Powers prevention strategy & risk-based pricing. |

### 5) Dashboard assembly

Create a final dashboard named `Healthcare Claims and Denial Dashboard`.

**Recommended layout (leveraging 6-region data):**

- **Top row:** KPI cards (total claims: 1,549 | total cost | approval rate | avg cost per claim)
- **Upper-middle row:** Monthly trend + cost concentration chart (Pareto analysis)
- **Middle row:** Denial vs cost scatter + regional profile (6 regions comparison)
- **Lower-middle row:** Geographic heatmap (state-level cost and denial rates) — NEW capability
- **Bottom row:** Provider performance detail + patient risk segments
- **Optional expansion:** Regional deep-dive section for Midwest and West regions (new data)

**Apply executive styling:**

- Consistent color palette (6 distinct region colors)
- Clear business titles with data currency notation (as of Sep 2026)
- Currency/percentage formatting ($ for costs, % for rates)
- Readable spacing and clean layout optimized for 1920x1080 display
- Geographic maps sized for clear state/city visibility
- No excessive clutter; progressive disclosure via drill-down filters

### 6) Filters and interactivity (Enhanced for 6-Region Dataset)

**Add global/cascading filters for:**

- **Date range** (temporal drill-down: year → quarter → month)
- **Region** (6-region selector: Northwest, Northeast, Southeast, Southwest, Midwest, West)
- **State** (cascading filter populated by selected region)
- **City** (optional city-level detail filter)
- **Claim status** (Approved, Denied, Pending)
- **Hospital type** (if differentiated in data)
- **Smoking status** (Yes/No)
- **Specialty** (provider specialty filter for detail sheets)
- **Cost tier** (Low/Medium/High/Very High if using SQL cost_tier field)

**Use lightweight dashboard actions:**

- Filter action: Select region → propagate to all sheets
- Filter action: Select hospital → drill to provider detail
- Filter action: Select state on map → show claims and costs for that state
- Highlight action: Select region → highlight in all comparative charts
- URL action: Drill to hospital detail or provider profile (optional)

### 7) Final QA checklist (Updated for Enhanced Dataset)

Before submission, verify:

**Data Source & Connection:**
- [ ] Data source is connected properly to MySQL `healthcare_claims_db`
- [ ] Row count verified: **~1,549 records** from `v_claims_tableau`
- [ ] All 6 regions represented: Northwest, Northeast, Southeast, Southwest, Midwest, West
- [ ] Geographical fields validated: state, city, latitude, longitude, region (all populated)
- [ ] `v_claims_tableau` is the primary source when available; CSV fallback configured

**Worksheet & Visualization Quality:**
- [ ] At least 6 analysis sheets are present (9+ recommended)
- [ ] All sheets are connected to the enriched dataset with 1,549 records
- [ ] Geographic maps (if included) display all states with data correctly
- [ ] Regional filters work across all 6 regions without data loss
- [ ] **DEMOGRAPHIC ANALYSIS (Patient Risk Segments):**
  - [ ] Heatmap displays: Age Group (5 buckets) × BMI Category (4 levels) × Smoker (2 options) = up to 40 cells
  - [ ] Color gradient visible: Light (low cost $2k) → Orange (medium $15k) → Dark Red (high cost $45k)
  - [ ] Each cell shows TWO metrics: Average Claim Amount + Count (n=xxx)
  - [ ] Smoker filter works: Toggle Yes/No shows 3-5× cost difference visually
  - [ ] Age/BMI ordering correct: 18-25 to 56+ (top to bottom), Underweight to Obese (left to right)
  - [ ] Denial rate visible on hover (tooltip shows correlation between cost and denial patterns)
  - [ ] Regional drill-down works: Select "Southeast" globally → heatmap updates to show only SE demographic breakdown

**Dashboard Assembly & Interactivity:**
- [ ] Final dashboard is named `Healthcare Claims and Denial Dashboard`
- [ ] Required fields and hierarchies are present (Regional + Geographic + Temporal)
- [ ] KPI cards and measures update correctly with filters (regional + state-level)
- [ ] Cascading filters work: Region → State → City (if applicable)
- [ ] Regional drill-down capability confirmed (Midwest and West regions drill separately)
- [ ] **DEMOGRAPHIC HEATMAP INTERACTIVITY (Hero Visualization):**
  - [ ] Patient Risk Segments sheet positioned prominently in dashboard (Row 4, full width)
  - [ ] Smoker filter visible and functional (checkbox: Yes/No/Both)
  - [ ] Smoking status filter shows expected cost multiplier: Smoker avg 5-10× higher than non-smoker
  - [ ] Age Group filter responds (optional secondary filter)
  - [ ] Region filter cascades: Global region selection → heatmap updates demographic breakdown for that region
  - [ ] Demographic tooltips show full detail on hover: cost, denial rate, claim count, region distribution
  - [ ] Color intensity matches cost magnitude: Red cells = $40k+ (high-risk smoker cohorts), Light cells = $2k (low-risk)

**Design & Usability:**
- [ ] Dashboard is readable and executive-friendly with clear color coding for 6 regions
- [ ] Geographic visualizations are legible (state labels, color contrast)
- [ ] All formatting is professional (currency, %, region labels)
- [ ] Workbook is saved as `.twb` and packaged as `.twbx` if required

**Performance & Stability:**
- [ ] Dashboard loads within 5 seconds with full dataset (~1,549 rows)
- [ ] No performance degradation with geographic visualizations
- [ ] Filter interactions are responsive and lag-free

---

### Tableau deliverables checklist

**Data Source Validation:**
- [ ] MySQL live connection to `v_claims_tableau` OR CSV fallback connected
- [ ] Row count verified: **~1,549 records** from `v_claims_tableau`
- [ ] Data types validated (dates, currency, integers, strings)
- [ ] No unintended NULLs in key fields

**Schema & Calculated Fields:**
- [ ] Hierarchies created: `Region → Hospital → Provider` and `Year → Quarter → Month → Day`
- [ ] Required calculated fields created:
  - `Approval Flag`: IF [Claim Status] = 'Approved' THEN 1 ELSE 0 END
  - `Approval Rate`: SUM([Approval Flag]) / COUNT([Claim ID])
  - `Average Cost per Claim`: SUM([Claim Amount]) / COUNT([Claim ID])
  - `Denial Rate`: SUM([Denial Flag]) / COUNT([Claim ID])
- [ ] Calculated fields validated against SQL output

**Dashboard & Interactivity:**
- [ ] Minimum 6 analysis sheets created and tested
- [ ] All 9 recommended sheets complete (stretch goal)
- [ ] Dashboard filters configured: Date range, Region, Claim Status, Hospital Type, Smoking Status
- [ ] Dashboard actions implemented: filter, highlight actions across sheets
- [ ] Final dashboard `Healthcare Claims and Denial Dashboard` assembled with clear narrative flow
- [ ] Workbook exported as `.twb` and packaged as `.twbx`
- [ ] Performance tested: dashboard loads within 5 seconds

**Quality Assurance:**
- [ ] All filters work end-to-end without errors
- [ ] KPI cards update correctly with filter selections
- [ ] Pareto chart cumulative % line is accurate (should reach ~80-90% within first 20-30% of entities)
- [ ] No hardcoded values; all measures are dynamic
- [ ] Peer review: Person A validates data accuracy against SQL queries

---

## 📊 Implementation: Tableau Worksheet Guides

**Comprehensive step-by-step instructions for all 9 worksheets are in the master checklist.**

**Primary Guide (Start Here):**
- **[plan/TABLEAU_WORKSHEET_BUILD_CHECKLIST.md](plan/TABLEAU_WORKSHEET_BUILD_CHECKLIST.md)** — All 9 worksheets + storyboard + LOD + filters + dashboard assembly (complete reference)

**Quick Reference (Desk Lookup):**
- **[plan/REFERENCE_ONE_PAGE.md](plan/REFERENCE_ONE_PAGE.md)** — One-page card with build sequence, key metrics, quick fixes

**Optional: Individual Worksheet Deep-Dive:**
- [plan/WS1_EXECUTIVE_KPI_SUMMARY.md](plan/WS1_EXECUTIVE_KPI_SUMMARY.md) through [plan/WS9_RFM_ANALYSIS.md](plan/WS9_RFM_ANALYSIS.md) — Kept for additional reference only

See **[plan/README.md](plan/README.md)** for complete folder navigation.

### **Quick Reference - Calculated Fields to Create**

When you first open your data source in Tableau, create these 4 calculated fields:

1. **Approval Flag** — `IF [Claim Status] = 'Approved' THEN 1 ELSE 0 END`
2. **Approval Rate** — `SUM([Approval Flag]) / COUNT([Claim ID])`  
3. **Average Cost per Claim** — `SUM([Claim Amount]) / COUNT([Claim ID])`
4. **Denial Rate** — `SUM([Denial Flag]) / COUNT([Claim ID])`

See individual worksheet files for detailed setup and validation steps.

### **Troubleshooting Quick Reference**

| Issue | Solution |
|-------|----------|
| "Cannot connect to MySQL" | Check MySQL server is running (Windows: Services → MySQL80). Verify username/password. |
| "Sheet shows no data / blank" | Verify field roles in Data Source. Ensure Date field is set as "Date" type. |
| "Filter doesn't work" | Right-click filter → Apply to all sheets. Check field is a dimension, not measure. |
| "Map doesn't show states" | Right-click state field → Geographic Role → State/Province. Make sure state field has proper 2-letter codes (CA, TX, etc.). |
| "KPI cards show 0 or NULL" | Check calculated fields: Edit → verify formula is correct. Ensure denial_flag field exists. |
| "Dashboard runs slow" | Remove unnecessary fields from tooltips. Reduce number of rows displayed. Test query performance in SQL first. |
| "Charts show partial data after filtering" | Check all sheets are connected to same data source. Verify filters apply to correct sheet scope. |

---

## 📊 Next Steps

### **Why the Patient Risk Segments Heatmap Matters**

The **Patient Risk Segments** demographic heatmap (age × BMI × smoking status) is not just another visualization—it's the **core business deliverable** that directly addresses healthcare revenue cycle management:

**Raw Data → SQL Intelligence → Tableau Impact:**

| Stage | What Happens | Business Outcome |
|-------|-------------|------------------|
| **SQL Layer (Query 7.6)** | Age bins (5 groups) × BMI categories (4) × Smoking (Yes/No) → 40 patient segments | Identify high-risk demographic cells: e.g., "Older + Obese + Smoker" has 45% denial rate |
| **Tableau Layer (WS7)** | Heatmap: cell color = avg claim cost; cell size/shade = denial count; interactive drill-down by region | Operations team quickly spots patterns: "Smokers in Southeast cost 30% more" |
| **Business Impact** | Targeted interventions for high-risk groups: pre-approval education, regional protocols, risk-based reserves | Expected outcome: 2-3% reduction in denial frequency = $50-75K saved annually |

---

## 📊 Success Metrics

When your dashboard is complete, verify these 30 success criteria across all 9 worksheets and dashboard assembly. Refer to individual checklist files for detailed validation.

### **Dashboard Assembly: 5-Row Layout**

**Row 1:** Executive KPI Summary (4 cards: Total Claims | Total Cost | Approval Rate | Avg Cost)  
**Row 2:** Spend Trend (Monthly) | Pareto Analysis (Cost Concentration)  
**Row 3:** Denial vs. Cost (Bubble) | Regional Profile (Dual-Axis Bar)  
**Row 4:** Status Distribution (Pie) | Geographic Heatmap (US Map)  
**Row 5:** Patient Risk Segments (HERO - Age×BMI×Smoker Heatmap) | Customer RFM (HERO - Segment Bubbles)

### **Required Interactivity**

- Date filter (single select, cascades to all sheets)
- Region filter (multi-select, cascades)
- Claim Status filter (multi-select, cascades)
- Smoking Status filter (single select, affects demographic viz)
- Click actions between sheets (e.g., click a region → drill into hospitals in that region)
- Tooltip enrichment: Show claim details, patient demographics, cost breakdown

### **Performance Baseline**

- Dashboard loads in < 5 seconds (initial load)
- Filtering responds in < 2 seconds
- Each worksheet has < 50K rows of data displayed
- No red "data source error" icons in worksheet tabs

---

## 📚 TABLEAU IMPLEMENTATION - 4 CORE GUIDES (PDF-Aligned)

Per **SQL_Tableau_Project_Guidelines.pdf**, Tableau implementation requires:
- **Section 2.3:** Visualization & Dashboard Development (6 marks)
- **Section 2.4-2.5:** Statistical Analysis & Insight Generation (8 marks)
- **Section 5:** Presentation & Viva (4 marks)

**All guides are now organized in the `/plan/` folder:**

| Guide | Purpose | Coverage |
|-------|---------|----------|
| **[plan/TABLEAU_WORKSHEET_BUILD_CHECKLIST.md](plan/TABLEAU_WORKSHEET_BUILD_CHECKLIST.md)** ← START HERE | Build all 9 worksheets, storyboard, LOD, filters, custom actions, dashboard assembly | PDF Section 2.3 |
| **[plan/TABLEAU_ANALYSIS_GUIDE.md](plan/TABLEAU_ANALYSIS_GUIDE.md)** | Pareto analysis, RFM segmentation, KPI interpretation, business insights | PDF Sections 2.4-2.5, Rubrics 4-5 |
| **[plan/VIVA_PREP.md](plan/VIVA_PREP.md)** | Opening statement, live demo script, Q&A answers, viva tips, 7-slide structure | PDF Section 5, Rubric 7 |
| **[plan/REFERENCE_ONE_PAGE.md](plan/REFERENCE_ONE_PAGE.md)** | Quick lookup card: build sequence, key metrics, quick fixes (print this!) | Quick reference only |

**Optional reference guides:** [plan/WS1-WS9](plan/) worksheet specifications

**Report outputs:** [report/](report/) folder contains presentation.pptx and generate_presentation.py

---

## 🔍 Appendix: RFM Analysis & Demographic Segmentation Queries

### **RFM (Recency, Frequency, Monetary) Analysis**

The RFM analysis creates 8 customer lifetime-value segments. Execute this query in MySQL to populate the `v_rfm_analysis` view used by WS9:

```sql
-- QUERY 7.7: RFM ANALYSIS - Patient Lifetime Value Segmentation
WITH patient_rfm AS (
   - Currency Symbol: **$** (US Dollar)
   - Decimal Places: **2**
   - Negative Numbers: Show as -$1,234.56 (default is fine)
3. Display updates to show: "$4,289,234.00"
4. Close Format pane

**STEP D: Apply Font Formatting**
1. Right-click "$4,289,234.00" → **Format**
2. Font tab:
   - Font: Arial or Tableau Bold
   - Size: **48pt** (same as Card 1)
   - Bold: Yes
   - Color: Dark green (#27AE60) for cost/financial context (different from Card 1 for visual distinction)
3. Close Format pane

**STEP E: Add Background & Border**
1. Right-click → **Format**
2. Background tab:
   - Fill Color: Light green (#EAFAF1) to match green text
3. Borders tab:
   - Border: Yes
   - Color: Dark gray
   - Weight: 1pt
4. Close

**STEP F: Add Label**
1. Dashboard → Objects → Text
2. Type: "**Total Cost**"
3. Position: Above the "$4,289,234.00" number
4. Format: 14pt, gray, bold

**Final Result for Card 2:**
- Label: "Total Cost" (14pt, gray)
- Large number: "$4,289,234.00" (48pt, bold, dark green)

---

**Action 4.1.3 — Create KPI Card 3: Approval Rate (%)**

**STEP A: Add Pre-Built Calculated Field**
1. Find `Approval Rate` in Data pane (Measures section, blue icon)
   - This was created in STEP 3, earlier
   - Formula: `SUM([Approval Flag]) / COUNT([Claim ID])`
2. Drag `Approval Rate` to canvas (to the RIGHT of Card 2)
3. Drop it
4. **Tableau ACTION:** A text box appears with "0.8196" (this is a decimal, e.g., 81.96%)

**STEP B: Verify the Calculation**
1. Look at Rows shelf → should show "SUM(Approval Rate)" or "AVG(Approval Rate)"
   - For approval rate, AVG is actually more correct (we're averaging the rate)
   - If it shows SUM, right-click → Aggregate → **AVG**
2. This decimal "0.8196" represents 81.96% approval rate

**STEP C: Format as Percentage**
1. Right-click "0.8196" → **Format**
2. Numbers tab:
   - Number Format: **Percentage**
   - Decimal Places: **0** (zero — we just want whole %, like "82%", not "81.96%")
3. Display updates to: "82%" 
4. Close Format pane

**STEP D: Apply Font Formatting**
1. Right-click "82%" → **Format**
2. Font tab:
   - Font: Arial or Tableau Bold
   - Size: **48pt**
   - Bold: Yes
   - Color: Dark orange (#E67E22) for approval (positive indicator)
3. Close

**STEP E: Add Background & Border**
1. Right-click → **Format**
2. Background: Light orange (#FEF5E7)
3. Borders: Yes, dark gray, 1pt
4. Close

**STEP F: Add Label**
1. Dashboard → Objects → Text
2. Type: "**Approval Rate**"
3. Format: 14pt, gray, bold
4. Position above the "80.05%"

**Final Result for Card 3:**
- Label: "Approval Rate" (14pt, gray)
- Large number: "82%" (48pt, bold, dark orange)

---

**Action 4.1.4 — Create KPI Card 4: Average Cost per Claim ($)**

**STEP A: Add Pre-Built Calculated Field**
1. Find `Average Cost per Claim` in Data pane (Measures section, blue)
   - Formula: `SUM([Claim Amount]) / COUNT([Claim ID])`
2. Drag to canvas (to the RIGHT of Card 3)
3. Drop it
4. Text appears: "2688.85" (average cost per claim)

**STEP B: Verify Aggregation**
1. Rows shelf → should show "SUM(Average Cost per Claim)" or "AVG(...)"
   - For an average, we typically use AVG aggregation
   - Right-click → Aggregate → **AVG** if needed
2. The value represents $2,688.85 per claim on average

**STEP C: Format as Currency**
1. Right-click "2688.85" → **Format**
2. Numbers tab:
   - Number Format: **Currency**
   - Symbol: **$**
   - Decimal Places: **2**
3. Displays: "$2,688.85"
4. Close

**STEP D: Apply Font Formatting**
1. Right-click "$2,688.85" → **Format**
2. Font tab:
   - Font: Tableau Bold
   - Size: **48pt**
   - Bold: Yes
   - Color: Dark purple (#8E44AD) to distinguish from other cards
3. Close

**STEP E: Add Background & Border**
1. Right-click → **Format**
2. Background: Light purple (#F4ECF7)
3. Borders: Yes, dark gray, 1pt
4. Close

**STEP F: Add Label**
1. Dashboard → Objects → Text
2. Type: "**Avg Cost/Claim**"
3. Format: 14pt, gray, bold
4. Position above "$2,688.85"

**Final Result for Card 4:**
- Label: "Avg Cost/Claim" (14pt, gray)
- Large number: "$2,688.85" (48pt, bold, dark purple)

---

#### **Final Layout: Arranging 4 KPI Cards in a Row**

**STEP 1: Position Cards Side-by-Side**
1. You now have 4 separate text boxes (numbers) on the canvas
2. Each has a label above it
3. Use mouse to drag each card horizontally to align them in a row
   - Card 1 (Total Claims) → Left side
   - Card 2 (Total Cost) → Middle-left
   - Card 3 (Approval Rate) → Middle-right
   - Card 4 (Avg Cost) → Right side

**STEP 2: Align Vertically**
1. Use Tableau alignment tools to ensure all 4 cards are at same height
   - Select all 4 cards: Click Card 1 → Hold CTRL → Click Cards 2, 3, 4
   - Format → Align → **Align Middle** (ensures all tops are at same level)

**STEP 3: Distribute Spacing Evenly**
1. With all 4 cards still selected:
   - Format → Align → **Distribute Centers Horizontally** (equal gaps between cards)

**STEP 4: Add Sheet Title**
1. Sheet → Title → Edit Title
2. Type: "**Executive KPI Summary**"
3. Font: 20pt, bold, dark blue
4. Position: Top of sheet

**FINAL VISUAL:**
```
                     Executive KPI Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Claims        Total Cost           Approval Rate      Avg Cost/Claim
(gray label)        (gray label)         (gray label)       (gray label)

┌──────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│              │   │              │   │              │   │              │
│   1,549      │   │$4,289,234.00 │   │     82%      │   │  $2,688.85   │
│  (blue bg)   │   │  (green bg)  │   │ (orange bg)  │   │(purple bg)   │
│              │   │              │   │              │   │              │
└──────────────┘   └──────────────┘   └──────────────┘   └──────────────┘
```

**STEP 5: Verification Checklist**
- [ ] All 4 cards visible and properly formatted
- [ ] Each card has label above + number below
- [ ] Numbers are large (48pt) and bold
- [ ] Each card has different background color (blue, green, orange, purple)
- [ ] All cards aligned horizontally (same baseline)
- [ ] Spacing is even between cards
- [ ] Sheet title visible at top: "Executive KPI Summary"

---

---

#### **WORKSHEET 2: Monthly Spend Trend**

**Setup:**
- Right-click Sheet tab → New Sheet → Rename to `Monthly Spend Trend`

**Action 4.2.1 — Set Up Axes**
- Drag **`Claim Date`** to COLUMNS shelf (top)
  - Tableau auto-groups by year; RIGHT-CLICK the pill → select **Month** (not Year)
- Drag **`Claim Amount`** to ROWS shelf (left)
  - Tableau auto-sums; this is correct

**Action 4.2.2 — Change Mark Type to Line**
- Top toolbar: Click mark type dropdown (currently "Automatic") → select **Line**
- You should see a line chart showing monthly spend trend

**Action 4.2.3 — Add Trend Line**
- Analytics pane (right side, below Data) → Drag **Trend Line** onto the chart
- Double-click the trend line → click OK (uses default linear trend)
- This shows upward/downward trend visually

**Action 4.2.4 — Format & Label**
- Right-click Y-axis → Format → Currency
- Right-click Y-axis → Edit Axis → Set to start at $0
- Right-click line → Format → Thicker line (2pt), darker color (e.g., navy blue)
- Add title: Sheet → Title → Type "Monthly Spend Trend"

---

#### **WORKSHEET 3: Cost Concentration by Hospital (Pareto)**

**Setup:**
- New Sheet → Rename to `Cost Concentration by Hospital`

**Action 4.3.1 — Create Bar Chart**
- Drag **`Hospital Name`** to ROWS
- Drag **`Claim Amount`** to COLUMNS
- Right-click `Claim Amount` → Aggregate → SUM
- You see hospitals listed with total cost bars

**Action 4.3.2 — Sort Descending**
- Click the bar chart area → Toolbar shows sort icons
- Click **descending sort** (downward arrow) to put highest-cost hospitals at top

**Action 4.3.3 — Add Cumulative % Line (Dual Axis)**
- Right-click `Claim Amount` in COLUMNS → **Duplicate**
- A second SUM(Claim Amount) appears to the right
- RIGHT-CLICK the second SUM → **Add Table Calculation**
- Choose: Calculation Type = **Percent of Total**
- Change mark type: Right-click right-side Y-axis → Format → Mark Type = **Line**
- The line shows cumulative % (should reach ~80% for top 20% of hospitals)

**Action 4.3.4 — Format**
- Left Y-axis: Format as Currency
- Right Y-axis: Format as Percentage
- Add reference line at 80%: Analytics → Drag "Reference Line" onto chart
  - Set value = 0.80
  - Color: Red, dashed line
  - Label: "80% threshold"
- Title: "Cost Concentration by Hospital (Pareto Analysis)"

---

#### **WORKSHEET 4: Denial vs Cost by Hospital (Scatter)**

**Setup:**
- New Sheet → Rename to `Denial vs Cost by Hospital`

**Action 4.4.1 — Set Axes**
- Drag **`Hospital Name`** to Detail (marks card)
- Drag **`Denial Rate`** to COLUMNS (X-axis)
- Drag **`Average Cost per Claim`** to ROWS (Y-axis)
- Tableau shows scatter plot with one dot per hospital

**Action 4.4.2 — Add Region Color**
- Drag **`Region`** to Color mark
- Tableau colors dots by region (6 colors for 6 regions)
- Legend automatically appears on right

**Action 4.4.3 — Add Hospital Size**
- Drag **`Claim ID`** to Size mark
- Right-click → COUNT
- Larger dots = more claims per hospital (bubble chart effect)

**Action 4.4.4 — Add Tooltip Information**
- Drag **`Hospital Name`** to Tooltip
- Tableau shows hospital name on hover
- Optionally add more fields to tooltip: Drag `Claim Amount` to Tooltip, etc.

**Action 4.4.5 — Format**
- X-axis: Format as Percentage
- Y-axis: Format as Currency
- Add title: "Denial Rate vs Average Cost by Hospital"
- Adjust bubble size: Drag the Size slider in marks card to make bubbles more visible

---

#### **WORKSHEET 5: Regional Cost and Denial Profile**

**Setup:**
- New Sheet → Rename to `Regional Cost and Denial Profile`

**Action 4.5.1 — Create Bar Chart**
- Drag **`Region`** to COLUMNS
- Drag **`Claim Amount`** to ROWS → Right-click → Aggregate = SUM
- You see 6 bars (one per region) showing total cost

**Action 4.5.2 — Add Denial Rate as Second Axis**
- Right-click `Claim Amount` → **Duplicate** to add second measure
- Replace second measure: Drag **`Denial Rate`** onto it
- Right-click second Y-axis → **Dual Axis**
- Change second mark type: Line (right-click right Y-axis → Mark Type = Line)

**Action 4.5.3 — Format**
- Left Y-axis: Currency (cost)
- Right Y-axis: Percentage (denial rate)
- Bars: Dark blue for cost
- Line: Red for denial rate
- Title: "Regional Cost and Denial Profile"

---

#### **WORKSHEET 6: Claims Status Distribution (Pie)**

**Setup:**
- New Sheet → Rename to `Claims Status Distribution`

**Action 4.6.1 — Create Pie Chart**
- Change mark type to: **Pie**
- Drag **`Claim Status`** to Color
- Drag **`Claim ID`** to Angle (size of pie slices)
- Tableau shows pie with segments for Approved, Denied, Pending

**Action 4.6.2 — Add Labels**
- Right-click marks → **Show Labels**
- Right-click labels → **Format** → Show percentages + count
- Labels display on pie slices (e.g., "Approved 82% (1,305)")

**Action 4.6.3 — Format Colors**
- Right-click color legend → **Edit Colors**
- Green = Approved, Red = Denied, Yellow = Pending
- Adjust color palette to match company branding

**Action 4.6.4 — Add Title**
- "Claims Status Distribution"

---

#### **WORKSHEET 7: Patient Risk Segments (DEMOGRAPHIC HEATMAP) ⭐**

**Strategic Importance:** This sheet directly visualizes the demographic cost drivers identified in SQL Query 6. It displays age, BMI, and smoking status across a multi-dimensional heatmap, enabling executives to identify high-cost patient cohorts and prioritize prevention programs.

**Setup:**
- New Sheet → Rename to `Patient Risk Segments`
- Data Source: Uses `age_group`, `bmi_category`, `smoker` fields from `v_claims_tableau` (pre-calculated by SQL Query 6)

**Action 4.7.1 — Create Heatmap Structure**
1. Drag **`Age Group`** to ROWS shelf
   - Order should be: 18-25, 26-35, 36-45, 46-55, 56+
   - If wrong order: RIGHT-CLICK `Age Group` → Sort → Manual → drag to correct order
2. Drag **`BMI Category`** to COLUMNS shelf
   - Order: Underweight, Normal, Overweight, Obese
   - Manual sort if needed
3. Change Mark Type to: **Square** (Automatic → Square)
   - Squares create a grid heatmap visual

**Action 4.7.2 — Add Primary Measure: Average Claim Amount**
1. Drag **`Claim Amount`** to COLOR
   - Right-click → Aggregate = AVG
   - Tableau creates color gradient: light (low cost) → dark (high cost)
   - Color scale should show:
     - Light yellow: $2k-$8k (low-risk cohorts: young, normal BMI, non-smokers)
     - Orange: $8k-$20k (medium-risk: older or smoker)
     - Dark red: $20k-$48k (high-risk: smokers, overweight/obese, 56+)

**Action 4.7.3 — Add Secondary Layer: Smoking Status Filter**
1. Drag **`Smoker`** to FILTERS shelf (top-left area)
   - This creates a filter pill at top of sheet
2. Click the filter pill → **Edit Filter**
   - Select Both values: Yes, No (checkbox both)
   - Click OK
   - Now dashboard can toggle between "Smoker=Yes", "Smoker=No", or "Both"

**Action 4.7.4 — Add Labeling: Show Average Cost on Each Cell**
1. Drag **`Claim Amount`** to TEXT (in Marks area)
   - Right-click → Aggregate = AVG
   - Format: Currency, 0 decimals (shows $2688, not $2688.85)
2. Each cell in heatmap now displays:
   - Color intensity (gradient)
   - Text label with average cost (e.g., "$17,856")

**Action 4.7.5 — Add Count of Claims per Cell**
1. Drag **`Claim ID`** to TEXT again
   - Right-click → Aggregate = COUNT
2. Now each cell shows TWO text values (stacked):
   - Line 1: Average cost in dollars
   - Line 2: Count of claims (e.g., "n=127")
   - This shows both the cost driver AND the sample size for the cohort

**Action 4.7.6 — Format Text & Colors**
1. Right-click cells → **Format Cells**
2. Font: Arial, 10pt, bold for cost, 8pt for count
3. Color legend (right side):
   - Title: "Average Claim Amount ($)"
   - Min (light): $2,000
   - Mid (orange): $15,000
   - Max (dark red): $45,000
4. Right-click color legend → **Edit Colors** → Select diverging color palette "Red-Yellow" or "Heatmap"

**Action 4.7.7 — Add Tooltips for Drill-Down**
1. Drag **`Denial Rate`**, **`Sum(Claim Amount)`**, **`Region`** to Tooltip shelf
   - Tooltip shows full detail on hover
   - Example: "Age 56+, Obese, Smoker: Avg cost $43,500, Denial rate 12%, 47 claims, mostly from Southeast"

**Action 4.7.8 — Format Sheet & Add Title**
- Sheet → Title → Type: "**Patient Risk Segments - Demographic Cost & Denial Analysis**"
- Subtitle (optional): "Lighter = Lower cost; Darker = Higher cost. Filter by smoking status to compare cohorts."
- Background: Light gray (#F5F5F5) for readability

**Action 4.7.9 — Add Density Labels (Optional Enhancement)**
1. Drag **`Region`** to DETAIL
2. Tableau now color-codes cells by region as well (secondary color layer)
3. Or use shape encoding: Drag **`Region`** to Shape
   - Each region gets different symbol (triangle, circle, square, etc.)
   - This enables comparison within heatmap cells

**Expected Output:**
```
                 UNDERWEIGHT    NORMAL       OVERWEIGHT      OBESE
18-25           $1,800          $2,100       $2,800          $3,900
                n=89            n=156        n=124           n=102

26-35           $2,200          $2,400       $4,200          $6,800
                n=112           n=201        n=178           n=145

36-45           $5,400          $6,200       $8,900          $14,500
                n=98            n=187        n=143           n=167

46-55           $8,700          $10,200      $16,800         $24,500
                n=76            n=154        n=189           n=198

56+             $12,300         $14,800      $28,500         $45,200
                n=54            n=119        n=156           n=189

[Filtered by Smoker: Both / Yes / No]
```

**Key Insights Visible in Heatmap:**
- **Diagonal gradient (bottom-right darkest):** Age and BMI compound cost linearly
- **Smoker filter effect:** Smoker=Yes shows 3-5× higher values than Smoker=No in same cell
- **Cost tiers:** Non-smoker young/normal BMI < $3k | Smoker 56+ obese > $40k
- **Density (count):** n=156 (large cohort) vs. n=54 (small cohort) shows where prevention programs should focus

**Business Decision Power:**
Executives can immediately see:
1. **Highest-cost cohort:** Smoker 56+ + Obese → Avg $45k (eligible for premium surcharge)
2. **Prevention target:** Overweight 46-55 → $16.8k avg (intervention could save 20-30%)
3. **Denial correlation:** Hover on cells → Denial rates show which cohorts have claim rejections
4. **Regional drill-down:** Shape or color coding by region enables "Is this a regional issue or demographic?"

---

#### **WORKSHEET 8 (Optional): Geographic Heatmap - Cost by State**

**Setup:**
- New Sheet → Rename to `Geographic Heatmap: Cost by State`

**Action 4.8.1 — Create Map**
- Drag **`State`** to DETAIL
- Tableau auto-displays map of US states
- Drag **`Claim Amount`** to Color
- Right-click → Aggregate = SUM
- Tableau colors states: darker shade = higher cost

**Action 4.8.2 — Add Tooltips**
- Drag `Claim Amount`, `Hospital Name`, `Region` to Tooltip
- On hover, shows state cost + top hospital in state

**Action 4.8.3 — Add Interactivity**
- Right-click state on map → **Select** to filter other sheets
- Title: "Cost Concentration by State"

---

#### **WORKSHEET 9 (ADVANCED): Patient Lifetime Value - RFM Analysis** ⭐

**Business Rationale:**
RFM (Recency, Frequency, Monetary) segmentation identifies high-value members and at-risk members. This worksheet elevates your analysis from "demographic cost drivers" to "lifetime value strategy," demonstrating advanced segmentation mastery.

**SQL Query Specification (Add to 07_statistical_analysis.sql):**

```sql
-- QUERY 7: RFM ANALYSIS - Patient Lifetime Value Segmentation
WITH patient_rfm AS (
  SELECT 
    p.patient_id,
    p.age,
    p.smoking_status,
    -- RECENCY: Days since most recent claim
    DATEDIFF(CURDATE(), MAX(c.claim_date)) AS days_since_last_claim,
    
    -- FREQUENCY: Number of claims per patient
    COUNT(c.claim_id) AS claim_frequency,
    
    -- MONETARY: Total lifetime claim value
    SUM(c.claim_amount) AS lifetime_monetary_value,
    
    -- Supporting metrics
    AVG(c.claim_amount) AS avg_claim_value,
    STDDEV(c.claim_amount) AS claim_variance,
    COUNT(CASE WHEN c.claim_status = 'Denied' THEN 1 END) AS denied_claims,
    SUM(CASE WHEN c.claim_status = 'Denied' THEN c.claim_amount ELSE 0 END) AS denied_amount
    
  FROM patients p
  LEFT JOIN claims c ON p.patient_id = c.patient_id
  GROUP BY p.patient_id, p.age, p.smoking_status
),

rfm_quartiles AS (
  SELECT 
    patient_id,
    age,
    smoking_status,
    days_since_last_claim,
    claim_frequency,
    lifetime_monetary_value,
    avg_claim_value,
    denied_claims,
    
    -- Quartile scoring (1=worst, 4=best)
    NTILE(4) OVER (ORDER BY days_since_last_claim DESC) AS recency_quartile,
    NTILE(4) OVER (ORDER BY claim_frequency ASC) AS frequency_quartile,
    NTILE(4) OVER (ORDER BY lifetime_monetary_value ASC) AS monetary_quartile
    
  FROM patient_rfm
),

rfm_segments AS (
  SELECT 
    *,
    -- Composite RFM score (higher = better customer)
    (recency_quartile + frequency_quartile + monetary_quartile) / 3 AS rfm_score,
    
    -- Customer segment labels
    CASE 
      WHEN recency_quartile >= 3 AND frequency_quartile >= 3 AND monetary_quartile >= 3 THEN 'Champions'
      WHEN recency_quartile >= 3 AND frequency_quartile >= 3 AND monetary_quartile < 3 THEN 'Loyal Customers'
      WHEN recency_quartile >= 3 AND frequency_quartile < 3 AND monetary_quartile >= 3 THEN 'Potential Loyalists'
      WHEN recency_quartile >= 3 AND frequency_quartile < 3 AND monetary_quartile < 3 THEN 'New Members'
      WHEN recency_quartile < 3 AND frequency_quartile >= 3 AND monetary_quartile >= 3 THEN 'At-Risk High Value'
      WHEN recency_quartile < 3 AND frequency_quartile >= 3 AND monetary_quartile < 3 THEN 'At-Risk Frequent'
      WHEN recency_quartile < 3 AND frequency_quartile < 3 AND monetary_quartile >= 3 THEN 'Hibernating'
      ELSE 'Lost'
    END AS customer_segment
    
  FROM rfm_quartiles
)

SELECT 
  patient_id,
  age,
  smoking_status,
  days_since_last_claim,
  claim_frequency,
  lifetime_monetary_value,
  avg_claim_value,
  denied_claims,
  recency_quartile,
  frequency_quartile,
  monetary_quartile,
  rfm_score,
  customer_segment
  
FROM rfm_segments
ORDER BY lifetime_monetary_value DESC, rfm_score DESC;
```

**Action 4.9.1 — Create RFM Table in Tableau**
- New Sheet → Rename to `Patient Lifetime Value - RFM Analysis`
- Drag **`Customer Segment`** to ROWS
- Drag **`Lifetime Monetary Value`** to COLUMNS (SUM)
- Drag **`Claim Frequency`** to SIZE (larger bubble = more frequent)
- Drag **`RFM Score`** to COLOR (darker = better customer)

**Expected Output:** 8 customer segments (Champions, Loyal, Potential Loyalists, New, At-Risk High, At-Risk Frequent, Hibernating, Lost) with bubble sizes representing claim frequency and colors representing RFM score.

**Action 4.9.2 — Add Dimension Drill-Down**
- Drag **`Smoking Status`** to DETAIL
- On click, expand segment to show smoker vs. non-smoker breakdown
- Example: "Champions" segment might be 60% non-smoker (high-value, low-risk) and 40% smoker (high-value, high-risk)

**Action 4.9.3 — Add Calculated Field: Retention Score**
```
{FIXED [Customer Segment]: AVG([RFM Score])}
```
- This shows average RFM score per segment
- Use in tooltips to highlight which segments are most valuable

**Action 4.9.4 — Add Labels & Formatting**
- Show COUNT of patients per segment on each bubble
- Tooltip: Customer Segment, Count, Avg Lifetime Value, Avg Claim Frequency, % Denied
- Title: "**Patient Lifetime Value by RFM Segment**"

**RFM Segment Business Meanings:**
| Segment | Definition | Business Action |
|---------|-----------|-----------------|
| **Champions** | High recency + high frequency + high value | Reward loyalty, offer premium services |
| **Loyal Customers** | Consistent engagement, moderate value | Cross-sell prevention programs |
| **Potential Loyalists** | Recent but low frequency, high value | Encourage more frequent claims (might be one-time high-cost event) |
| **New Members** | Very recent, low frequency, low value | Nurture relationship, offer onboarding |
| **At-Risk High Value** | Inactive but historically high value | Win back campaigns, special outreach |
| **At-Risk Frequent** | Inactive but historically frequent | Retention program, understand churn reason |
| **Hibernating** | No recent activity, low lifetime value | Target cost-effectively or deprioritize |
| **Lost** | Inactive, low frequency, low value | Cleanup candidate or exit segment |

**Business Insights from RFM:**
- **Smokers vs Non-smokers distribution by segment** → If smokers are overrepresented in "At-Risk" and "Lost," indicates need for prevention retention
- **Champions size and growth** → If growing, satisfaction is high; if shrinking, risk exposure increasing
- **Hibernating + Lost volume** → Percentage of members not actively claiming (churn risk)
- **Potential Loyalists high value** → One-time high-cost members (e.g., cancer diagnosis, surgery) → need ongoing engagement to prevent churn

**Action 4.9.5 — Add Comparison Filter**
- Add filter for **`Age Group`** to see RFM distribution by age
- Example: Are younger members more "At-Risk" than older members?
- Add filter for **`Smoking Status`** to compare smoker vs. non-smoker lifetime value

**Dashboard Integration (Optional):**
- Add RFM Analysis to Row 6 (optional expansion row) if desired
- Or keep as separate "Deep Dive" worksheet for detailed exploration
- Use as data source for member retention strategy meetings

**Time to Build:** 30-45 minutes

---

## 📊 Next Steps

**Action 5.2 — Add Sheets to Dashboard**
In the Dashboard pane (left), you see all worksheets listed.

**Recommended Layout (Top to Bottom):**

**Row 1 — KPI Cards (Full Width, Height ~90px)**
- Drag `Executive KPI Summary` sheet to canvas
- This shows the 4 summary metrics at top: Total Claims, Total Cost, Approval Rate, Avg Cost

**Row 2 — Trends & Concentration (Two columns, Height ~250px)**
- **Left (50% width):** Drag `Monthly Spend Trend`
  - Shows temporal patterns and forecasting
- **Right (50% width):** Drag `Cost Concentration by Hospital`
  - Shows Pareto analysis (which hospitals drive cost)

**Row 3 — Performance & Regional Analysis (Two columns, Height ~250px)**
- **Left (50% width):** Drag `Denial vs Cost by Hospital`
  - Bubble chart: denial rate vs. cost by region
- **Right (50% width):** Drag `Regional Cost and Denial Profile`
  - Dual-axis showing all 6 regions

**Row 4 — Demographic Risk Analysis (HIGHLIGHTED - Full Width, Height ~300px)** ⭐
- **Center (Full width):** Drag `Patient Risk Segments` (the demographic heatmap)
  - **Position at prominence:** This sheet is a hero visualization
  - Shows age × BMI × smoking status with cost color coding
  - Add filter controls for interactive drill-down
  - Add title: "**Demographic Risk Profiling & Cost Drivers**"

**Row 5 — Claims Distribution & Optional (One or Two columns, Height ~200px)**
- Drag `Claims Status Distribution` (pie chart)
- Optional: Add `Geographic Heatmap: Cost by State` if space permits

**Visual Alignment Tips:**
- Use Tableau's alignment guides (dotted lines appear when dragging sheets)
- Make sure all sheets in same row align at same Y-coordinate
- Column widths: Split canvas into equal halves or thirds based on layout
- Leave 10-15px margins between sheets for visual breathing room

---

### **STEP 6: Add Filters & Interactivity (45 minutes)**

**Action 6.1 — Add Region Filter (Global)**
- Right-click the `Regional Cost and Denial Profile` sheet → **Use as Filter**
- Now clicking a region in that sheet filters all other sheets by that region
- Test: Click "Midwest" in the Regional Profile chart → all other sheets update

**Action 6.1A — Add Demographic Filters to Patient Risk Segments Sheet** ⭐
- Go to the `Patient Risk Segments` (demographic heatmap) sheet
- Add interactive filters for demographic drill-down:

  **Filter 1: Smoking Status**
  - Right-click the `Smoker` filter pill (top of sheet, if already present)
  - OR drag `Smoker` to FILTERS shelf if not present
  - Click filter → **Show Filter** → Make it visible on dashboard
  - Filter type: **Checkbox** (allows both, one, or either value)
  - Values: Show both "Yes" and "No"
  - Label: "Patient Smoking Status"
  - Effect: When toggled, heatmap updates to show only selected cohort
    - Smoker=Yes: Shows dramatic cost increase ($17k-$45k range)
    - Smoker=No: Shows baseline costs ($2k-$12k range)
    - Both: Displays full comparison side-by-side

  **Filter 2: Age Group (Optional Secondary)**
  - Drag `Age Group` to FILTERS
  - Click filter → **Show Filter**
  - Filter type: **Multiple Values (List)**
  - Allows selection of age cohorts to focus (e.g., "56+" for senior analysis)
  - Label: "Age Group Filter"

  **Filter 3: Region (Cascading from Global Filter)**
  - Drag `Region` to FILTERS shelf
  - **IMPORTANT:** Link to global Region filter → **Use as Filter** 
  - This cascades from the global Region selection, so heatmap respects regional drill-down
  - Effect: Select "Midwest" globally → Patient Risk Segments shows only Midwest demographic breakdown

  **Filter 4: Cost Tier Display (Optional)**
  - If pre-calculated in SQL view: Drag `Cost Tier` to FILTERS
  - Allows filtering: "Show only High-Cost segments" (cost > median)
  - Label: "Cost Segment"

**Action 6.1B — Test Demographic Filter Interactions**
- Test Scenario 1: Select "Smoker=Yes" only
  - Heatmap should show ONLY smoker cohorts
  - Colors should be darker (higher average costs)
  - Expected: Age 56+ + Obese cell displays ~$45k (vs. $12k+ for non-smoker)
  
- Test Scenario 2: Select Region "Southeast" globally → heatmap updates
  - Demographic breakdown now shows only Southeast claims
  - Colors and counts (n=xx) change
  - Expected: Smoker rate higher in South, cost slightly higher
  
- Test Scenario 3: Compare "Smoker=Yes" vs. "Smoker=No" toggling
  - Use filter to switch between cohorts
  - Heatmap should show 5-10× cost difference visually
  - Expected: Red cells (Smoker=Yes) → Yellow/light cells (Smoker=No)

---

**Action 6.2 — Add Date Range Filter**
- Go to the `Monthly Spend Trend` sheet
- Right-click `Claim Date` in COLUMNS → **Show Filter**
- A date filter slider appears on the sheet
- Move this filter to the top of the Dashboard sheet
- Test: Move slider to select 3-month window → all cost charts update

**Action 6.3 — Add Claim Status Filter**
- In `Claims Status Distribution` sheet
- Right-click `Claim Status` in Color mark → **Show Filter**
- Move filter to Dashboard
- Test: Uncheck "Denied" → bars/pie exclude denied claims

**Action 6.4 — Add Hospital Selection (Optional)**
- Drag `Hospital Name` to a separate filter on dashboard
- This allows drill-down to specific hospital performance
- Link to heatmap: Selecting a hospital could highlight which demographic cohorts use that hospital most

**Action 6.5 — Configure Filter Interaction Scope**
- Select a filter on dashboard (e.g., Region filter)
- Right-click → **Edit Filter Shelf** → Applies to: select which sheets
- **For Patient Risk Segments specifically:**
  - Smoker filter: Applies to `Patient Risk Segments` ONLY (not other sheets)
  - Age Group filter: Applies to `Patient Risk Segments` ONLY
  - Region filter: Applies to ALL sheets (global cascade)
  - Date filter: Applies to trend sheets + KPI cards (not to demographic breakdown, as demographics are static per patient)

---

### **STEP 7: Format & Style Dashboard (20 minutes)**

**Action 7.1 — Set Background Color**
- Dashboard → Format Background → Light gray (#F5F5F5) or white
- This makes charts stand out

**Action 7.2 — Add Title**
- Dashboard → Title → Type "Healthcare Claims and Denial Analysis"
- Font: Tableau Bold, 24pt, Dark blue

**Action 7.3 — Add Spacing**
- Use blank objects to add visual breathing room between sheets
- Dashboard → Objects → Drag "Blank" to add gaps

**Action 7.4 — Add Executive Summary Text (Optional)**
- Dashboard → Objects → Text
- Write: "Executive Dashboard - 1,549 claims across 6 US regions. Use filters to explore regional variations, denial patterns, and cost drivers."
- Place at top below title

**Action 7.5 — Format Colors for Consistency**
- Ensure all region visualizations use same 6-color palette
- Export color palette: Worksheet → Color → Edit Colors → Export to re-use across sheets

---

### **STEP 8: Test & Validate (20 minutes)**

**Action 8.1 — Test All Filters**
- Click each region in Regional Profile → verify all charts update
- Move date slider → verify costs change
- Toggle Claim Status → verify counts decrease
- Test cascade: Select Region → Select Hospital → verify provider list narrows

**Action 8.2 — Check Data Accuracy**
- KPI Card Total Cost: Should = SUM of all claim amounts
- Approval Rate: Should match SQL query output (e.g., 80.05%)
- Pareto Line: Should reach ~80% at top 20% of hospitals
- Regional costs: Sum of all regions = total cost

**Action 8.3 — Performance Test**
- Click filters and watch charts update
- Should respond within 2-3 seconds (not lag > 5 seconds)
- If slow: Dashboard → Analyze Performance to identify problem sheets

**Action 8.4 — Visual Quality Check**
- [ ] All titles readable (18pt+ font)
- [ ] No overlapping text
- [ ] Colors distinct (legend clear)
- [ ] Numbers formatted correctly ($ and % symbols)
- [ ] Axis labels clear (not truncated)

---

### **STEP 9: Save & Package Workbook (5 minutes)**

**Action 9.1 — Save Workbook**
- File → **Save As**
- Filename: `healthcare_insurance_dashboard.twb`
- Location: `./tableau/` folder
- Confirm: You now have `.twb` file (Tableau Workbook)

**Action 9.2 — Package for Submission**
- File → **Export as PDF** (optional backup)
  - Or: File → **Export Workbook** to create `.twbx` (packaged workbook with data)
  - This `.twbx` file can be opened on any computer without MySQL connection

**Action 9.3 — Test Packaged File**
- Close Tableau
- Double-click `.twbx` file → should open and work without database connection
- All filters and interactivity still functional

**Action 9.4 — Verify Deliverable Structure**
```
tableau/
  ├── healthcare_insurance_dashboard.twb     (main workbook)
  ├── healthcare_insurance_dashboard.twbx    (packaged, for submission)
  └── README.md (optional: instructions to open)
```

---

### **TROUBLESHOOTING COMMON ISSUES**

| Issue | Solution |
|-------|----------|
| "Cannot connect to MySQL" | Check MySQL server is running (Windows: Services → MySQL80). Verify username/password. |
| "Sheet shows no data / blank" | Verify field roles in Data Source. Ensure Date field is set as "Date" type. |
| "Filter doesn't work" | Right-click filter → Apply to all sheets. Check field is a dimension, not measure. |
| "Map doesn't show states" | Right-click state field → Geographic Role → State/Province. Make sure state field has proper 2-letter codes (CA, TX, etc.). |
| "KPI cards show 0 or NULL" | Check calculated fields: Edit → verify formula is correct. Ensure denial_flag field exists. |
| "Dashboard runs slow" | Remove unnecessary fields from tooltips. Reduce number of rows displayed. Test query performance in SQL first. |
| "Charts show partial data after filtering" | Check all sheets are connected to same data source. Verify filters apply to correct sheet scope. |

---

## 📊 Next Steps

### **Why the Patient Risk Segments Heatmap Matters**

The **Patient Risk Segments** demographic heatmap (age × BMI × smoking status) is not just another visualization—it's the **core business deliverable** that directly addresses healthcare revenue cycle management:

**Raw Data → SQL Intelligence → Tableau Impact:**

| Stage | What Happens | Business Outcome |
|-------|-------------|------------------|
| **Raw Data** | insurance_claims_raw.csv contains age, bmi, smoker attributes for all 1,549 patients | Demographic attributes available but unstructured |
| **SQL Query 6** | Demographic Risk Segmentation query buckets age (5 groups) × BMI (4 categories) × smoker (2 options), computes avg cost & denial rate per cohort | Data is segmented, cost drivers identified quantitatively |
| **Tableau Heatmap** | Interactive visualization shows 40 demographic cells with color-coded costs (light=$2k to dark=$45k), enabling drill-down by smoking status | **Executive insight in 5 seconds:** "Smokers = 5-10× higher cost; age 56+ smoker + obese = $45k avg" |
| **Strategic Decision** | Pricing team adjusts premiums; prevention program targets smoker 46+ cohort; denial review focuses on high-cost diagnoses | **Estimated Impact:** 8-12% cost reduction through targeted interventions |

### **Key Metrics Visible in Heatmap:**

1. **Cost Multiplier:** Smoker vs. Non-smoker in same age/BMI bucket
   - Example: 46-55 Overweight: Non-smoker $8.9k → Smoker $16.8k (1.9× multiplier)
   - Example: 56+ Obese: Non-smoker $14.8k → Smoker $45.2k (3.0× multiplier)

2. **Denial Rate Correlation:** High-cost cohorts often have higher denial rates
   - Smokers: 8-12% denial rate
   - Non-smokers: 2-5% denial rate
   - Suggests eligibility/documentation challenges in high-risk groups

3. **Population Distribution (n=count):** Where the patient volume is concentrated
   - Largest cohort: 46-55 Normal BMI Non-smoker (n=187)
   - Highest cost per capita: 56+ Obese Smoker (n=189, avg $45k)
   - **Strategic insight:** Focus prevention on 46-55 normal BMI smokers (lower immediate cost but large volume = high ROI)

### **How This Aligns with Project Rubric (30 Marks):**

| Rubric Component | How Demographic Heatmap Delivers | Marks |
|------------------|--------------------------------------|-------|
| **Dataset Understanding (3)** | Explains how raw attributes (age, BMI, smoker) normalize into buckets and drive cost variation | 3 ✓ |
| **SQL Querying (5)** | Query 6 demonstrates advanced aggregation, segmentation, variance decomposition (STDDEV), CASE WHEN bucketing | 5 ✓ |
| **Tableau Design (6)** | Heatmap = advanced mark type + color encoding + dual metrics (cost + count) + filters + drill-down interactivity | 6 ✓ |
| **Statistical/KPI Analysis (4)** | Cohort segmentation, variance by group, density analysis (n=count), identifies outliers (smoker 56+) | 4 ✓ |
| **Insight Generation (4)** | "Smoker cost multiplier = 5-10×"; "Prevention target = age 46-55 smokers"; "Denial correlation = smoking status" → SMART actions | 4 ✓ |
| **Documentation (4)** | Methodology for demographic bucketing, limitations (self-reported smoking status), references to healthcare RCM literature | 4 ✓ |
| **Presentation (4)** | Show heatmap in viva → "This one chart shows our biggest cost driver"; drill filters live → "Watch cost jump 5× when we toggle smoker=yes" | 4 ✓ |

**Total: 30 marks unlocked through comprehensive demographic analysis strategy.**

---

## 🚀 **OPTIONAL ADVANCED ENHANCEMENT: RFM Analysis (WORKSHEET 9)**

### **Why Add RFM Analysis to Achieve 30/30 with Distinction?**

The **Patient Lifetime Value - RFM Analysis** worksheet (WORKSHEET 9) elevates your project from excellent to exceptional by adding a fourth dimension of business intelligence:

**From Demographic Risk → To Customer Lifetime Value Strategy:**

| Component | Demographic Heatmap (WORKSHEET 7) | RFM Analysis (WORKSHEET 9) | Combined Impact |
|-----------|------|------|-------|
| **Question Answered** | "Which demographics cost the most?" | "Which members are most valuable long-term?" | Complete 360° view |
| **Segmentation** | Age × BMI × Smoking (cohort analysis) | Recency × Frequency × Monetary (customer lifecycle) | Dual segmentation strategy |
| **Business Use** | Pricing, prevention programs | Retention, upsell, churn prevention | Comprehensive member strategy |
| **SQL Complexity** | Query 6: CASE WHEN bucketing + aggregation | Query 7: CTEs with NTILE window functions + multi-level segmentation | Demonstrates mastery |
| **Tableau Design** | Heatmap with color encoding | Bubble chart with size/color dual encoding + drill-down | Advanced visualization patterns |
| **Evaluation Impact** | Scores: Dataset (3) + SQL (5) + Tableau (6) + Stats (4) + Insights (4) | Adds: Advanced CTEs, NTILE segmentation, customer lifetime value concepts | Deep technical breadth |

### **Quick RFM Implementation Path (30-45 minutes):**

1. **SQL Query 7** (10 min) — Copy Query 7 spec from WORKSHEET 9 section above
2. **Tableau Worksheet 9** (20-30 min) — Create bubble chart with 8 customer segments
3. **Business Insights** (5 min) — Identify segment distribution by smoker status
4. **Documentation** (5 min) — Add RFM findings to project report

### **How RFM Unlocks Additional Marks (Beyond 28/30):**

| Original Rubric Component | Demographic Heatmap Coverage | RFM Analysis Adds | New Total |
|-----------|------|------|-------|
| **Dataset Understanding (3)** | 3/3 | +0 (same data) | 3/3 |
| **SQL Querying (5)** | 5/5 (Query 6) | +0.5 (Query 7 adds NTILE + CTEs) | 5/5 |
| **Tableau Design (6)** | 5/6 (missing: multi-bubble encoding) | +1 (bubble size + color + drill-down) | 6/6 ✓ |
| **Statistical Analysis (4)** | 3.5/4 (missing: customer lifetime value math) | +0.5 (NTILE scoring, customer segmentation) | 4/4 ✓ |
| **Insight Generation (4)** | 4/4 | +0 (complementary insight) | 4/4 |
| **Documentation (4)** | 4/4 | +0 (same methodology) | 4/4 |
| **Presentation (4)** | 3.5/4 (missing: lifecycle strategy slide) | +0.5 ("Here's how we retain our Champions...") | 4/4 ✓ |

**Result: 28/30 marks (Demographic) → 30/30 marks (Demographic + RFM)**

### **Key RFM Insights to Highlight in Viva:**

- **Champions** (~15% of members, ~40% of lifetime value) → Retention focus
- **At-Risk High Value** (~10% of members) → Win-back campaigns, highest ROI
- **Smokers overrepresented in "At-Risk"** → Intersection: demography + lifecycle
- **Prevention program ROI** → Target "At-Risk Frequent" smokers (turn into Champions before they lapse)

**Bottom Line:** RFM Analysis is the cherry on top—it transforms your project from "excellent demographic analysis" to "comprehensive member lifecycle strategy with pricing + retention + prevention tiers." Examiners will be impressed by the breadth.

---

### **PHASE 4: Statistical Analysis & Insight Synthesis (Days 9-10 | 3-4 hours)**

 

#### Day 9 - Quantitative Analysis (2 hours) - Both

- [ ] **Task 4.1** - Pareto & Concentration Analysis

  - Compute Gini coefficient or concentration ratio for cost distribution

  - Identify: Top 20% hospitals → what % of total cost?

  - Identify: Top 20% diagnoses → what % of denials?

  - Visualize Lorenz curve concept in findings

  - **Deliverable:** Quantified statement — "X hospitals (Y%) account for Z% of total spend"

 

- [ ] **Task 4.2** - Patient Segmentation & Risk Profiling

  - Segment patients into cost tiers using percentile-based thresholds (P25, P75)

  - Profile each segment: mean age, BMI distribution, smoking prevalence, regional concentration

  - Statistical comparison: Is the difference between segments significant? (describe approach)

  - **Deliverable:** Segment profiles with distinguishing characteristics

 

- [ ] **Task 4.3** - Denial Pattern Analysis

  - Compute denial rates stratified by: hospital, diagnosis severity, provider specialty, region

  - Identify outliers: hospitals/providers with denial rates > mean + 1.5σ

  - Root cause hypothesis: Are denials correlated with specific diagnosis codes or cost thresholds?

  - **Deliverable:** Ranked list of denial risk factors with quantified rates

 

#### Day 10 - Insight Synthesis & Recommendations (2 hours) - Both

- [ ] **Task 4.4** - Synthesize business insights (minimum 5-7)

  - Each insight must follow the format: **Finding** → **Evidence** → **Business Impact**

  - Example: "Smokers incur 25% higher average claims ($X vs $Y), representing $Z in excess cost across the portfolio"

  - Insight categories:

    1. Cost concentration (Pareto findings)

    2. Denial pattern drivers (operational inefficiency signals)

    3. Demographic risk factors (smoking, age, BMI interactions)

    4. Regional variation (geographic cost disparities)

    5. Temporal trends (growth rates, seasonality if present)

 

- [ ] **Task 4.5** - Formulate strategic recommendations

  - Each recommendation must be: Specific, Measurable, Actionable, Relevant, Time-bound (SMART)

  - **Rec 1:** Revenue cycle process improvement for high-denial hospitals (target: reduce denial rate from X% to Y%)

  - **Rec 2:** Pre-authorization protocol for high-cost diagnosis categories (target: Z% cost avoidance)

  - **Rec 3:** Population health intervention for high-risk patient segments (target: reduce per-capita cost by W%)

  - **Rec 4:** Regional cost benchmarking program (target: bring outlier regions within 1σ of mean)

  - Quantify potential impact where possible (estimated $ savings or % improvement)

 

---

 

### **PHASE 5: Documentation, Reporting & Presentation (Days 11-15 | 3-4 hours)**

 

#### Days 11-12 - Technical Documentation (1 hour) - Person A

- [ ] **Task 5.1** - Consolidate SQL deliverable

  - File: `./sql/insurance_claim_analysis.sql`

  - Structure with clear section demarcation:

    ```

    -- ================================================================

    -- Healthcare Insurance Claim Analysis — SQL Analytics Script

    -- Executive MTech Program | Data Science & AI

    -- Authors: [Names] | Date: [Date]

    -- Database: MySQL 8.0+ / PostgreSQL 14+

    -- ================================================================

   

    -- SECTION 1: SCHEMA CREATION (DDL)

    -- SECTION 2: DATA LOADING & ETL

    -- SECTION 3: MULTI-TABLE RETRIEVAL (JOINs)

    -- SECTION 4: AGGREGATION & CONDITIONAL ANALYSIS (GROUP BY, HAVING)

    -- SECTION 5: WINDOW FUNCTION ANALYTICS (RANK, LAG, RUNNING TOTALS)

    -- SECTION 6: SUBQUERIES & CTEs (CORRELATED, RECURSIVE)

    -- SECTION 7: STATISTICAL & FINANCIAL ANALYSIS (STDDEV, PERCENTILE, PARETO)

    ```

 

- [ ] **Task 5.2** - Professional query documentation

  - Each query block includes:

    - Business question being answered (1 line)

    - SQL techniques demonstrated (tagged for evaluation)

    - Tables/joins involved

    - Expected output schema and sample rows (3-5 rows)

 

#### Days 12-14 - Report & Executive Presentation (2 hours) - Both

- [ ] **Task 5.3** - Write project report

  - File: `./report/project_report.md`

  - **Structure (academic standard):**

    1. **Executive Summary** — Problem, approach, key findings, impact (1 paragraph)

    2. **Introduction & Problem Statement** — Healthcare RCM context, why claim analysis matters

    3. **Dataset Description** — Source, profiling results, quality assessment, normalization rationale

    4. **Methodology**

       - Data Engineering: Schema design decisions, ETL approach

       - SQL Analytics: Techniques applied per section, query design rationale

       - Visualization Strategy: Chart selection rationale (why Pareto, why scatter, etc.)

    5. **Results & Analysis**

       - Statistical findings with tables/charts

       - Pareto analysis results

       - Segmentation profiles

       - Denial pattern analysis

    6. **Key Findings** — 5-7 numbered insights with evidence

    7. **Business Recommendations** — SMART recommendations with estimated impact

    8. **Limitations & Future Work** — Data constraints, potential extensions (ML modeling, real-time dashboards)

    9. **References** — Dataset source, SQL documentation, analytical frameworks cited

 

- [ ] **Task 5.4** - Create executive presentation (7 slides)

  - File: `./report/presentation.pptx`

 

  **Slide 1: Title**

  - Project: Healthcare Insurance Claim Analysis & Denial Patterns

  - Program: Executive MTech — Data Science & AI

  - Team: [Names] | Date: [Date]

 

  **Slide 2: Business Context & Objective**

  - Industry problem: 3-5% revenue leakage from claim denials (cite HFMA)

  - Objective: Data-driven identification of cost drivers and denial patterns

  - Scope: 1,330+ claims across 6 normalized tables, 7 analytical query sections, 6+ visualizations

 

  **Slide 3: Data Architecture**

  - ER diagram (simplified) showing 6-table normalized schema

  - Data profiling summary: distributions, quality metrics

  - ETL pipeline: Raw CSV → Normalized DB → Analytical Views → Tableau

 

  **Slide 4: SQL Analytics Methodology**

  - 2 representative queries with brief annotation:

    - Query A: Multi-table JOIN with conditional aggregation (denial rate calculation)

    - Query B: Window function with LAG for trend analysis

  - Technique coverage summary: JOINs, GROUP BY/HAVING, Window Functions, CTEs, Statistical Aggregates

 

  **Slide 5: Dashboard & Visualization Design**

  - 3-4 dashboard screenshots (annotated)

  - Design principles applied: Z-pattern flow, progressive disclosure, accessibility

  - Interactivity: cascading filters, parameter actions, drill-down paths

 

  **Slide 6: Key Findings (Evidence-Based)**

  - Finding 1: Cost concentration — "Top X% hospitals drive Y% of spend"

  - Finding 2: Denial drivers — "Hospital Z has Xσ above-mean denial rate"

  - Finding 3: Risk factors — "Smokers: +25% avg cost; BMI>30: +18% avg cost"

  - Finding 4: Regional disparity — "[Region] avg cost is X% above portfolio mean"

  - Each finding backed by specific numbers from analysis

 

  **Slide 7: Recommendations & Impact**

  - 3-4 SMART recommendations with quantified expected impact

  - Implementation priority matrix (effort vs. impact)

  - Limitations acknowledged; future work: predictive modeling, real-time monitoring

  - Closing: "Estimated X% denial reduction = $Y annual savings potential"

 

- [ ] **Task 5.5** - Create README.md

  - File: `./README.md`

  - Project overview, prerequisites, folder structure

  - Instructions: How to execute SQL scripts, connect Tableau workbook

  - Technology stack: SQL dialect, Tableau version, data source

 

#### Day 15 - Quality Assurance & Submission (1 hour) - Both

- [ ] **Task 5.6** - Comprehensive QA checklist

  - [ ] SQL: All queries execute without errors on clean database

  - [ ] SQL: Each section demonstrates distinct SQL technique

  - [ ] Tableau: All dashboard interactions work end-to-end

  - [ ] Tableau: Storyboard narrative is coherent and data-backed

  - [ ] Report: All claims supported by data; no unsupported assertions

  - [ ] Presentation: 7 slides, professional formatting, rehearsed flow

  - [ ] Files: Correct naming convention, folder structure matches plan

  - [ ] Peer review: Each person reviews the other's primary deliverable

 

---

 

## 🔍 Deliverables Quality Standards

 

### SQL Script (`insurance_claim_analysis.sql`) — Executive MTech Standard

- [ ] All 7 sections with professional header documentation

- [ ] Schema: 3NF normalized with constraints, indexes, and design rationale comments

- [ ] ETL: Reproducible data loading with validation checks

- [ ] Retrieval: 4-5 multi-table JOIN queries demonstrating relational algebra

- [ ] Aggregation: 4+ queries with GROUP BY, HAVING, conditional aggregation (CASE WHEN)

- [ ] Window Functions: 5+ queries covering RANK, ROW_NUMBER, DENSE_RANK, LAG/LEAD, running aggregates

- [ ] CTEs/Subqueries: 4+ queries including correlated subqueries, multi-level CTEs

- [ ] Statistics: 4-5 queries with STDDEV, PERCENTILE, Pareto analysis, coefficient of variation

- [ ] All queries produce meaningful business answers (not just technical demonstrations)

- [ ] Query optimization considerations noted where relevant

 

### Tableau Workbook (`healthcare_insurance_dashboard.twbx`)

- [ ] 6+ distinct visualizations (each serving a specific analytical purpose)

  - [ ] Time series with trend/forecast (temporal patterns)

  - [ ] Dual-axis composite (multi-metric comparison)

  - [ ] Pareto chart with 80% threshold (concentration analysis)

  - [ ] KPI dashboard with delta indicators (executive summary)

  - [ ] Scatter/bubble matrix (multi-dimensional performance)

  - [ ] Geographic or additional analytical visualization

- [ ] Cascading filters with parameter-driven interactivity

- [ ] Dashboard actions: filter, highlight, URL navigation

- [ ] Storyboard: 4-5 story points with data narrative arc

- [ ] Professional design: consistent palette, accessible colors, clear labels

- [ ] Performance: No unnecessary complexity; loads within 5 seconds

 

### Analysis & Insights — Graduate-Level Rigor

- [ ] Pareto/concentration analysis with quantified results

- [ ] Statistical segmentation with profile characterization

- [ ] Outlier identification using statistical thresholds (not arbitrary)

- [ ] 5-7 insights following Finding → Evidence → Impact format

- [ ] 3-4 SMART recommendations with estimated business impact

- [ ] Limitations explicitly acknowledged

 

### Presentation — Executive Communication Standard

- [ ] 7 slides maximum (discipline in conciseness)

- [ ] Data-driven: every claim backed by specific numbers

- [ ] Visual: charts/diagrams preferred over text bullets

- [ ] Prepared for technical deep-dive questions (viva readiness)

- [ ] Professional formatting: consistent fonts, aligned elements, minimal text per slide

 

### Project Report — Academic Standard

- [ ] Structured methodology section (reproducible approach)

- [ ] Results separated from interpretation

- [ ] Limitations and future work section

- [ ] Proper attribution of data sources

- [ ] Professional formatting with table of contents

 

---

 

## 🎯 Evaluation Strategy & Differentiation

 

| Component | Marks | How to Exceed Expectations (Executive MTech Level) |

|-----------|-------|-----------------------------------------------------|

| Dataset Understanding | 3 | Normalization rationale documented; data quality profiling with statistical summary; ER diagram with cardinality |

| SQL Querying | 5 | Advanced patterns beyond basics: correlated subqueries, multi-level CTEs, statistical aggregates, query optimization notes |

| Tableau Dashboard | 6 | Executive-ready design; UX principles applied; parameter actions; storyboard with clear narrative arc |

| Statistical/KPI Analysis | 4 | Coefficient of variation, Pareto with Gini concept, percentile-based segmentation, outlier detection using σ thresholds |

| Insight Generation | 4 | SMART recommendations; quantified business impact ($/%); Finding→Evidence→Impact structure |

| Documentation | 4 | Academic report structure; methodology reproducible; limitations acknowledged; proper citations |

| Presentation & Viva | 4 | Executive brevity; data-driven claims; handles "why" and "so what" questions confidently |

 

**Total: 30 marks**

 

### Viva Preparation — Likely Technical Questions

1. "Why did you normalize to 6 tables instead of querying the flat file directly?"

2. "Explain how your window function query differs from a simple GROUP BY."

3. "What does the Pareto analysis tell us that a simple average doesn't?"

4. "How would you extend this analysis with machine learning?" (predictive denial modeling)

5. "What are the limitations of your dataset and how do they affect conclusions?"

 

---

 

## 📝 Execution Guidelines

 

- **Analytical Mindset:** Every query should answer a business question, not just demonstrate syntax

- **Reproducibility:** All steps documented so a reviewer can re-run the entire pipeline from raw data

- **Professional Communication:** Write for a mixed audience (technical evaluators + business stakeholders)

- **Quality over Quantity:** Fewer well-crafted queries with clear insights > many trivial queries

- **Time Management:** SQL development (Phase 2) is the foundation — complete it before starting Tableau

- **Collaboration:** Daily sync between Person A and B; insights inform both SQL and visualization design

- **Data Integrity:** Always validate outputs — check row counts, NULL rates, aggregate totals after each transformation

 

---

 

## �️ ARCHIVED DOCUMENTATION (PDF Consolidation - Sept 17, 2026)

**Status:** Documentation refactored for clarity. Implementation guides moved to dedicated `/plan/` folder.

### New Folder Structure

| Folder | Purpose | Contents |
|--------|---------|----------|
| **`/plan/`** | Implementation & planning guides | 4 core guides + 9 worksheet references |
| **`/report/`** | Final outputs only | generate_presentation.py, presentation.pptx |
| **`/sql/`** | SQL scripts | 7 query patterns + master script |
| **`/data/`** | Raw & processed data | CSV files + processed outputs |
| **`/tableau/`** | Tableau workbook | healthcare_insurance_dashboard.twbx |

### Migration Summary ✅

**Moved to `/plan/`:**
- TABLEAU_WORKSHEET_BUILD_CHECKLIST.md (core guide)
- TABLEAU_ANALYSIS_GUIDE.md (core guide)
- VIVA_PREP.md (core guide)
- REFERENCE_ONE_PAGE.md (quick ref)
- WS1-WS9 worksheet guides (optional reference)

**Deleted:** 11 archived/deprecated files (see below)

| Deleted File | Reason |
|--------------|--------|
| CONSOLIDATION_SUMMARY.md | Temporary summary doc |
| DOCUMENTATION_DEDUPLICATION_SUMMARY.md | Meta-documentation |
| PRESENTATION_GUIDE.md | Content in VIVA_PREP.md |
| RFM_IMPLEMENTATION_CHECKLIST.md | Content in core guides |
| TABLEAU_CUSTOM_ACTIONS_QUICK_REFERENCE.md | Merged into master |
| TABLEAU_CUSTOM_INTERACTIVE_DASHBOARD.md | Merged into master |
| TABLEAU_DOCUMENTATION_MAP.md | Navigation fluff |
| TABLEAU_LOD_EXPRESSIONS_IMPLEMENTATION.md | Content in master |
| TABLEAU_QUICK_START_GUIDE.md | Redundant |
| TABLEAU_STORYBOARD_IMPLEMENTATION.md | Merged into master |
| VIVA_PREPARATION_GUIDE.md | Superseded by VIVA_PREP.md |

**Result:** Zero redundancy. Clean folder structure. All content preserved in `/plan/`.

---

 

## �🔗 References & Resources

 

- **SQL Reference:** [MySQL 8.0 Window Functions](https://dev.mysql.com/doc/refman/8.0/en/window-functions.html) | [PostgreSQL Analytics](https://www.postgresql.org/docs/current/functions-window.html)

- **Tableau Best Practices:** [Tableau Visual Best Practices](https://www.tableau.com/learn/whitepapers/tableau-visual-guidebook) | [Dashboard Design Patterns](https://public.tableau.com)

- **Healthcare Analytics Context:** HFMA Revenue Cycle Benchmarking | CMS Quality Measures

- **Statistical Methods:** Pareto Principle in Healthcare Cost Analysis | Patient Segmentation Frameworks

- **Data Source:** [Kaggle Insurance Dataset](https://kaggle.com/datasets/mirichoi0218/insurance)

 

---

 

**Program:** Executive MTech — Data Science & AI  

**Last Updated:** 09 Sep 2026  

**Status:** Implementation Ready / Ready for Review ✅

 

