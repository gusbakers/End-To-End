# End-To-End

# Instacart Retail Analytics — End-to-End (SQL + Python)

## Problem
Understand **purchase behavior, re-order patterns, and demand timing** to support
**inventory planning** and **operational decisions** in online grocery retail.

## What This Project Shows
- End-to-end data pipeline ownership (raw → clean → SQL → KPIs → insights)
- Business-driven SQL analytics
- Clear translation from data to operational recommendations

## Dataset
Instacart Online Grocery Shopping Dataset (2017).  
Raw files are excluded due to size/licensing; the pipeline is fully reproducible.

## Tech Stack
- **SQL:** SQLite
- **Python:** pandas, matplotlib
- **Notebooks:** Jupyter (GitHub Codespaces)
- **Version Control:** Git + GitHub

## Pipeline Overview
1. Ingest raw CSVs into SQLite
2. Clean and validate transactional data
3. Execute versioned SQL queries
4. Generate KPIs and export visual outputs
5. Present business insights in a demo notebook

## Key Insights
- Identification of top-volume “anchor” products
- Re-order rate as a proxy for customer retention by department
- Clear demand peaks by day and hour for operational planning

## Outputs
Exported charts are available in `/outputs`.

## How to Run (GitHub Codespaces)
```bash
pip install -r requirements.txt
