# Instacart Grocery Analytics

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python)
![SQLite](https://img.shields.io/badge/SQLite-3-003B57?logo=sqlite&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

-----

Online grocery is an interesting data problem because the purchase patterns are so predictable — and that predictability is actually the business model. If you know that someone reorders almond milk every 9 days, you can time promotions, pre-stage inventory, and reduce stockouts. That’s not a data science problem. That’s a SQL problem.

I used the [Instacart 2017 dataset](https://www.kaggle.com/competitions/instacart-market-basket-analysis/data) — 3.4 million orders, 200K users, 50K products — to build an analytical pipeline focused on exactly that: understanding reorder behavior, demand timing, and which products actually drive basket size.

-----

## The questions I actually tried to answer

Not “explore the data” in the abstract sense. Specific questions an inventory or ops team would care about:

- Which products do people come back for, vs which ones they try once and never buy again?
- What time of day and day of week should you prioritize fulfillment staffing?
- Which departments have the highest retention signal (reorder rate as a loyalty proxy)?
- Are there products that consistently anchor large baskets?

The answers are below in the insights section. The queries are in `sql/`.

-----

## What this project is

An end-to-end analytical pipeline:

1. Raw CSVs ingested into SQLite
1. Data cleaned and validated with Python
1. SQL queries run against the database to generate KPIs
1. Results exported as charts to `/outputs`
1. Everything tied together in a demo notebook

It’s not a machine learning project. It’s a data engineering + SQL analytics project, which is honestly more representative of what a data analyst or junior data engineer does day-to-day.

-----

## Project structure

```
instacart-analytics/
│
├── data/
│   └── raw/               # not committed (see below for download)
│
├── sql/
│   ├── 01_reorder_rates.sql
│   ├── 02_demand_by_hour.sql
│   ├── 03_top_products.sql
│   ├── 04_basket_analysis.sql
│   └── 05_department_retention.sql
│
├── notebooks/
│   └── instacart_demo.ipynb   # full walkthrough with outputs
│
├── outputs/               # exported charts (committed)
├── src/
│   ├── ingest.py          # loads CSVs into SQLite
│   └── clean.py           # validation and deduplication
│
├── requirements.txt
└── run_pipeline.py
```

-----

## Getting it running

**1. Clone the repo**

```bash
git clone https://github.com/yourusername/instacart-analytics.git
cd instacart-analytics
pip install -r requirements.txt
```

**2. Download the data**

Get the dataset from Kaggle (free account required):
[kaggle.com/competitions/instacart-market-basket-analysis/data](https://www.kaggle.com/competitions/instacart-market-basket-analysis/data)

Download and unzip into `data/raw/`. You should have:

```
data/raw/
├── orders.csv
├── order_products__prior.csv
├── order_products__train.csv
├── products.csv
├── departments.csv
└── aisles.csv
```

**3. Run the pipeline**

```bash
python run_pipeline.py
```

This ingests the CSVs into a local SQLite database, runs all the SQL queries, and exports charts to `/outputs`.

**4. Explore the notebook**

```bash
jupyter notebook notebooks/instacart_demo.ipynb
```

-----

## Key findings

**Reorder rate by department**

Produce has the highest reorder rate at 65%, which makes sense — people buy bananas and avocados every week. Personal care is at 38%. That gap matters for inventory planning: high-reorder categories need tight stock management, low-reorder categories have more tolerance for variability.

**Demand by hour**

Orders peak between 10am and 2pm on Saturdays and Sundays. The lowest volume is weekday nights (8pm–midnight). If you’re allocating fulfillment capacity, Sunday morning is where you need to be.

```
Top hours for order volume:
  10:00 →  284,728 orders
  11:00 →  268,916 orders
  14:00 →  231,482 orders
  15:00 →  218,543 orders
```

**Top reordered products**

Bananas are number one by a wide margin — not just volume, but reorder rate. They’re what I’d call an anchor product: the thing people specifically open the app to buy, then fill the rest of the basket around. Organic milk, Greek yogurt, and avocados follow a similar pattern.

**Basket size**

Orders with organic produce items average 1.4x the basket size of orders without. That’s a promotion angle: lead with organic, not with discounts.

-----

## On using SQLite instead of PostgreSQL

Honest answer: SQLite was the right call for this specific project.

The dataset is a static snapshot — 3.4M rows, no new data coming in, single user (me). Setting up a PostgreSQL server to analyze a CSV dump would have been unnecessary overhead. SQLite handles this volume fine and runs anywhere with zero configuration.

If this were a live system with multiple analysts querying it or a pipeline refreshing daily, I’d use PostgreSQL. That’s a different problem. This isn’t that.

-----

## What surprised me

The reorder interval data was more consistent than I expected. For top products, the median days-between-orders is surprisingly tight — most people reorder bananas every 7 days, not “roughly weekly.” That kind of behavioral regularity is genuinely useful for demand forecasting.

Also, the add-to-cart order column (`add_to_cart_order`) turned out to be an interesting signal. Products added first tend to have higher reorder rates. People build muscle memory around how they shop.

-----

## What I’d do differently

The SQL is all flat files right now. If I revisited this, I’d use dbt to add proper staging and mart layers — raw → cleaned → business-ready. The queries would be easier to test and the lineage would be clearer.

I’d also build a simple dashboard instead of static chart exports. Matplotlib works but Plotly with a Streamlit front-end would be much more shareable.

-----

## Charts

All exported visualizations are in `/outputs`. The notebook renders them inline with context.

-----

## Connect

Questions or feedback welcome.

📧 gaft-2727@outlook.com  
