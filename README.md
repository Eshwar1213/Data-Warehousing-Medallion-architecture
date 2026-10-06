# Data Warehouse Project

## 📌 Project Overview

Welcome to the **Data Warehouse Project**.

This project demonstrates the development of a modern data warehouse using **MySQL** and the **Medallion Architecture**, consisting of **Bronze, Silver, and Gold layers**.

The project integrates data from **CRM and ERP source systems** provided as CSV files, performs data cleansing and transformation, and creates a business-ready **Gold layer** using a **Star Schema** for analytical reporting.

The complete workflow includes:

- Data ingestion
- Data cleansing
- Data transformation
- Data integration
- Data modeling
- Data quality validation
- Analytical reporting


---

# 🏗️ Data Architecture

The project follows the **Medallion Architecture**:

```text
                    ┌──────────────────────┐
                    │      CRM CSV         │
                    │   Source System      │
                    └──────────┬───────────┘
                               │
                               │
                    ┌──────────▼───────────┐
                    │      ERP CSV          │
                    │   Source System       │
                    └──────────┬────────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │       BRONZE         │
                    │      Raw Data        │
                    │                      │
                    │ • CRM Tables         │
                    │ • ERP Tables         │
                    └──────────┬───────────┘
                               │
                         ETL / Cleaning
                               │
                               ▼
                    ┌──────────────────────┐
                    │       SILVER         │
                    │  Cleaned & Transformed│
                    │       Data           │
                    └──────────┬───────────┘
                               │
                     Business Transformation
                               │
                               ▼
                    ┌──────────────────────┐
                    │        GOLD          │
                    │    Star Schema       │
                    │                      │
                    │ • dim_customers      │
                    │ • dim_products       │
                    │ • fact_sales         │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │ Analytics & Reporting │
                    └──────────────────────┘
