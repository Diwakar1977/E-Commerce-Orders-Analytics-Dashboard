-- Create database
CREATE DATABASE olist_commerce_analytics_db;

-- Use database
USE olist_commerce_analytics_db;

-- Total customers
SELECT COUNT(DISTINCT customer_id) AS total_customers 
FROM olist_customers_data;

-- Total orders 
SELECT COUNT(*) AS total_orders
FROM olist_orders_data;

-- Total revenue
SELECT ROUND(SUM(payment_value),2) AS total_revenue 
FROM olist_payments_data;

-- Orders by status
SELECT order_status,
	COUNT(*) AS order_status_count
FROM olist_orders_data
GROUP BY order_status
ORDER BY COUNT(*) DESC;


-- Monthly order trend
SELECT 
	DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS `month`,
    COUNT(*) AS total_orders
FROM olist_orders_data
GROUP BY `month` 
ORDER BY `month` ASC;

-- Revenue by payment type
SELECT 
	payment_type,
    ROUND(SUM(payment_value),2) AS revenue
FROM olist_payments_data
GROUP BY payment_type
ORDER BY revenue DESC;

-- Top 10 cities by orders
SELECT 
	c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM olist_customers_data c 
JOIN olist_orders_data o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- Average order value
SELECT 
	ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id),2) avg_value
FROM olist_payments_data p
JOIN olist_orders_data o
ON p.order_id = o.order_id;

-- Customer lifetime values
SELECT 
	c.customer_unique_id,
    ROUND(SUM(p.payment_value),2) total_spent
FROM olist_customers_data c
JOIN olist_orders_data o ON c.customer_id = o.customer_id 
JOIN olist_payments_data p ON o.order_id = p.order_id 
GROUP BY c.customer_unique_id 
ORDER BY total_spent DESC;

-- Repeat vs One-time customers
SELECT 
	CASE
		WHEN order_count = 1 THEN 'One Time'
        ELSE 'Repeat'
        END customer_type,
        COUNT(*) total_customers
FROM (
	SELECT 
		c.customer_unique_id,
		COUNT(o.order_id) AS order_count
	FROM olist_customers_data c
    JOIN olist_orders_data O 
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) T
GROUP BY customer_type;

-- Delivery delay analysis
SELECT 
	AVG(DATEDIFF(order_delivered_customer_date,order_estimated_delivery_date)) AS delay_days
FROM olist_orders_data
WHERE order_status = 'delivered';

-- Top paying customers
SELECT 
	c.customer_unique_id,
    COUNT(o.order_id) AS total_count,
    ROUND(SUM(p.payment_value),2) total_spent
FROM olist_customers_data c
JOIN olist_orders_data o ON c.customer_id = o.customer_id 
JOIN olist_payments_data p ON o.order_id = p.order_id
GROUP BY c.customer_unique_id 
ORDER BY total_spent DESC
LIMIT 10;


-- Payment installments behavior
SELECT 
	payment_installments,
    COUNT(*) total_count,
    ROUND(SUM(payment_value),2) total_spent
FROM olist_payments_data
GROUP BY payment_installments
ORDER BY payment_installments;

-- Daily revenue trend
SELECT 
	DATE(o.order_purchase_timestamp) order_date,
    COUNT(o.order_id) total_count,
    ROUND(SUM(p.payment_value),2) total_spent
FROM olist_orders_data o
JOIN olist_payments_data p
ON o.order_id = p.order_id
GROUP BY order_date
ORDER BY order_date;

-- Rank customers by spending
SELECT 
	c.customer_unique_id,
    SUM(p.payment_value) total_spent,
    RANK() OVER (ORDER BY SUM(p.payment_value) DESC) AS rank_postion
FROM olist_customers_data c
JOIN olist_orders_data o ON c.customer_id = o.customer_id 
JOIN olist_payments_data p ON o.order_id = p.order_id
GROUP BY c.customer_unique_id;

-- Running revenue (cumulative sales)
SELECT 
	DATE(o.order_purchase_timestamp) AS order_date,
    ROUND(SUM(p.payment_value),2) AS daily_revenue,
    ROUND(SUM(SUM(p.payment_value)) OVER (ORDER BY DATE(o.order_purchase_timestamp) ASC),2) AS cumulative_revenue
FROM olist_orders_data o
JOIN olist_payments_data p 
ON o.order_id = p.order_id
GROUP BY order_date;

-- Row number (latest order per customer)
SELECT *
FROM  (
	SELECT 
		c.customer_unique_id,
		o.order_id,
		o.order_purchase_timestamp,
		ROW_NUMBER() OVER(
			PARTITION BY c.customer_unique_id 
            ORDER BY DATE(o.order_purchase_timestamp) DESC
		) AS rn 
	FROM olist_customers_data c
	JOIN olist_orders_data o ON c.customer_id = o.customer_id
) t
WHERE rn = 2;

