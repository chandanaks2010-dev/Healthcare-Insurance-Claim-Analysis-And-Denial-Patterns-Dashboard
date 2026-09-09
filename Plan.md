# Healthcare Insurance Claim Analysis & Denial Patterns Dashboard

## SQL & Tableau Mini Project — Executive MTech Program

 

**Program:** Executive MTech in Data Science & AI  

**Project Duration:** 15-18 hours (2-person team)  

**Submission Date:** 09 Sep 2026  

**Team Members:** Team A and Team B  

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

 

- [ ] **Task 2.7** - Create a Tableau-ready live view for BI ingestion

  - Preferred approach: create a denormalized MySQL view optimized for live Tableau access

  - View name: `v_claims_tableau`

  - Use this view in Tableau as a live connection to the MySQL database rather than exporting a CSV every time

  - Optional fallback export: `./data/processed/claims_analysis.csv`

  - Include calculated fields: cost_tier, age_group, bmi_category, denial_flag

  - Keep the export file only as a backup or for offline analysis if the database is unavailable

 

---

 

## Tableau Beginner Quick Start Guide (Step-by-Step for New Users)

This section is designed for students who are new to Tableau and want a simple, practical way to complete the dashboard part of the project. Follow these steps in order.

### Step 1: Install and open Tableau Desktop

- Install Tableau Desktop (student/trial version is acceptable for coursework).
- Open Tableau and choose the option to connect to a data source.
- If you are using MySQL, select MySQL from the connector list.
- If you are using a CSV backup, choose Text File instead.

### Step 2: Connect to the MySQL database

- Click the MySQL connector.
- Enter the server name, port number, username, password, and database name.
- Use the database named `healthcare_claims_db`.
- Choose the option “Live” connection rather than extract, since the project requires a live SQL-based dashboard flow.
- In the left pane, select the view `v_claims_tableau`.

### Step 3: Understand the Tableau workspace

The Tableau workspace has 4 key areas:

- Data Source pane: shows all tables and fields from the imported dataset.
- Sheets area: where you build each chart.
- Dashboard area: where you combine multiple charts into a single view.
- Filters pane: used to add user filters and controls.

Important beginner concepts:

- Dimensions: categorical fields such as region, hospital, claim status, sex.
- Measures: numeric values such as claim amount, count of claims, average claim amount.
- Rows shelf: controls the x-axis or list arrangement.
- Columns shelf: controls the y-axis or comparison values.
- Marks card: controls colors, sizes, labels, and tooltips.
- Filters shelf: restricts the data shown.

### Tableau Field Placement Reference (Rows, Columns, Filters)

This is the simplest way to remember where each field goes in Tableau.

#### 1) Hierarchy drill-down: Region → Hospital → Provider

```text
Rows:
+-----------------------------------------------------------+
| Region → Hospital → Provider                                |
|   region   |   hospital_name   |   provider_name            |
+-----------------------------------------------------------+

Columns:
+-----------------------------------------------------------+
| SUM([Claim Amount])                                        |
| or COUNT([Claim ID])                                       |
+-----------------------------------------------------------+

Filters:
+-----------------------------------------------------------+
| Region       | Hospital Name      | Provider Name           |
| Claim Status | Hospital Type      | Date Range              |
+-----------------------------------------------------------+
```

Use this for a drill-down view:

```text
Rows shelf:   Location Hierarchy
Columns shelf: SUM([Claim Amount])

Example:
Northeast
  ├─ Hospital_A
  │  ├─ Dr. Patel   -> $4,200
  │  └─ Dr. Shah    -> $3,900
  └─ Hospital_B
     └─ Dr. Mehta  -> $5,100
```

#### 2) Date hierarchy: Year → Quarter → Month

```text
Columns:
+-----------------------------------------------------------+
| Date Hierarchy                                            |
| Year -> Quarter -> Month                                   |
+-----------------------------------------------------------+

Rows:
+-----------------------------------------------------------+
| SUM([Claim Amount])                                        |
| AVG([Claim Amount])                                        |
+-----------------------------------------------------------+

Filters:
+-----------------------------------------------------------+
| Date Range     | Claim Status | Region                    |
+-----------------------------------------------------------+
```

Example:

