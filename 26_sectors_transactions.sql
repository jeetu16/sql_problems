-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;


-- Creating sector_transactions table
CREATE TABLE sector_transactions (
    transaction_id INT PRIMARY KEY,
    company_id INT,
    transaction_date DATE,
    revenue DECIMAL(10, 2)
);

-- Creating sectors table
CREATE TABLE sectors (
    company_id INT PRIMARY KEY,
    sector VARCHAR(50)
);


-- Inserting records into sector_transactions table:
INSERT INTO sector_transactions (transaction_id, company_id, transaction_date, revenue) 
VALUES
	(101, 1, '2020-01-15', 5000.00),
	(102, 2, '2020-01-20', 8500.00),
	(103, 1, '2020-02-10', 4500.00),
	(104, 3, '2020-02-20', 9900.00),
	(105, 2, '2020-02-25', 7500.00);

-- Inserting records into sectors table:
INSERT INTO sectors (company_id, sector) 
VALUES
	(1, 'Technology'),
	(2, 'Healthcare'),
	(3, 'Technology');
    
    
-- Questions : Write a sql query to calculate the average monthly revenue from each sector using financial transaction data.

-- Solution 1:
SELECT
	MONTH(st.transaction_date) AS month,
    s.sector,
	AVG(st.revenue) AS avg_renvenue
FROM sectors s
LEFT JOIN sector_transactions st
ON s.company_id = st.company_id
WHERE YEAR(transaction_date) = 2020
GROUP BY month, s.sector;

-- Solution 2:

WITH cte AS (
	SELECT
		company_id,
        MONTH(transaction_date) AS month,
		AVG(revenue) OVER(PARTITION BY company_id, MONTH(transaction_date)) AS month_revenue
    FROM sector_transactions
    WHERE YEAR(transaction_date) = 2020
)
SELECT
	month,
    s.sector,
    AVG(month_revenue)
FROM cte
RIGHT JOIN sectors s
	ON cte.company_id = s.company_id
GROUP BY month, s.sector
ORDER BY month, s.sector;