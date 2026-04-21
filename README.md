# 🚲 Bike Share Analytics — SQL + Power BI End-to-End Project

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Data Warehouse](https://img.shields.io/badge/Data%20Warehouse-Medallion%20Architecture-blue?style=for-the-badge)

---

## 📌 Project Overview

This project presents a complete **end-to-end data analytics pipeline** for a bike-sharing business, built using **SQL Server** and **Power BI**. The goal is to transform raw hourly ride data into actionable business insights through a structured data warehouse and an interactive dashboard.

The project simulates a real-world business analytics workflow — from raw data ingestion to executive-level KPI reporting.

---

## 🎯 Business Questions Answered

The dashboard is designed to answer 15 key business questions across 5 analysis areas:

| # | Business Question | Analysis Area |
|---|---|---|
| 1 | What is the monthly revenue trend across 2021 vs 2022? | Time & Trend |
| 2 | Which year performed better in total revenue and profit? | Time & Trend |
| 3 | What is the hourly demand pattern throughout a typical day? | Time & Trend |
| 4 | Which season generates the most revenue? | Seasonal Impact |
| 5 | How does weather condition affect total riders? | Seasonal Impact |
| 6 | Is there a correlation between temperature and rides? | Seasonal Impact |
| 7 | What is the split between casual and registered riders? | Rider Behavior |
| 8 | How do casual vs registered riders differ on weekdays vs weekends? | Rider Behavior |
| 9 | What hours are most popular for each rider type? | Rider Behavior |
| 10 | What is the profit by season? | Profitability |
| 11 | How did the price increase from 2021 to 2022 impact profit? | Profitability |
| 12 | Which months have the lowest profit margin? | Profitability |
| 13 | What are peak hours on working days vs non-working days? | Operations |
| 14 | Which day of the week consistently has the highest demand? | Operations |
| 15 | What is the holiday vs non-holiday demand difference? | Operations |

---

## 🏗️ Architecture — Medallion Data Warehouse

This project follows the **Bronze → Silver → Gold** layered architecture:

```
Raw CSV Files
     │
     ▼
┌─────────────┐
│   BRONZE    │  Raw data loaded as-is (no transformations)
│   Layer     │  bike_share_yr_0, bike_share_yr_1, cost_table
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   SILVER    │  Cleaned & transformed data
│   Layer     │  • Date casting (DATE type)
│             │  • Human-readable column names
│             │  • Season/weekday/weather labels
│             │  • Year decoded (0→2021, 1→2022)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    GOLD     │  Analytics-ready view
│    Layer    │  • UNION of both years
│             │  • JOIN with cost_table
│             │  • Revenue, Cost, Profit calculated
└──────┬──────┘
       │
       ▼
  Power BI Dashboard
```

---

## 📁 Repository Structure

```
bike-share-analytics/
│
├── 📂 sql/
│   ├── 📂 bronze/
│   │   ├── create_tables.sql          # DDL: bronze layer table definitions
│   │   └── load_bronze.sql            # Stored procedure: BULK INSERT from CSV
│   │
│   ├── 📂 silver/
│   │   ├── create_tables.sql          # DDL: silver layer table definitions
│   │   └── load_silver.sql            # Stored procedure: INSERT INTO SELECT with transformations
│   │
│   └── 📂 gold/
│       └── create_gold_view.sql       # Gold layer view: UNION + JOIN + calculated columns
│
├── 📂 powerbi/
│   └── bike_share_dashboard.pbix      # Power BI dashboard file
│
├── 📂 data/
│   └── 📂 sample/
│       ├── bike_share_yr_0.csv        # 2021 hourly ride data (17,290 rows)
│       ├── bike_share_yr_1.csv        # 2022 hourly ride data (17,468 rows)
│       └── cost_table.csv             # Pricing & COGS per year
│
└── README.md
```

---

## 📊 Dataset Description

### Source Files

| File | Description | Rows |
|---|---|---|
| `bike_share_yr_0.csv` | Hourly bike ride data — 2021 | 17,290 |
| `bike_share_yr_1.csv` | Hourly bike ride data — 2022 | 17,468 |
| `cost_table.csv` | Price per ride and COGS per year | 2 |

### Key Columns

| Column | Description | Values |
|---|---|---|
| `date` | Date of the record | DATE |
| `season` | Season name | Spring, Summer, Fall, Winter |
| `year` | Calendar year | 2021, 2022 |
| `month` | Month number | 1–12 |
| `hour` | Hour of the day | 0–23 |
| `day_of_week` | Day name | Monday–Sunday |
| `is_holiday` | Public holiday flag | 0 / 1 |
| `is_working_day` | Working day flag | 0 / 1 |
| `weather` | Weather condition | Clear, Mist, Light Snow/Rain, Heavy Rain |
| `temperature` | Normalized air temperature | 0–1 |
| `felt_temperature` | Normalized feels-like temp | 0–1 |
| `humidity` | Normalized humidity | 0–1 |
| `wind_speed` | Normalized wind speed | 0–1 |
| `rider_type` | Type of rider | casual / registered |
| `riders` | Number of rides in that hour | INT |
| `price` | Revenue per ride | 3.99 (2021), 4.99 (2022) |
| `COGS` | Cost per ride | 1.24 (2021), 1.56 (2022) |
| `revenue` | riders × price | Calculated |
| `cost` | riders × COGS | Calculated |
| `profit` | riders × (price − COGS) | Calculated |

---

## 🔧 How to Run This Project

### Prerequisites

- Microsoft SQL Server (2019 or later)
- SQL Server Management Studio (SSMS)
- Power BI Desktop (latest version)
- The 3 CSV data files

### Step 1 — Set Up the Database

```sql
-- Create the database
CREATE DATABASE BikeShareDW;
GO

-- Create schemas
USE BikeShareDW;
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
GO
```

### Step 2 — Create Bronze Tables

```bash
Run: sql/bronze/create_tables.sql
```

### Step 3 — Load Bronze Data

```sql
-- Update file paths to match your local machine first
EXEC bronze.load_bike_bronze;
```

```bash
Run: sql/bronze/load_bronze.sql
```

### Step 4 — Create and Load Silver Tables

```bash
Run: sql/silver/create_tables.sql
Run: sql/silver/load_silver.sql
```

```sql
EXEC silver.load_bike_silver;
```

### Step 5 — Create Gold View

```bash
Run: sql/gold/create_gold_view.sql
```

### Step 6 — Connect Power BI

1. Open Power BI Desktop
2. Click **Get Data → SQL Server**
3. Enter your server name and database `BikeShareDW`
4. Select the gold view
5. Open `powerbi/bike_share_dashboard.pbix`

---

## 📐 SQL Transformations Summary

### Bronze → Silver

| Column | Transformation |
|---|---|
| `dteday` (NVARCHAR) | → `date` (DATE) using `TRY_CONVERT` with mixed format handling |
| `season` (INT) | → `season` (NVARCHAR): 1=Spring, 2=Summer, 3=Fall, 4=Winter |
| `yr` (INT 0/1) | → `year` (INT): 0=2021, 1=2022 |
| `weekday` (INT) | → `day_of_week` (NVARCHAR): 0=Sunday … 6=Saturday |
| `weathersit` (INT) | → `weather` (NVARCHAR): 1=Clear, 2=Mist, 3=Light Snow/Rain, 4=Heavy Storm |
| All columns | → Renamed to human-readable names |

### Silver → Gold

```sql
-- Gold view logic (simplified)
SELECT
    s.*,
    c.price,
    c.COGS,
    s.riders * c.price                AS revenue,
    s.riders * c.COGS                 AS cost,
    s.riders * (c.price - c.COGS)     AS profit
FROM (
    SELECT * FROM silver.bike_share_yr_0
    UNION ALL
    SELECT * FROM silver.bike_share_yr_1
) s
JOIN silver.cost_table c ON s.year = CASE c.yr WHEN 0 THEN 2021 WHEN 1 THEN 2022 END
```

---

## 📈 Dashboard KPIs

### Cards (Top Row)

| KPI | DAX Measure |
|---|---|
| Total Revenue | `SUM(revenue)` |
| Total Profit | `SUM(profit)` |
| Profit Margin % | `DIVIDE(SUM(profit), SUM(revenue)) * 100` |
| Total Rides | `SUM(riders)` |
| Avg Revenue Per Ride | `DIVIDE(SUM(revenue), SUM(riders))` |

### Visuals

| Visual | Type | X-Axis | Y-Axis / Values |
|---|---|---|---|
| Monthly Revenue Trend | Line Chart | Month | Revenue (2021 vs 2022) |
| Revenue by Season | Bar Chart | Season | Revenue |
| Hourly Demand | Line Chart | Hour | Avg Riders |
| Casual vs Registered | Donut Chart | Rider Type | Total Riders |
| Demand by Day of Week | Bar Chart | Day of Week | Total Riders |
| Weather Impact | Bar Chart | Weather | Total Riders |
| Profit by Season | Bar Chart | Season | Profit |

---

## 💡 Key Insights Preview

> *(To be filled after dashboard completion)*

- 📈 Revenue grew by **X%** from 2021 to 2022
- ☀️ **Summer** is the highest-revenue season
- 🕗 **8am and 5pm** are peak demand hours (commuter pattern)
- 🌧️ Bad weather reduces ridership by up to **X%**
- 👥 Registered riders account for **~X%** of all rides

---

## 🧠 Skills Demonstrated

- ✅ Data Warehouse Design (Medallion Architecture)
- ✅ SQL Server — DDL, Stored Procedures, BULK INSERT
- ✅ Data Cleaning & Transformation (Silver Layer)
- ✅ Data Modeling — Views, JOINs, UNION ALL
- ✅ Business KPI Definition & Analysis
- ✅ Power BI — DAX Measures, Interactive Dashboards
- ✅ End-to-End Analytics Pipeline

---

## 👨‍💻 Author

**Youssef** — Data Analyst & Computer Engineering Student  
Mansoura University, Egypt  
📧 [youssefalaraby531@gmail.com]  
---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

*Built as part of a portfolio project demonstrating end-to-end data analytics skills using SQL Server and Power BI.*
