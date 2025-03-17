-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

DROP TABLE IF EXISTS customer_orders;
-- Create the customer_orders Table
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

-- Insert values into customer_orders table
INSERT INTO customer_orders (order_id, customer_id, order_date) VALUES
(1, 101, '2024-01-05'), -- First order for 101
(2, 101, '2024-03-15'),
(3, 101, '2024-05-20'),  -- Last order for 101
(4, 102, '2024-02-10'),  -- First order for 102
(5, 102, '2024-04-25'),
(6, 102, '2024-06-30'),  -- Last order for 102
(7, 103, '2024-01-01'),  -- First order for 103
(8, 103, '2024-02-18'),
(9, 103, '2024-03-25'),  
(10, 103, '2024-04-15');	-- Last order for 103


-- Quetion : Write a SQL query to retrieve the first and last order for each customer from the orders table

-- Solution 1:
WITH cte AS (
	SELECT 
		*,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS order_rank
	FROM customer_orders
)
SELECT
	customer_id,
    order_id,
    order_date
FROM cte c
WHERE order_rank = (SELECT MIN(c1.order_rank) FROM cte c1 WHERE c.customer_id = c1.customer_id) OR order_rank = (SELECT MAX(c2.order_rank) FROM cte c2 WHERE c.customer_id = c2.customer_id)
ORDER BY customer_id, order_id;

-- Solution 2:
WITH cte AS (
	SELECT 
		*,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS fo,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS lo
	FROM customer_orders
)
SELECT
	customer_id,
    order_id,
    order_date
FROM cte
WHERE fo = 1 OR lo = 1
ORDER BY customer_id, order_id;