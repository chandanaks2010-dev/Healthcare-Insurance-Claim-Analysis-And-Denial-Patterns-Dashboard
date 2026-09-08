# Healthcare Insurance Claim Analysis & Denial Patterns Dashboard

## SQL & Tableau Mini Project — Executive MTech Program

 

**Program:** Executive MTech in Data Science & AI  

**Project Duration:** 15-18 hours (2-person team)  

**Submission Date:** [Add your deadline]  

**Team Members:** [Add names]  

**Industry Domain:** Healthcare Revenue Cycle Management (RCM)

 

---

 

## 📋 Project Overview

 

### Business Context

Healthcare organizations lose an estimated 3-5% of net revenue due to claim denials (HFMA, 2023). Identifying denial patterns and cost drivers through data-driven analysis enables strategic interventions in the revenue cycle, improving both financial performance and patient experience.

 

### Objective

Design and implement an end-to-end analytics solution that leverages structured query language for data engineering and exploratory analysis, combined with Tableau for executive-level visual storytelling. The project demonstrates competency in relational data modeling, advanced SQL analytics (window functions, CTEs, statistical aggregates), and interactive business intelligence dashboard design — applied to a real-world healthcare claims domain.

 

### Expected Deliverables

- ✅ SQL Script File (`insurance_claim_analysis.sql`) — Schema design, ETL, and 7 analytical query sections

- ✅ Tableau Workbook (`healthcare_insurance_dashboard.twbx`) — 6+ interactive visualizations with storyboard

- ✅ Final PPT Presentation (7 slides) — Executive summary with data-backed recommendations

- ✅ Project Report Documentation — Methodology, findings, and business impact analysis

 

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

**Primary: Kaggle Insurance Medical Claims Dataset**

- **Link:** https://www.kaggle.com/datasets/mirichoi0218/insurance

- **Records:** ~1,330 (sufficient for demonstrating analytical techniques without infrastructure overhead)

- **Structure:** Single denormalized table → normalized into 6 relational tables (3NF)

- **Key Variables:** age, sex, bmi, children, smoker, region, charges

