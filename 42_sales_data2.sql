-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create sales_data2 Table
CREATE TABLE IF NOT EXISTS sales_data2 (
	customer_id varchar(50),
    total_sales INT
);

-- Insert values into sales_data2 table
INSERT INTO sales_data2
VALUES
	('C1', 5000),
	('C2', 7000),
	('C3', 12000),
	('C4', 8000),
	('C5', 6000);
    

/*
-- Percentage Contribution & Ranking
-- You have a sales_data table that tracks total sales by per customer
-- Write an SQL query to :
	1. Calculate each customer's percentage calculation to total sales.
    2. Rank customer based on their total sales in descending order.
*/

-- Solution :
with cte AS (
	SELECT
		customer_id,
		total_sales,
		ROUND(((total_sales/(SELECT SUM(total_sales) FROM sales_data2)) * 100), 2) as percentage_contribution
	FROM sales_data2
)
SELECT 
	*,
    ROW_NUMBER() OVER (ORDER BY percentage_contribution DESC) as sales_rank
FROM cte;

    