```text
Columns:  Year -> Quarter -> Month
Rows:     SUM([Claim Amount])

2024
  ├─ Q1 -> Jan, Feb, Mar
  ├─ Q2 -> Apr, May, Jun
  └─ Q3 -> Jul, Aug, Sep
```

#### 3) KPI cards layout

```text
Dashboard top row:
+---------------------------------------------------------------+
| Total Claims | Total Cost | Avg Cost/Claim | Approval Rate    |
+---------------------------------------------------------------+
```

Typical field placements:

```text
KPI Card 1: Total Claims
  Measure used: COUNT([Claim ID])
  Position: Text/Single Value card

KPI Card 2: Total Cost
  Measure used: SUM([Claim Amount])
  Position: Text/Single Value card

KPI Card 3: Avg Cost per Claim
  Measure used: SUM([Claim Amount]) / COUNT([Claim ID])
  Position: Text/Single Value card

KPI Card 4: Approval Rate
  Measure used: AVG([Approval Flag])
  Position: Text/Single Value card
```

#### 4) Scatter/Bubble chart placement

```text
Columns:
+-----------------------------------------------------------+
| Denial Rate                                               |
+-----------------------------------------------------------+

Rows:
+-----------------------------------------------------------+
| Average Claim Amount                                      |
+-----------------------------------------------------------+

Marks card:
+-----------------------------------------------------------+
| Size = Claim Volume                                       |
| Color = Hospital Type or Region                            |
| Label = Hospital Name                                     |
+-----------------------------------------------------------+

Filters:
+-----------------------------------------------------------+
| Region | Claim Status | Hospital Type                     |
+-----------------------------------------------------------+
```

This chart helps identify outlier hospitals:

```text
X-axis: Denial Rate
Y-axis: Average Claim Amount
Bubble size: Claim Volume
Color: Hospital Type
```

#### 5) Pareto chart placement

```text
Rows:
+-----------------------------------------------------------+
| Hospital Name                                             |
+-----------------------------------------------------------+

Columns:
+-----------------------------------------------------------+
| SUM([Claim Amount])                                       |
+-----------------------------------------------------------+

Secondary axis:
+-----------------------------------------------------------+
| Cumulative % of Total Spend                               |
+-----------------------------------------------------------+

Sort:
+-----------------------------------------------------------+
| Descending by Total Cost                                  |
+-----------------------------------------------------------+

Filters:
+-----------------------------------------------------------+
| Date Range | Region | Hospital Type                       |
+-----------------------------------------------------------+
```

#### 6) Dashboard filters placement

```text
Filter Pane:
+-----------------------------------------------------------+
| Date Range    | Region      | Claim Status                 |
| Hospital Type | Smoking Status | Specialty                 |
+-----------------------------------------------------------+
```

These are usually placed at the top of the dashboard and linked to all sheets so every chart updates together.

#### 7) Final dashboard layout pattern

```text
+---------------------------------------------------------------+
| KPI Card 1 | KPI Card 2 | KPI Card 3 | KPI Card 4              |
+---------------------------------------------------------------+
| Monthly Trend Chart      | Pareto Chart                       |
|-------------------------|-------------------------------------|
| Scatter/Bubble Chart     | Regional Heatmap / Map            |
+---------------------------------------------------------------+
| Global Filters: Date Range | Region | Claim Status | Hospital |
+---------------------------------------------------------------+
```

This layout matches the executive dashboard structure:
- Top row = KPI summary
- Middle row = trend + cost concentration
- Bottom row = risk/outlier + regional view
- Filters at the top or left side of the dashboard

### Step 4: Create the first worksheet

- Click the “New Worksheet” button.
- Drag a date field such as claim_date to Columns.
- Drag a measure such as SUM(Claim Amount) to Rows.
- Change the date granularity to Month if needed.
- This creates a time series chart.

This will become your first visual: monthly claim cost trend.

### Step 5: Build the required chart types

Use the following chart logic for the dashboard:

1. Time Series Chart
   - Columns: claim_date (Month)
   - Rows: SUM(claim_amount)
   - Add a trend line for the overall pattern
   - Use color to differentiate status or region if needed

2. KPI Cards
   - Use a text table or single value chart
   - Example metrics:
     - Total claims
     - Total cost
     - Average cost per claim
     - Approval rate
   - Format numbers as currency or percentages

