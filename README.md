# Healthcare Insurance Claim Analysis & Denial Patterns Dashboard

This project follows the execution plan in [Plan.md](Plan.md) and is structured for a MySQL 8.0 analytics workflow.

## Project structure

```text
Mini_project/
├── README.md
├── Plan.md
├── data/
│   ├── raw/
│   │   └── insurance_claims_raw.csv   # Add the Kaggle raw dataset here
│   └── processed/
│       └── claims_analysis.csv        # Final Tableau-ready export
├── report/
│   └── README.md
├── sql/
│   ├── 01_schema_creation.sql
│   ├── 02_data_loading.sql
│   ├── 03_data_retrieval_queries.sql
│   ├── 04_aggregation_analysis.sql
│   ├── 05_window_functions.sql
│   ├── 06_subqueries_cte.sql
│   ├── 07_statistical_analysis.sql
│   └── insurance_claim_analysis.sql
├── tableau/
│   └── README.md
└── .gitignore
```

## MySQL 8.0 setup

1. Create a local MySQL 8.0 database.
2. Copy the Kaggle raw CSV into both the project folder at `data/raw/insurance_claims_raw.csv` and the MySQL upload directory allowed by `secure_file_priv` (for example `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/insurance_claims_raw.csv`).
3. Run scripts in the following order:
   1. `sql/01_schema_creation.sql`
   2. `sql/02_data_loading.sql`
   3. `sql/03_data_retrieval_queries.sql`
   4. `sql/04_aggregation_analysis.sql`
   5. `sql/05_window_functions.sql`
   6. `sql/06_subqueries_cte.sql`
   7. `sql/07_statistical_analysis.sql`

## Database connection

```sql
CREATE DATABASE IF NOT EXISTS healthcare_claims_db;
USE healthcare_claims_db;
```

## Notes

- Use MySQL 8.0+ because it supports window functions, CTEs, and advanced analytic functions.
- For percentile-based segmentation, use MySQL-compatible window functions such as `PERCENT_RANK() OVER (ORDER BY ... )` instead of SQL Server/PostgreSQL syntax like `PERCENTILE_CONT(...) WITHIN GROUP (...)`.
- The raw CSV file in `data/raw/` should be placed there before running the ETL script.
- If MySQL returns Error 1290 or 3948, run `SHOW VARIABLES LIKE 'secure_file_priv';` and copy the dataset into that approved upload folder before loading. This is required by MySQL's `secure-file-priv` restriction.
- Update the CSV path in `sql/02_data_loading.sql` if your local machine uses a different directory.
