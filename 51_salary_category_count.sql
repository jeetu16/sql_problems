-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create accounts Table
CREATE TABLE accounts(
	account_id INT, 
    income INT
);

-- Insert values into accounts Table
INSERT INTO accounts
VALUES
	(1,90000),
	(2,17000),
	(3,22000),
	(4,13000),
	(5,50000),
	(6,56000),
	(7,19000);
    
-- Question : Write a SQL query to find category based on income
--            less than 20000 is low salary, 20000 to 40000 avg salary, more than 40000 is high salary.

-- Solution :

WITH cte AS (
	SELECT
		*,
		CASE
			WHEN income < 20000 THEN 'Low Salary'
			WHEN income >= 20000 AND income <= 40000 THEN 'Avg Salary'
			WHEN income > 40000 THEN 'High Salary'
		END AS category
	FROM accounts
)
SELECT
	category,
    COUNT(*)
FROM cte
GROUP BY category;