3. Pareto Chart
   - Sort hospitals by total claim amount descending
   - Add a cumulative percentage line
   - This helps explain the 80/20 cost concentration idea

4. Scatter/Bubble Chart
   - X-axis: denial rate
   - Y-axis: average claim cost
   - Size: claim volume
   - Color: hospital type or region

5. Map/Heatmap
   - Use region as the geographic dimension
   - Color by average claim cost or denial rate

### Step 6: Create calculated fields

Go to Analysis > Create Calculated Field and define fields such as:

- Cost Tier:
  - IF [Claim Amount] >= 20000 THEN 'High'
  - ELSEIF [Claim Amount] >= 10000 THEN 'Medium'
  - ELSE 'Low'
  - END

- Denial Flag:
  - IF [Claim Status] = 'Denied' THEN 1 ELSE 0 END

- Age Group:
  - IF [Age] < 30 THEN '18-29'
  - ELSEIF [Age] < 40 THEN '30-39'
  - ELSEIF [Age] < 50 THEN '40-49'
  - ELSEIF [Age] < 60 THEN '50-59'
  - ELSE '60+'
  - END

- BMI Category:
  - IF [BMI] < 18.5 THEN 'Underweight'
  - ELSEIF [BMI] < 25 THEN 'Normal'
  - ELSEIF [BMI] < 30 THEN 'Overweight'
  - ELSE 'Obese'
  - END

These calculations will directly support the project’s required business storytelling.

### Step 7: Add filters

Use filters to make the dashboard interactive.

Common filters for this project:

- Date range
- Region
- Claim status
- Hospital type
- Smoking status

To add a filter:

- Drag a field to the Filters shelf
- Choose the filter type (single value, multiple values, range, etc.)
- Click the filter card to customize options

### Step 8: Use dashboard actions

The plan asks for interactivity. In Tableau, the common actions are:

- Filter action: clicking one chart affects another chart
- Highlight action: highlights matching values across sheets
- URL action: opens a detail page or external link
- Parameter action: changes dashboard values dynamically

For beginners, start with simple filter actions only.

### Step 9: Create a dashboard layout

For a simple executive dashboard:

- Top row: KPI cards (4 tiles)
- Middle row: trend chart and Pareto chart
- Bottom row: scatter plot and regional heatmap

Keep the layout clean:

- use consistent fonts
- avoid too many colors
- maintain spacing between elements
- ensure text remains readable

### Step 10: Format for clarity

Use these formatting principles:

- Use a maximum of 5 colors in the dashboard
- Keep all titles clear and short
- Use currency formatting for claim amounts
- Use percentage formatting for rates
- Use tooltips to explain values
- Ensure text contrast is readable

### Step 11: Publish or export the final workbook

When the dashboard is complete:

- Save the workbook as `healthcare_insurance_dashboard.twb`
- If requested, package it into a `.twbx` file for export
- Test all filters, tooltips, and chart interactions
- Check that the dashboard still works when changing date or region filters

### Step 12: Checklist before submission

Before final submission, confirm:

- [ ] Data source is connected to MySQL or a valid backup file
- [ ] All charts have titles and labels
- [ ] Dashboard includes at least 6 charts
- [ ] Filters work correctly
- [ ] KPIs are readable and formatted properly
- [ ] Storyboard is coherent and business-oriented
- [ ] Workbook has been saved and tested

---

### Detailed Tableau Operations Checklist (Complete Implementation Guide)

This section is the full operational checklist for every Tableau task in the project. It is written to match the depth of the SQL section so that the dashboard build is reproducible and review-ready.

#### 1) Data source setup and connection

- [ ] Open Tableau Desktop.
- [ ] Select the connector for the source used in the project:
  - Preferred: MySQL live connection to `healthcare_claims_db`
  - Fallback: CSV import from `./data/processed/claims_analysis.csv`
- [ ] Connect using the correct server details, database name, username, and password.
- [ ] If using a live MySQL connection, select the view `v_claims_tableau`.
- [ ] If using a CSV file, confirm that all required columns are available:
  - `claim_id`, `claim_date`, `claim_amount`, `claim_status`, `region`, `hospital_name`, `hospital_type`, `provider_name`, `specialty`, `age`, `bmi`, `smoking_status`, `denial_flag`, etc.
