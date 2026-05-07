# Uber Data Analytics - SQL Relational Project 🚗📱

## 📌 Project Overview
This project simulates a real-world data analysis scenario for **Uber**. Using a relational database with three interconnected tables (Trips, Clients, and Drivers), I performed a deep-dive analysis to extract business insights regarding customer behavior, driver performance, and operational efficiency.

The focus of this project was to master **complex SQL joins**, **conditional logic**, and **time-series analysis** to answer specific business questions.

## ⚙️ The Data Pipeline & Structure
Before running the analysis, I performed a **Data Cleaning** phase using **Python (Pandas)** to ensure that dates were correctly formatted and that there were no inconsistent values in the pricing and distance columns.

### Relational Schema
The analysis is based on three main entities:
- **Clients_Uber:** Profiles, musical preferences, and total spending.
- **Chauffeurs_Uber:** Ratings, languages spoken, and security training.
- **Trajets_Uber (Fact Table):** Details of each trip (Price, Distance, Traffic, Ratings).



## 💻 SQL Technical Highlights
I implemented advanced SQL techniques to solve 18 different business problems:

### 1. Relational Joins (LEFT JOIN)
I used joins to correlate data across tables, such as:
- **Music & Service Impact:** Analyzing if customer musical preferences correlate with high-end services like *UberBlack*.
- **Driver Performance:** Linking driver ratings to specific traffic conditions to evaluate resilience during peak hours.

### 2. Conditional Logic (CASE WHEN)
I categorized data to create segments for the business:
- **Client Loyalty:** Segregation between "Loyal" (>30 trips) and "Occasional" customers.
- **Price Categorization:** Grouping trips into "Low", "Medium", and "High" price buckets.
- **Driver Experience:** Classifying drivers as "Beginner", "Experienced", or "Veteran" based on their trip history.

### 3. Time-Series & Granular Reporting
- **Weekend vs Weekday:** Using `DATE_FORMAT()` to compare average trip distances based on the day of the week.
- **Monthly Reporting (2023):** Building a comprehensive monthly report summarizing revenue, trip counts, and average ratings by service type.

## 📊 Key Business Insights
- **Pricing Strategy:** Identifying how the driver's spoken language or traffic conditions affect the average trip price.
- **Customer Satisfaction:** Correlation analysis between customer musical preferences and driver ratings.
- **Safety Impact:** Evaluating if "Security Training" significantly improves driver ratings and total trip volume.

## 📂 Project Resources
- **SQL Script:** `uber_analysis_queries.sql` 
- **Data:** Available in the SQL file headers.

