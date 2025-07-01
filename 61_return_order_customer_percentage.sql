-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create orders3 table
CREATE TABLE orders3 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(50),
    sales INT
);

-- Insert values into orders3 table
INSERT INTO orders3 (order_id, order_date, customer_name, sales) VALUES
(1, '2023-01-01', 'Alexa', 100),
(2, '2023-01-02', 'Alexa', 200),
(3, '2023-01-03', 'Alexa', 300),
(4, '2023-01-03', 'Alexa', 400),
(5, '2023-01-01', 'Ramesh', 500),
(6, '2023-01-02', 'Ramesh', 600),
(7, '2023-01-03', 'Ramesh', 700),
(8, '2023-01-03', 'Neha', 800),
(9, '2023-01-03', 'Ankit', 800),
(10, '2023-01-04', 'Ankit', 900);


-- Create returns table
CREATE TABLE returns (
    order_id INT PRIMARY KEY,
    return_date DATE
);

-- Insert values into returns table
INSERT INTO returns (order_id, return_date) VALUES
(1, '2023-01-02'),
(2, '2023-01-04'),
(3, '2023-01-05'),
(7, '2023-01-06'),
(9, '2023-01-06');


-- An e-commerce company, has observed a notable surge in return orders recently.
-- They suspect that a specific group of customers may be responsible for a significant
-- portion of these returns. To address this issue, their initial goal is to identify
-- customers who have returned more than 50% of their orders. This way, they can proactively
-- reach out to these customers to gather feedback.

-- Question: Write an SQL to find list of customers along with their return percent, display the output in ascending order of customer name.
-- Solution:
WITH cte AS (
	SELECT
		customer_name,
		COUNT(o.order_id) AS total_orders,
		COUNT(r.order_id) AS return_orders,
		(COUNT(r.order_id)/COUNT(o.order_id)) * 100 AS return_percentage
	FROM orders3 o
	LEFT JOIN returns r ON o.order_id = r.order_id
	GROUP BY customer_name
)
SELECT
	customer_name,
	return_percentage
FROM cte
WHERE return_percentage > 50;