- **Analytical Suitability:** Supports demographic segmentation, cost modeling, and regional analysis

 

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

  - Query 5: Running total and cumulative distribution (SUM() OVER with frame)

 

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

    -- CTE chain: segment → aggregate → filter (analytical pipeline pattern)

    WITH patient_totals AS (

      SELECT patient_id, SUM(claim_amount) AS lifetime_cost, COUNT(*) AS claim_count

      FROM claims GROUP BY patient_id

    ),

    cost_segments AS (

      SELECT *,

             CASE

               WHEN lifetime_cost >= (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY lifetime_cost) FROM patient_totals) THEN 'High'

               WHEN lifetime_cost >= (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY lifetime_cost) FROM patient_totals) THEN 'Medium'

               ELSE 'Low'

             END AS cost_tier

      FROM patient_totals

    )

    SELECT cost_tier, COUNT(*) AS patient_count, AVG(lifetime_cost) AS avg_cost

    FROM cost_segments GROUP BY cost_tier;

    ```

  - Query 3: EXISTS/NOT EXISTS — Patients with denied claims but no approved claims

  - Query 4: UNION-based cohort comparison (smokers vs. non-smokers metrics)

 

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

 

- [ ] **Task 2.7** - Export analytical views for Tableau consumption

  - Create denormalized analytical views/exports optimized for BI tool ingestion

  - Output: `./data/processed/claims_analysis.csv`

  - Include calculated fields: cost_tier, age_group, bmi_category, denial_flag

 

---

 

### **PHASE 3: Tableau Dashboard Engineering (Days 6-8 | 5-6 hours)**

 

#### Day 6 - Data Connection & Foundational Visualizations (2 hours) - Person B

- [ ] **Task 3.1** - Configure Tableau data source

  - Connect to processed CSV or live database connection

  - Define data types, hierarchies (Region → Hospital → Provider)

  - Create date hierarchy (Year → Quarter → Month)

  - Set up data relationships/joins if using multiple tables

 

- [ ] **Task 3.2** - Create calculated fields and parameters

  - **Calculated Fields:**

    - Cost Tier: `IF [Claim Amount] >= P75 THEN 'High' ELSEIF >= P25 THEN 'Medium' ELSE 'Low' END`

    - Denial Flag: `IF [Claim Status] = 'Denied' THEN 1 ELSE 0 END`

    - Cost per Claim: `SUM([Claim Amount]) / COUNT([Claim ID])`

    - YoY Growth: Table calculation with LOOKUP and period offset

  - **Parameters:**

    - Date Range selector (start/end date)

    - Top N filter (user-controlled ranking depth)

 

- [ ] **Task 3.3** - Build foundational visualizations (3 charts)

  - **Viz 1: Time Series with Trend & Forecast**

    - X: Claim Date (monthly granularity)

    - Y: SUM(Claim Amount) with 95% confidence band

    - Overlay: Linear trend line + 3-month exponential smoothing forecast

    - Design: Reference lines for mean ± 1σ (control chart concept)

  - **Viz 2: Dual-Axis Composite** — Volume vs. Value by hospital

    - Left Y: COUNT(Claims) as bars

    - Right Y: AVG(Claim Amount) as line with markers

    - Synchronized axis scales; color-coded for clarity

  - **Viz 3: Sorted Bar with Cumulative Line** — Top N hospitals by claim volume

    - Parameter-driven N selection

    - Reference line at overall average

 

#### Day 7 - Executive KPI Dashboard & Advanced Visualizations (2 hours) - Person B

- [ ] **Task 3.4** - Build Executive KPI Summary

  - 4 KPI cards with sparklines and delta indicators:

    - **Total Claims:** COUNT with MoM trend arrow (▲/▼)

    - **Total Cost:** SUM formatted as currency with YoY comparison

    - **Approval Rate:** Percentage with color threshold (Green >85%, Yellow 70-85%, Red <70%)

    - **Avg Cost per Claim:** With benchmark comparison line

  - Design: BANs (Big Ass Numbers) with contextual sub-metrics

 

- [ ] **Task 3.5** - Build analytical visualizations (3 advanced charts)

  - **Viz 4: Pareto Chart** — Cost concentration analysis

    - Sorted descending bars (individual hospital cost)

    - Overlaid cumulative % line with 80% threshold marker

    - Annotation: "Top X hospitals account for 80% of costs"

  - **Viz 5: Scatter/Bubble Matrix** — Hospital performance quadrant

    - X: Denial Rate (%), Y: Average Claim Cost

    - Size: Claim Volume, Color: Hospital Type

    - Quadrant lines at median values → identify outlier hospitals

  - **Viz 6: Filled Map / Regional Heatmap**

    - Geographic distribution of avg claim cost by region

    - Tooltip: Region stats (volume, avg cost, denial rate)

    - Color gradient: sequential palette (light → dark = low → high cost)

 

- [ ] **Task 3.6** - Implement interactivity and drill-down

  - **Cascading Filters:** Region → Hospital → Provider → Specialty

  - **Parameter Actions:** Click hospital → update KPI cards for that hospital

  - **Filter Actions:** Select time range on line chart → filter all other sheets

  - **Highlight Actions:** Hover on bubble → highlight same hospital across dashboard

  - **URL Action:** Link to hospital detail view (sheet navigation)

 

#### Day 8 - Dashboard Composition & Narrative Storyboard (1-2 hours) - Person B

- [ ] **Task 3.7** - Assemble executive dashboard

  - **Layout principles:** Z-pattern reading flow, KPIs at top, detail below

  - Grid: 4 KPI tiles (top row) → 2×2 visualization grid (bottom)

  - Global filters: Date Range, Region, Claim Status, Hospital Type

  - Responsive containers for different screen resolutions

  - Consistent color palette (max 5 colors, accessible for color-blindness)

 

- [ ] **Task 3.8** - Create analytical storyboard (data narrative)

  - **Story Point 1: "The Cost Landscape"**

    - Opening: Overall claim trends, total spend, growth trajectory

    - Key stat callout: "Total claims grew X% YoY, with cost per claim rising Y%"

  - **Story Point 2: "Where the Money Goes — Pareto Insight"**

    - Pareto chart with annotation: "Top 20% of hospitals drive 78% of costs"

    - Drill into top-cost hospital characteristics

  - **Story Point 3: "Denial Hotspots & Root Causes"**

    - Bubble chart highlighting high-denial outliers

    - Cross-reference with diagnosis types and provider specialties

  - **Story Point 4: "Demographic Risk Factors"**

    - Regional heatmap + demographic segmentation

    - Key insight: Smoking status and BMI correlation with cost tiers

  - **Story Point 5: "Recommendations & Next Steps"**

    - Summary of actionable findings with quantified impact

 

- [ ] **Task 3.9** - Quality assurance and export

  - Test all filter interactions (no broken dependencies)

  - Verify tooltip content and formatting

  - Check color accessibility (contrast ratios)

  - Export: `./tableau/healthcare_insurance_dashboard.twbx`

  - Validate: Packaged workbook opens correctly on clean machine

 

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

 

## 🔗 References & Resources

 

- **SQL Reference:** [MySQL 8.0 Window Functions](https://dev.mysql.com/doc/refman/8.0/en/window-functions.html) | [PostgreSQL Analytics](https://www.postgresql.org/docs/current/functions-window.html)

- **Tableau Best Practices:** [Tableau Visual Best Practices](https://www.tableau.com/learn/whitepapers/tableau-visual-guidebook) | [Dashboard Design Patterns](https://public.tableau.com)

- **Healthcare Analytics Context:** HFMA Revenue Cycle Benchmarking | CMS Quality Measures

- **Statistical Methods:** Pareto Principle in Healthcare Cost Analysis | Patient Segmentation Frameworks

- **Data Source:** [Kaggle Insurance Dataset](https://kaggle.com/datasets/mirichoi0218/insurance)

 

---

 

**Program:** Executive MTech — Data Science & AI  

**Last Updated:** 27 Aug 2026  

**Status:** Ready for Implementation ✅

 

