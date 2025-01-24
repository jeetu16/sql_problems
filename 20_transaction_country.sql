-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;


-- Creating Table :
CREATE TABLE transactions_counrty (
id INT PRIMARY KEY,
country VARCHAR(15),
state VARCHAR(15),
amount INT,
trans_date DATE
);

-- Inserting records into the table:
INSERT INTO transactions_counrty
VALUES 	
	(1,'US','approved',1000,'2023-12-18'),
	(2,'US','declined',2000,'2023-12-19'),
	(3,'US','approved',2000,'2024-01-01'),
	(4,'India','approved',2000,'2023-01-07');


-- Question : Write a sql query to find for each month and country, the number of transactions
-- -------- : and their total amount, the number of approved transactions and their total amount.

-- Solution 1 :
WITH total_transactions_cte AS (
	SELECT
		country,
		DATE_FORMAT(trans_date, "%Y-%m") as month,
		COUNT(*) totalTransactions,
		SUM(amount) as totalAmount
	FROM transactions_counrty
	GROUP BY country, month
),
total_approved_transaction AS (
	SELECT
		country,
		DATE_FORMAT(trans_date, "%Y-%m") AS month,
		COUNT(*) AS totalTransactionsApproved,
		SUM(amount) AS totalAmountApproved
	FROM transactions_counrty
	WHERE state = 'approved'
	GROUP BY country, month
)
SELECT 
	tt.month,
    tt.country,
    totalTransactions,
    totalAmount,
    totalTransactionsApproved,
    totalAmountApproved
FROM total_transactions_cte tt
JOIN total_approved_transaction at
ON tt.month = at.month;

-- Solution 2:

SELECT 
	date_format(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS totalTransactions,
    SUM(amount) AS totalAmount,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS totalApprovedTransactions,
    SUM(CASE WHEN state = 'approved' THEN amount END) AS totalAmountApproved
FROM transactions_counrty
GROUP BY month, country;