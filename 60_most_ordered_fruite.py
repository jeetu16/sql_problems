-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create orders2 table
CREATE TABLE orders2 (
    order_date DATE,
    item VARCHAR(255)
);

-- Insert values into orders2 table
INSERT INTO orders2 (order_date, item) VALUES
('2024-03-01', 'Apple'),
('2024-03-01', 'Banana'),
('2024-03-01', 'Apple'),
('2024-03-02', 'Orange'),
('2024-03-02', 'Orange'),
('2024-03-02', 'Mango'),
('2024-03-03', 'Banana'),
('2024-03-03', 'Banana'),
('2024-03-03', 'Mango'),
('2024-03-03', 'Mango');

-- Question : Write a SQL to find the most ordered Item Per Day.
-- Solution:
WITH CTE AS (
	SELECT
		order_date,
		item,
		COUNT(1) AS count,
		DENSE_RANK() OVER(PARTITION BY order_date ORDER BY COUNT(1) DESC) AS rnk
	FROM orders2
	GROUP BY order_date, item
)
SELECT
	order_date,
    item,
    count
FROM CTE
WHERE rnk = 1;