- [ ] Review the data source preview to confirm the row count and field names are correct.
- [ ] Rename fields if required so they are clear and presentation-ready (for example, `Claim Amount` instead of `claim_amount`).


#### 2) Define data types correctly in Tableau

- [ ] Set `claim_date` as a Date field.
- [ ] Set `claim_amount` as a Number (Decimal) field.
- [ ] Set `claim_status` as a String field.
- [ ] Set `region`, `hospital_name`, `provider_name`, `specialty`, `sex`, `smoking_status` as Strings.
- [ ] Set `hospital_id`, `provider_id`, `claim_id`, `patient_id` as Whole Numbers.
- [ ] Set `age`, `bmi`, `bed_count`, and `num_dependents` as Number fields.
- [ ] Set calculated KPI fields such as denial rate, approval rate, and cost per claim as Decimal or Percentage as required.
- [ ] Check field roles in the Data pane so Tableau recognizes date, dimension, and measure behavior correctly.


#### 3) Create hierarchy: Region → Hospital → Provider

- [ ] Right-click the field `region` in the Data pane.
- [ ] Select Create → Hierarchy.
- [ ] Name the hierarchy `Location Hierarchy` or `Region → Hospital → Provider`.
- [ ] Add the following fields in order:
  1. `region`
  2. `hospital_name`
  3. `provider_name`
- [ ] Confirm the hierarchy works as a drill-down structure in a table or tree view.
- [ ] Use the hierarchy in a sheet to show progressive detail from region to hospital to provider.
- [ ] Validate that each level is unique and understandable to a business user.


#### 4) Create date hierarchy: Year → Quarter → Month

- [ ] Right-click the `claim_date` field.
- [ ] Select Create → Hierarchy.
- [ ] Name it `Date Hierarchy`.
- [ ] Add `Year`, `Quarter`, and `Month` in the correct order.
- [ ] If Tableau does not automatically interpret the date parts, create custom date calculations using:
  - `YEAR([Claim Date])`
  - `DATENAME('quarter', [Claim Date])`
  - `DATENAME('month', [Claim Date])`
- [ ] Use this hierarchy to build monthly and quarterly trend analyses.
- [ ] Ensure filters and drill-down work correctly across all sheets.


#### 5) Build a clean Tableau field structure

- [ ] Keep the data source organized into clearly labeled dimensions and measures.
- [ ] Group fields logically:
  - Demographic fields: `age`, `sex`, `smoking_status`, `bmi`, `age_group`
  - Geographic fields: `region`, `location`, `hospital_name`
  - Operational fields: `claim_status`, `provider_name`, `specialty`, `hospital_type`
  - Financial fields: `claim_amount`, `claim_status`, `cost_tier`, `denial_flag`
- [ ] Verify there are no duplicate field names or ambiguous date fields.
- [ ] Rename fields to cleaner business labels before building visualizations.


#### 6) Create calculated fields required for analysis

Create and validate each of these fields in Tableau:

- [ ] `Cost Tier`
  - Example formula:
    ```
    IF [Claim Amount] >= 20000 THEN 'High'
    ELSEIF [Claim Amount] >= 10000 THEN 'Medium'
    ELSE 'Low'
    END
    ```

- [ ] `Denial Flag`
  - Example formula:
    ```
    IF [Claim Status] = 'Denied' THEN 1 ELSE 0 END
    ```

- [ ] `Approval Flag`
  - Example formula:
    ```
    IF [Claim Status] = 'Approved' THEN 1 ELSE 0 END
    ```

- [ ] `Age Group`
  - Example formula:
    ```
    IF [Age] < 30 THEN '18-29'
    ELSEIF [Age] < 40 THEN '30-39'
    ELSEIF [Age] < 50 THEN '40-49'
    ELSEIF [Age] < 60 THEN '50-59'
    ELSE '60+'
    END
    ```

- [ ] `BMI Category`
  - Example formula:
    ```
    IF [BMI] < 18.5 THEN 'Underweight'
    ELSEIF [BMI] < 25 THEN 'Normal'
    ELSEIF [BMI] < 30 THEN 'Overweight'
    ELSE 'Obese'
    END
    ```

- [ ] `Average Cost per Claim`
  - Example formula:
    ```
    SUM([Claim Amount]) / COUNT([Claim ID])
    ```

