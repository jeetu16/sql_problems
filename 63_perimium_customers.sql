-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create the orders4 table
CREATE TABLE orders4 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    sales INT
);

-- Insert records into orders4 table
INSERT INTO orders4 (order_id, order_date, customer_name, sales) VALUES
(1, '2023-01-01', 'Alexa', 2000),
(2, '2023-01-02', 'Alexa', 300),
(3, '2023-01-03', 'Alexa', 1100),
(4, '2023-01-03', 'Alexa', 1350),
(5, '2023-01-01', 'Ramesh', 3500),
(6, '2023-01-02', 'Ramesh', 1600),
(7, '2023-01-03', 'Ramesh', 1100),
(8, '2023-01-03', 'Neha', 1200),
(9, '2023-01-03', 'Subhash', 1000),
(10, '2023-01-03', 'Subhash', 1050);



-- Question :
-- An e-commerce company want to start special reward program for their premium customers. 
-- The customers who have placed a greater number of orders than the average number of orders 
-- placed by customers are considered as premium customers.

-- Write an SQL to find the list of premium customers along with the number of orders placed 
-- by each of them, display the results in highest to lowest no of orders.

-- Solution 1:
SELECT
	customer_name,
    count(1) AS total_orders
FROM orders4
GROUP BY customer_name
HAVING count(1) > (
	SELECT COUNT(order_id)/COUNT( DISTINCT customer_name)
    FROM orders4
);

-- Solution 2:
WITH cte AS (
	SELECT
		customer_name,
		COUNT(1) AS number_of_orders
	FROM orders4
	GROUP BY customer_name
)
SELECT *
FROM cte
WHERE number_of_orders > (SELECT AVG(number_of_orders) FROM cte)
ORDER BY number_of_orders DESC;