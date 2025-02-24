-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create orders_transactions Table
CREATE TABLE orders_transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    sale_amount DECIMAL(10,2)
);



-- Insert values into orders_transactions table
INSERT INTO orders_transactions (transaction_id, customer_id, sale_amount) 
VALUES	
	(201, 101, 250),
	(202, 102, 750),
	(203, 101, 600),
	(204, 103, 400),
	(205, 102, 180),
	(206, 103, 900);
  
-- Quetion :
/*
	You are given an orders table containing information about customer orders.
    Write an SQL query to
    1. Find the total revenue
    2. The revenue from high-value orders (amount >= 500)
    3. The revenue from low-value orders (amount < 500)
    For each customer
*/

-- Solution 1:

SELECT
	customer_id,
    SUM(sale_amount) AS total_revenue,
    SUM(CASE WHEN sale_amount >= 500 THEN sale_amount ELSE 0 END) AS high_value_orders_revenue,
    SUM(CASE WHEN sale_amount < 500 THEN sale_amount ELSE 0 END) AS low_value_orders_revenue
FROM orders_transactions
GROUP BY customer_id;

-- Solution 2:

WITH cte AS (
	SELECT
		customer_id,
        CASE
			WHEN sale_amount >= 500 THEN 'high_value'
            ELSE 'low_value'
		END AS flag,
        sale_amount
	FROM orders_transactions
)
SELECT
	customer_id,
    SUM(sale_amount) AS total_revenue,
    SUM(CASE WHEN flag = 'high_value' THEN sale_amount ELSE 0 END) AS high_value_orders_revenue,
    SUM(CASE WHEN flag = 'low_value' THEN sale_amount ELSE 0 END) AS low_value_orders_revenue
FROM cte
GROUP BY customer_id;