- [ ] `Denial Rate`
  - Example formula:
    ```
    SUM(IIF([Claim Status] = 'Denied', 1, 0)) / COUNT([Claim ID])
    ```

- [ ] `Approval Rate`
  - Example formula:
    ```
    SUM(IIF([Claim Status] = 'Approved', 1, 0)) / COUNT([Claim ID])
    ```

- [ ] `Top N Hospital Rank` (optional parameterized ranking logic)
  - Use a parameter to control top N values in rank-based charts.


#### 7) Build parameters for dashboard interactivity

- [ ] Create a date range parameter or use a date filter for `claim_date`.
- [ ] Create a `Top N` parameter with values like 5, 10, 15, 20.
- [ ] Create a measure selector parameter if a single sheet must toggle between `Total Cost`, `Average Cost`, and `Denial Rate`.
- [ ] Test the parameter values to ensure charts update correctly.
- [ ] Use parameter controls in the dashboard for business-friendly interaction.


#### 8) Create the required worksheets

##### Worksheet 1: Monthly Cost Trend

- [ ] Drag `claim_date` to Columns.
- [ ] Set the date level to Month.
- [ ] Drag `SUM(Claim Amount)` to Rows.
- [ ] Add a line chart.
- [ ] Add a reference line for average monthly cost.
- [ ] Optional: color by `claim_status` or `region`.
- [ ] Label the sheet `Monthly Spend Trend`.

##### Worksheet 2: KPI Summary

- [ ] Create four KPI cards:
  - Total Claims
  - Total Cost
  - Average Cost per Claim
  - Approval Rate
- [ ] Use `COUNT([Claim ID])`, `SUM([Claim Amount])`, `AVG([Claim Amount])`, `AVG([Approval Flag])`.
- [ ] Format using currency, percentage, and whole-number display rules.
- [ ] Give the sheet a title such as `Executive KPI Summary`.

##### Worksheet 3: Hospital Pareto Analysis

- [ ] Drag `hospital_name` to Rows.
- [ ] Drag `SUM(Claim Amount)` to Columns.
- [ ] Sort descending by total cost.
- [ ] Add a cumulative percentage line on the secondary axis.
- [ ] Mark the 80% threshold to demonstrate Pareto concentration.
- [ ] Label the sheet `Cost Concentration by Hospital`.

##### Worksheet 4: Denial vs Cost Scatter/Bubble Chart

- [ ] Place `Denial Rate` on X-axis.
- [ ] Place `Average Claim Amount` on Y-axis.
- [ ] Use `Claim Volume` as bubble size.
- [ ] Color marks by `hospital_type` or `region`.
- [ ] Add labels for hospitals with outlier behavior.
- [ ] Label the sheet `Denial vs Cost by Hospital`.

##### Worksheet 5: Regional Performance Heatmap

- [ ] Use `region` as the geographic dimension.
- [ ] Color the map using `Average Claim Amount` or `Denial Rate`.
- [ ] Add tooltips showing region-level metrics.
- [ ] Label the sheet `Regional Cost and Denial Profile`.

##### Worksheet 6: Provider Drill-down Table

- [ ] Use a table or bar chart with `region`, `hospital_name`, `provider_name`, and `specialty`.
- [ ] Display `Claim Volume`, `Average Cost`, and `Denial Rate` by provider.
- [ ] Keep it readable and use filters to isolate specific hospitals or regions.
- [ ] Label the sheet `Provider Performance Detail`.

##### Worksheet 7: Demographic Risk View

- [ ] Use `age_group`, `smoking_status`, or `bmi_category` on the view.
- [ ] Display `Average Claim Amount` or `Claim Volume`.
- [ ] This supports the risk segmentation story.
- [ ] Label the sheet `Patient Risk Segments`.

##### Worksheet 8: Claims Status Breakdown

- [ ] Create a bar or stacked bar chart for `claim_status`.
- [ ] Add breakdown by `region` or `hospital_type` if needed.
- [ ] Label the sheet `Claims Status Distribution`.


#### 9) Add filters and interaction controls