-- LAG function (previous order gap)
SELECT *
FROM (
	SELECT 
		customer_unique_id,
		order_purchase_timestamp,
		LAG(order_purchase_timestamp) OVER (
			PARTITION BY customer_unique_id 
			ORDER BY order_purchase_timestamp
		) AS previous_order_date,
		DATEDIFF(
			order_purchase_timestamp,
			LAG(order_purchase_timestamp) OVER (
				PARTITION BY customer_unique_id
				ORDER BY order_purchase_timestamp
			)
		) AS days_between_orders
	FROM (
		SELECT 
			c.customer_unique_id,
			o.order_purchase_timestamp
		FROM olist_customers_data c
		JOIN olist_orders_data o ON c.customer_id = o.customer_id
	) t
) final
WHERE previous_order_date IS NOT NULL;

-- Clean revenue table using CTE
WITH revenue_data AS (
	SELECT 
		o.order_id,
		c.customer_unique_id,
        DATE(o.order_purchase_timestamp) AS order_date,
		p.payment_value
	FROM olist_orders_data o 
	JOIN olist_customers_data c ON o.customer_id = c.customer_id 
	JOIN olist_payments_data p ON o.order_id = p.order_id
) 
SELECT 
	customer_unique_id,
    ROUND(SUM(payment_value),2) AS total_spent
FROM revenue_data
GROUP BY customer_unique_id;

-- Top 10% customers (CTE  + WINDOWS)
WITH customer_spend AS (
	SELECT
		c.customer_unique_id,
		ROUND(SUM(p.payment_value),2) AS total_spent
	FROM olist_customers_data c
	JOIN olist_orders_data o ON c.customer_id = o.customer_id
	JOIN olist_payments_data p ON o.order_id = p.order_id 
	GROUP BY c.customer_unique_id
),
ranked AS (
	SELECT *,
		NTILE(10) OVER (ORDER BY total_spent DESC) AS bucket
	FROM customer_spend
)
SELECT * 
FROM ranked
WHERE bucket = 1;

-- Customer above avg spend
SELECT * 
FROM (
	SELECT 
		c.customer_unique_id,
		ROUND(SUM(p.payment_value),2) AS total_spent
	FROM olist_customers_data c
	JOIN olist_orders_data o ON c.customer_id = o.customer_id
	JOIN olist_payments_data p ON o.order_id = p.order_id
	GROUP BY c.customer_unique_id 
) t
WHERE total_spent > (
	SELECT AVG(total_spent)
    FROM (
		SELECT 
			SUM(payment_value) AS total_spent
		FROM olist_payments_data
        GROUP BY order_id
	) x
);

-- Orders with above average
SELECT 
	o.order_id,
    ROUND(SUM(p.payment_value),2) order_value
FROM olist_orders_data o
JOIN olist_payments_data p 
ON o.order_id = p.order_id
GROUP BY o.order_id
HAVING order_value > (
	SELECT 
		AVG(payment_value) 
    FROM olist_payments_data 
);

-- Customer cohort (Monthly retention)
WITH first_purchase AS (
    SELECT 
		c.customer_unique_id,
		MIN(DATE(o.order_purchase_timestamp)) AS first_date
	FROM olist_customers_data c
	JOIN olist_orders_data o 
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_unique_id
),
cohort_data AS (
	SELECT 
		c.customer_unique_id,
        DATE_FORMAT(f.first_date,'%Y-%m') AS cohort_month,
        DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month
	FROM olist_customers_data c
    JOIN olist_orders_data o ON c.customer_id = o.customer_id
    JOIN first_purchase f ON c.customer_unique_id = f.customer_unique_id
)
SELECT 
	cohort_month,
    order_month,
    COUNT(DISTINCT customer_unique_id) 
FROM cohort_data 
GROUP BY cohort_month,order_month
ORDER BY cohort_month,order_month;

-- Cohort retention rate 
WITH cohort AS (
	SELECT 
		c.customer_unique_id,
		MIN(DATE(o.order_purchase_timestamp)) AS first_date
	FROM olist_customers_data c
	JOIN olist_orders_data o ON c.customer_id = o.customer_id
	GROUP BY c.customer_unique_id
),
cohort_size AS (
	SELECT 
		DATE_FORMAT(first_date,'%Y-%m') AS cohort_month,
        COUNT(*) AS total_customers
	FROM cohort
    GROUP BY cohort_month
),
activity AS (
	SELECT 
		c.customer_unique_id,
        DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month,
        DATE_FORMAT(co.first_date,'%Y-%m') AS cohort_month
	FROM olist_customers_data c
    JOIN olist_orders_data o ON c.customer_id = o.customer_id 
    JOIN cohort co ON c.customer_unique_id = co.customer_unique_id 
) 
SELECT 
	a.cohort_month,
    a.order_month,
    ROUND(COUNT(DISTINCT a.customer_unique_id) * 100 / cs.total_customers,2) AS retention_rate
FROM activity a
JOIN cohort_size cs ON a.cohort_month = cs.cohort_month
GROUP BY a.cohort_month,a.order_month,cs.total_customers
ORDER BY a.cohort_month,a.order_month;


