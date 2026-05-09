# 🛒E-Commerce-Orders-Analytics-Dashboard
A real-World end-to-end e-commerce analytics project designed to analyze customer purchasing behavior, order trends, payment performance, and delivery efficiency using the Brazilian Olist marketplace dataset.This project demonstrates a **complete data data analytics lifecyle** - from **data cleaning and preprocessing** to  **MySQL-based business analysis and interactive Excel dashboard development.**

# 📌Project Overview
* E-commerce businesses generate massive amounts of transational data every day. This project analyzes customers orders, Payments transactions, delivery performance, and purchasing trendas to uncover valuble business insights that help improve customer stisfaction and business performance.
* The project analyzed **100K e-commerce orders** and built a professional analytics solution using **Python, MySQL, and Excel dashboard**.

# 🎯Business Objectives
The primary objectives of this project include.
* Analyze customer purchasing behavior
* Monitor order and revenue tren
* Track delivery performance
* Identify top customers by revenue
* Analyze payment method preferences
* Understand installment payment behavior
* Evaluate customer retention and repeat purchases
* Identify delayed deliveried
* Generate actionable business insights

# 📋Dataset Features
* **Customer Data**
  * customer_id
  * customer_unique_id
  * customer_city
  * customer_state
  * customer_customer_zip_code_prefix

* **Order Data**
  * order_id
  * order_status
  * order_purchase_timestamp
  * order_approved_at
  * order_delivered_customer_date
  * order_estimated_delivery_date

* **Payment Data**
  * payment_type
  * payment_installments
  * payment_value
  * payment_sequetial

# 🧹Data Cleaning & Preprocessing
Data cleaning and preprocessing were performed using **Python (Pandas)
**✅Data Cleaning Steps**
  * load CSV datasets using Pandas
  * checked dataset structure using **.info()**
  * performed statistical analysis using **.describe()**
  * checked missing values using **.isna().sum()**
  * identified duplicate records
  * converted order date columns into datetime format
  * filled missing approved dates using purchase timestamps
  * filled missing carrier delivery dates using approved dates
  * filled missing customer delivery dates using esimated delivery dates
  * exported clened datasets into MySQL database using SQLalchemy and CSV file

# 🗄️MySQL Analysis
* **Core Business Metrics**
* total customers
* total orders
* total revenue
* average order value
* delivered orders count

* **Sales & Revenue Analysis**
 * monthly order trend
 * daily revenue trend
 * running cumulative revenue
 * orders above average value

* **Cusomer Analytics**
 * top paying customers
 * customer lifetime value
 * repeat vs one-time customers
 * customers spending ranking
 * top 10% customer segmentation

* **Orders & Delivery Analysis**
 * orders by status
 * delivery delay analysis
 * lastest customer order tracking
 * days between customer orders

* **Payment Analysis**
 * revenue by payment type
 * payment installment behavior
 * credit card usage analysis

* **📊Advanced SQL Concepts Used**
 * common table expressions (CTEs)
 * window functions
 * RANK()
 * ROW_NUMBER()
 * LAG()
 * aggreate functions
 * subqueries
 * CASE statements
 * JOIN operations

# 📈Excel Dashboard
The interactive Excel dashboard provides a complete overview of e-commerce business performance.
* **Dashbaord KPIs**
 * total orders
 * delivered orders
 * total payments value
 * average order value
 * unique customers

* **Dashboard Visualizations**
 * orders over time
 * orders by status
 * order by day of week
 * payment value trend
 * payment type analysis
 * payment installments analysis
 * top 10 customers by order value
 * key business insights

* **Interactive filters**
 * Year filter
 * state filter
 * order status filter
 * payment type filter

# 🧠Key Insights
* **Order Status**
 * over 97% orders were successfully delivered
 * monday recorded the highest number of orders
 * order volume significantly during 2017

* **Payment Insights**
 * credit card was the most preferred payment method
 * most customers preferred singel-installment payments
 * average order value was approximately $154

* **Customer Insights**
 * majority of customers palced only one order
 * a small percentage of customers contributed high revenue
 * repeat customer generated high lifetime value

# 📁Project Architecture
```
Olist-Ecommerce-Analytics
│
├── data/
│   ├── olist_customers_dataset.csv
│   ├── olist_orders_dataset.csv
│   └── olist_order_payments_dataset.csv
│
├── python/
│   └── data_cleaning.ipynb
│
├── sql/
│   └── ecommerce_analysis.sql
│
├── excel_dashboard/
│   └── ecommerce_dashboard.xlsx
│
├── images/
│   └── dashboard.png
│
└── README.md
```
# 📈Business Impact
This dashboard helps e-commerce businesses:
* monitor sales performance
* improve delivery operations
* understand customer behavior
* optimize payment strategies
* identify high-value customers
* improve retention strategies
* support data-driven decision-making

# ✅Conclusion
This E-commerce orders analytics project successfully analyzed customer orders,payments transaction and delivery performance to uncover actionable business insights.Using Python, MySQL and Excel Dashboarding the project delivered an interactive analytics solution that helps business monitor operational performace customer purchasing patterns, and revenue growth.

# 🛠️Tools & Technologies
* **Python (Pandas):** Data Cleaning & Preprocessing
* **MySQL:** Data Analysis & Querying
* **SQLAlchemy:** Database Connectivity
* **Jupyter Notebook:** Data Processing
* **Excel:** Dashboard & Data Visualization

# 📚References
* Olist Brazilian E-Commerce Dataset
* Python Pandas Documentation
* MySQL Documentation
* Excel Dashboard Documentation

# 👨‍💻Author
Diwakar K | Data Analyst (Fresher)

* **💡Skills:**
Python,
Pandas,
MySQL,
Excel Dashboarding,
Data Cleaning,
SQL Analytics
