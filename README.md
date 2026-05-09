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

# 