- [ ] Add a global filter for `Date Range`.
- [ ] Add a filter for `region`.
- [ ] Add a filter for `claim_status`.
- [ ] Add a filter for `hospital_type`.
- [ ] Add a filter for `smoking_status`.
- [ ] Add a filter for `specialty` if using provider analysis.
- [ ] Ensure all sheets update correctly when filters are changed.
- [ ] Use single-select or multi-select options depending on the story.
- [ ] If a chart is meant to be used as a drill-down, set the filter action to work with all sheets.


#### 10) Dashboard actions and drill-down behavior

- [ ] Add a filter action from the region chart to all other sheets.
- [ ] Add a highlight action for a hospital name across multiple charts.
- [ ] If desired, add a parameter action to switch the top-N view dynamically.
- [ ] Add a URL action only if a detail page or external resource is required.
- [ ] Keep interaction design simple and intuitive for business users.
- [ ] Ensure dashboard actions do not create confusing or broken dependencies.


#### 11) Design the dashboard layout

- [ ] Create a new dashboard titled `Healthcare Claims and Denial Dashboard`.
- [ ] Place the KPI cards in the top row.
- [ ] Place trend and Pareto visualizations in the middle row.
- [ ] Place scatter and geographic views in the bottom row.
- [ ] Keep all chart titles short and readable.
- [ ] Use a maximum of 5 colors throughout the dashboard.
- [ ] Ensure alignment and spacing are consistent.
- [ ] Use readable fonts and avoid visual clutter.


#### 12) Add narrative storytelling to the workbook

The dashboard should not only show charts — it should tell a business story.

- [ ] Story Point 1: The Cost Landscape
  - Show total spend, trend, and cost growth.
- [ ] Story Point 2: Where the Money Goes
  - Use Pareto analysis to identify concentration of claims spend.
- [ ] Story Point 3: Denial Hotspots
  - Use the scatter plot to identify hospitals with high denial rate and high cost.
- [ ] Story Point 4: Risk and Demographic Drivers
  - Use age, BMI, and smoking segmentation to explain cost variation.
- [ ] Story Point 5: Recommendations and Next Steps
  - Highlight the operational interventions suggested by the analysis.


#### 13) Format and polish for executive quality

- [ ] Apply consistent currency formatting to claim and cost measures.
- [ ] Format percentages with one or two decimal places.
- [ ] Use tooltips to explain key numbers.
- [ ] Ensure chart labels are large enough to read in presentation mode.
- [ ] Use neutral and professional colors with accessible contrast.
- [ ] Remove unnecessary marks, gridlines, and chart clutter.
- [ ] Align dashboard containers for a clean executive layout.


#### 14) Final QA checklist before submission

- [ ] All worksheets load without errors.
- [ ] Data source is valid and refreshes correctly.
- [ ] All filter actions work properly.
- [ ] All dashboard titles and labels are correct.
- [ ] KPI cards update correctly when filters are changed.
- [ ] At least 6 visualizations are included.
- [ ] The workbook is saved as `.twb` and packaged as `.twbx` if required.
- [ ] The dashboard is readable and presentation-ready.
- [ ] Final workbook is tested on freshly opened Tableau before submission.


#### 15) Tableau deliverables checklist

- [ ] MySQL live connection or CSV fallback data source connected
- [ ] Correct field types assigned
- [ ] Hierarchies created: Region → Hospital → Provider and Year → Quarter → Month
- [ ] Calculated fields created and validated
- [ ] Filters and parameters implemented
- [ ] At least 6 analysis sheets created
- [ ] Dashboard assembled with narrative flow
- [ ] Interactions and drill-down implemented
- [ ] Workbook exported and tested

---

### **PHASE 3: Tableau Dashboard Engineering (Days 6-8 | 5-6 hours)**

This phase is where the SQL analysis becomes a presentation-ready dashboard. If you are new to Tableau, do not try to make the final dashboard in one step. Build it in a sequence so the logic stays simple and easy to debug.

---

## Beginner Step-by-Step Guide for Phase 3

### Day 6: Data Connection & Foundational Visualizations

#### Step 3.1: Connect Tableau to the live MySQL data source

1. Open Tableau Desktop.
2. Click on “Connect to Data”.
3. Select “MySQL” from the list of connectors.
4. Enter your server information:
   - Server: localhost or your MySQL host
   - Port: 3306 (unless configured differently)
   - Username and password
   - Database: `healthcare_claims_db`
