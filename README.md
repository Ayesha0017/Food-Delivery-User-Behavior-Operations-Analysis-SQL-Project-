# Food Delivery User Behavior & Operations Analysis (SQL Project)

## Project Overview

This project analyzes user behavior, conversion funnel, revenue trends, and retention patterns for a food delivery platform using SQL.

The goal is to uncover actionable insights to improve:

* User conversion
* Delivery efficiency
* Customer retention
* Revenue stability

---

## Dataset Description

### 1. Users (`fd_users.csv`)

* `user_id`
* `signup_date`

### 2. Sessions (`fd_sessions.csv`)

* `session_id`
* `user_id`
* `session_start`
* `session_type` (browse, search, checkout)

### 3. Orders (`fd_orders.csv`)

* `order_id`
* `user_id`
* `order_time`
* `order_value`
* `delivery_time_minutes`

---

## Key Business Questions

### Funnel Analysis

* How many users move from browse → search → checkout → order?
* Where are the biggest drop-offs?

### Conversion Behavior

* How long does it take users to place their first order?
* How many sessions are needed before conversion?

### Engagement

* Daily Active Users (DAU)
* Identification of power users

### Revenue & Operations

* Daily revenue trends and drop detection
* Average Order Value (AOV)
* Delivery performance

### Retention

* Cohort retention analysis
* Repeat order rate

---

## SQL Techniques Used

* Joins (LEFT JOIN, INNER JOIN)
* Window Functions (`LAG`, `NTILE`, `PERCENTILE_CONT`)
* Aggregations (`AVG`, `COUNT`, `SUM`)
* Date functions (`DATEDIFF`, `DATEPART`)
* Cohort analysis logic
* Funnel analysis using conditional aggregation

---

## Project Structure

```
food-delivery-sql-analysis/
│
├── data/
│   ├── fd_users.csv
│   ├── fd_sessions.csv
│   ├── fd_orders.csv
│
├── sql/
│   ├── funnel.sql
│   ├── engagement.sql
│   ├── revenue.sql
│   ├── retention.sql
│
├── insights/
│   └── business_insights.md
│
└── README.md
```

---

## Key Insights (Summary)

* Significant drop observed between **search → checkout stage**
* Users take ~**4 sessions and ~2 weeks** to convert
* Revenue shows **daily volatility**
* Strong base of **power users (~20%)**
* Delivery times are consistent but slightly high (~44 mins)
* Repeat order rate appears unusually high → requires data validation

Detailed insights available in: `insights/business_insights.md`

---

## Business Recommendations

* Improve search-to-checkout conversion via better recommendations
* Introduce targeted offers within first 3–4 sessions
* Optimize delivery time to improve conversion
* Focus on retaining high-value users
* Increase AOV via bundling and cross-selling

---

## Tools Used

* SQL Server
* Excel (for validation)
* GitHub

---

## Learning Outcomes

* Built end-to-end analytical thinking
* Implemented real-world SQL use cases
* Practiced business-driven data analysis
* Learned cohort and funnel analysis deeply

---

## Future Improvements

* Build Power BI dashboard
* Add predictive modeling (conversion likelihood)
* Incorporate A/B testing analysis

---


