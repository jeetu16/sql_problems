-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create customers_transaction Table
CREATE TABLE customers_transaction (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2)
);

-- Insert values into customers_transaction table
INSERT INTO customers_transaction(transaction_id, customer_id, transaction_date, amount) 
VALUES 
	(501, 1, '2099-01-10', 500),
	(502, 2, '2099-01-15', 1200),
	(503, 1, '2099-01-20', 700),
	(504, 3, '2099-02-05', 1300),
	(505, 2, '2099-02-15', 800),
	(506, 3, '2099-02-25', 900),
	(507, 4, '2099-03-10', 650),
	(508, 2, '2099-03-20', 1400),
	(509, 4, '2099-04-05', 1100),
	(510, 3, '2099-04-15', 750);
    

-- Question : Write an SQL query to find the top spending customer for each month along with their total money spending.
--            If multiple customers have the highest spending in a month, return all of them.

-- Solution :
WITH total_monthly_spending_by_customers AS (
	SELECT
		customer_id,
		month(transaction_date) AS month,
		SUM(amount) AS monthly_spending
	FROM customers_transaction
	GROUP BY customer_id, month
), spending_rankings AS (
	SELECT
		*,
        DENSE_RANK() OVER(PARTITION BY month ORDER BY monthly_spending) AS rnk
	FROM total_monthly_spending_by_customers
)
SELECT
	customer_id,
    month,
    monthly_spending
FROM spending_rankings
WHERE rnk = 1;