# Instacart Grocery Analytics

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python)
![SQLite](https://img.shields.io/badge/SQLite-3-003B57?logo=sqlite&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

-----

I kept seeing Instacart mentioned in data job descriptions — “analyze purchase patterns”, “improve reorder predictions” — so I figured I’d actually dig into their public dataset and see what that work looks like in practice.

The dataset is from a [2017 Kaggle competition](https://www.kaggle.com/competitions/instacart-market-basket-analysis/data): 3.4M orders, ~200K users, 50K products. I focused on SQL analytics — the kind of questions an ops or inventory team would actually ask.

-----

## What I was trying to figure out

- Which products do people reliably come back for vs. buy once and forget?
- When are orders actually placed — and what does that mean for staffing?
- Do departments have meaningfully different reorder rates?
- Is basket size correlated with anything actionable (like organic produce)?

-----

## How it’s structured

```
instacart-analytics/
├── data/raw/                        # not committed — see setup below
├── sql/
│   ├── 01_reorder_rates.sql
│   ├── 02_demand_by_hour.sql
│   ├── 03_top_products.sql
│   ├── 04_basket_analysis.sql
│   └── 05_department_retention.sql
├── notebooks/
│   └── instacart_demo.ipynb
├── outputs/                         # charts, committed
├── src/
│   ├── ingest.py
│   └── clean.py
├── requirements.txt
└── run_pipeline.py
```

The pipeline goes: CSVs → SQLite → SQL queries → exported charts. `run_pipeline.py` handles all of it.

-----

## Setup

```bash
git clone https://github.com/yourusername/instacart-analytics.git
cd instacart-analytics
pip install -r requirements.txt
```

Download the data from Kaggle (free account needed):
https://www.kaggle.com/competitions/instacart-market-basket-analysis/data

Unzip into `data/raw/` so you have:

```
orders.csv
order_products__prior.csv
order_products__train.csv
products.csv
departments.csv
aisles.csv
```

Then:

```bash
python run_pipeline.py
jupyter notebook notebooks/instacart_demo.ipynb
```

-----

## What I found

**Reorder rates by department**
Produce sits at ~65% reorder rate. Personal care is around 38%. Makes sense — people buy bananas every week, they don’t reorder face wash at the same cadence. The gap is useful for inventory planning: tight stock management for high-reorder categories, more slack for low-reorder ones.

**Order timing**
Peak is 10am–2pm on weekends. Weeknight orders (8pm–midnight) basically drop off. Top hours:

```
10:00 → 284,728 orders
11:00 → 268,916 orders
14:00 → 231,482 orders
```

If you’re thinking about fulfillment capacity, Sunday morning is where it matters.

**Bananas are a weird anchor product**
They’re #1 in both volume and reorder rate. My read: people open the app specifically to buy bananas and fill the basket around that. Organic milk, Greek yogurt, avocados follow a similar pattern.

**Organic produce and basket size**
Orders that include organic produce items average ~1.4x the basket size of orders without. That’s an interesting promotional angle — lead with organic, not discounts.

-----

## One thing that surprised me

The reorder interval data was more consistent than I expected. For top products, the median days-between-orders is pretty tight — most people reorder bananas every 7 days, not “roughly weekly.” That kind of regularity is actually useful for demand forecasting.

Also: `add_to_cart_order` ended up being a decent signal. Products added first tend to have higher reorder rates — people build routines around how they shop.

-----

## Why SQLite and not Postgres

The dataset is a static snapshot, single user, no ingestion happening. Standing up a Postgres server for this would’ve been overkill. SQLite handles 3.4M rows fine and runs anywhere.

If this were a live pipeline with multiple analysts, Postgres would make sense. This isn’t that.

-----

## What I’d do differently

The SQL is all flat files right now. I’d use dbt if I revisited this — proper staging/mart layers would make the queries easier to test and the lineage clearer.

I’d also swap the Matplotlib exports for a Streamlit dashboard. Static charts work but they’re harder to share.

-----

## Charts

All visualizations are in `/outputs`. The notebook has them inline with context.

-----

📧 gaft-2727@outlook.com

 