5. Choose the “Live” connection option.
6. In the list of available objects, select the view `v_claims_tableau`.
7. Click “Sheet 1” to begin building charts.

Important beginner note:

- Use your live SQL view as the main data source.
- Do not start by building a dashboard from multiple raw tables.
- Keep one clean source with all required analysis fields already exposed by SQL.

#### Step 3.2: Understand the data fields

When the data loads, check whether the following fields are available:

- `claim_id`
- `claim_date`
- `claim_amount`
- `claim_status`
- `region`
- `hospital_name`
- `hospital_type`
- `provider_name`
- `specialty`
- `smoker`
- `age_group`
- `bmi_category`
- `cost_tier`
- `denial_flag`

If some fields are missing, go back to the SQL view and add them.

#### Step 3.3: Set the field roles correctly

In the data pane:

- Date fields: set as Date
- Currency fields: set as Number (Decimal)
- Status fields: set as String
- Counts: set as Number (Whole)
- Percent/ratio fields: set as Number (Decimal)

This helps Tableau calculate measures correctly and makes the charts behave properly.

#### Step 3.4: Create the first chart

Create a worksheet called “Monthly Spend Trend”.

- Drag `claim_date` to Columns.
- Change the date granularity to Month.
- Drag `SUM(claim_amount)` to Rows.
- This creates a line chart showing cost over time.

This is the simplest starting point for the dashboard and matches the project requirement for a time series view.

#### Step 3.5: Add the required foundational charts

Create these 3 visuals first:

1. Time Series Trend Chart
   - Columns: `claim_date` (Month)
   - Rows: `SUM(claim_amount)`
   - Add a trend line if needed
   - Optional: color by `claim_status`

2. Volume vs Value by Hospital
   - Use hospital as the dimension
   - Left axis: count of claims
   - Right axis: average claim amount
   - This is a dual-axis chart and is useful for operational review

3. Top N Hospitals by Volume
   - Sort hospitals by claim count descending
   - Add a cumulative line or reference line
   - This makes it easy to identify the most active institutions

#### Required workbook sheets for `healthcare_insurance_dashboard.twbx`

The final Tableau workbook should contain a minimum of 6 sheets; the recommended structure is 8 sheets to fully satisfy the project brief and the executive dashboard story.

1. `Executive KPI Summary`  
   Top-level summary with total claims, total cost, average cost per claim, approval rate.

2. `Monthly Spend Trend`  
   Time-series view of claim spend over time with monthly granularity and trend line.

3. `Cost Concentration by Hospital`  
   Pareto/80-20 chart showing how a small number of hospitals account for most spend.

4. `Denial vs Cost by Hospital`  
   Scatter/bubble chart for denial rate vs average claim amount by hospital.

5. `Regional Cost and Denial Profile`  
   Geographic or regional comparison of cost and denial patterns.

6. `Provider Performance Detail`  
   Drill-down table or bar chart by region, hospital, provider, and specialty.

7. `Patient Risk Segments`  
   Demographic segmentation view using age group, smoking status, or BMI category.

8. `Claims Status Distribution`  
   Breakdown of approved, denied, and pending claims by region or hospital type.

The final dashboard should combine these sheets into a single executive story titled `Healthcare Claims and Denial Dashboard`, with filters for date range, region, claim status, hospital type, and smoking status.

#### Step 3.6: Build the first calculated fields

Go to Analysis → Create Calculated Field and create:

- Cost Tier
  ```
  IF [Claim Amount] >= 20000 THEN 'High'
  ELSEIF [Claim Amount] >= 10000 THEN 'Medium'
  ELSE 'Low'
  END
  ```

- Denial Flag
  ```
  IF [Claim Status] = 'Denied' THEN 1 ELSE 0 END
  ```

- Age Group
  ```
  IF [Age] < 30 THEN '18-29'
  ELSEIF [Age] < 40 THEN '30-39'
  ELSEIF [Age] < 50 THEN '40-49'
  ELSEIF [Age] < 60 THEN '50-59'
  ELSE '60+'
  END
  ```

- BMI Category
  ```
  IF [BMI] < 18.5 THEN 'Underweight'
  ELSEIF [BMI] < 25 THEN 'Normal'
  ELSEIF [BMI] < 30 THEN 'Overweight'
  ELSE 'Obese'
  END
  ```

These match the project plan and give you dimensions for segmentation and risk analysis.

---

### Day 7: Executive KPI Dashboard & Advanced Visualizations

#### Step 3.7: Build 4 KPI cards

Create a dashboard with four KPI tiles at the top:

1. Total Claims
   - Use `COUNT([Claim ID])`
2. Total Cost
   - Use `SUM([Claim Amount])`
3. Approval Rate
   - Use `AVG([Approval Flag])` or a calculated approval measure
4. Average Cost per Claim
   - Use `SUM([Claim Amount]) / COUNT([Claim ID])`

Format them as:

- Total Cost → currency
- Approval Rate → percentage
- Average Cost → currency
- Total Claims → whole number

Add small trend arrows if possible.

#### Step 3.8: Build advanced chart 1 — Pareto chart

Create a sheet called “Cost Concentration”.

- Drag `hospital_name` to Rows
- Drag `SUM(claim_amount)` to Columns
- Sort descending by total cost
- Add a cumulative percentage line on the secondary axis
- Include a marker at 80%

This helps show the project requirement: “Top X hospitals drive Y% of cost.”

#### Step 3.9: Build advanced chart 2 — Scatter/Bubble matrix

Create a sheet called “Denial vs Cost”.

- X-axis: Denial Rate
- Y-axis: Average Claim Amount
- Size: Claim Volume
- Color: Hospital Type

This is a strong executive-level chart because it reveals outlier hospitals and denial-risk patterns.

#### Step 3.10: Build advanced chart 3 — Regional heatmap

Create a sheet called “Regional Spend”.

- Use `region` as the geographic dimension
- Color by average claim cost or denial rate
- Add tooltips for region-level numbers

If your Tableau version supports geographic mapping, this is ideal.

---

### Day 8: Dashboard Composition & Narrative Storyboard

#### Step 3.11: Assemble the dashboard layout

Create a new dashboard and arrange the visuals as follows:

- Top row: 4 KPI cards
- Middle row: time series chart + Pareto chart
- Bottom row: bubble chart + regional heatmap

Keep the layout simple and balanced.

Recommended layout principles:

- Read left-to-right and top-to-bottom
- Put the most important KPI cards at the top
- Use consistent spacing between tiles
- Keep titles short and clear
- Use no more than 5 colors

#### Step 3.12: Add filters

Add global filters for:

- Date Range
- Region
- Claim Status
- Hospital Type

To add a filter:

1. Drag the field to the Filters shelf
2. Choose the type (single value, range, or multiple values)
3. Place it at the top of the dashboard

#### Step 3.13: Enable dashboard interactions

Set up simple interactions:

- Filter action: select a region and all charts update
- Highlight action: click one hospital and highlight related metrics across charts
- Parameter actions: optional for Top N hospital view

For beginners, filter actions are enough.

#### Step 3.14: Add the narrative story

Your dashboard should tell a story, not just show charts. Use this story structure:

- Story Point 1: The Cost Landscape
- Story Point 2: Where the Money Goes
- Story Point 3: Denial Hotspots
- Story Point 4: Demographic Risk Factors
- Story Point 5: Recommendations

This matches the plan and makes the dashboard executive-friendly.

#### Step 3.15: Final QA check

Before submitting:

- [ ] All filters work
- [ ] All charts update correctly
- [ ] The dashboard has a clear title
- [ ] KPI cards are readable
- [ ] Colors are consistent
- [ ] No chart is overly cluttered
- [ ] Workbook is saved as `.twb` or packaged as `.twbx`

---

 

#### Day 6 - Data Connection & Foundational Visualizations (2 hours) - Person B

- [ ] **Task 3.1** - Configure Tableau data source

  - Preferred: live connection to MySQL using the view `v_claims_tableau`

  - Alternate: connect to processed CSV as a static export fallback

  - Define data types, hierarchies (Region → Hospital → Provider)

  - Create date hierarchy (Year → Quarter → Month)

  - Set up data relationships/joins if using multiple tables

  - For live access, use Tableau's MySQL connector with server, database, and credentials configured

 

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

**Last Updated:** 09 Sep 2026  

**Status:** Implementation Ready / Ready for Review ✅

 

