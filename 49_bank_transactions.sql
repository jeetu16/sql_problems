-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


DROP TABLE IF EXISTS Bank_Transactions;
-- Create the Bank_Transactions Table
CREATE TABLE Bank_Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    transaction_date DATETIME,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('Deposit', 'Withdrawal')),
    amount INT
);

-- Insert values into Bank_Transactions table
INSERT INTO Bank_Transactions (transaction_id, customer_id, transaction_date, transaction_type, amount)
VALUES 
    (1001, 'A1', '2099-01-01 10:00', 'Deposit', 500),
    (1002, 'A1', '2099-01-01 12:30', 'Withdrawal', 200),
    (1003, 'A2', '2099-01-01 09:45', 'Deposit', 300),
    (1004, 'A1', '2099-01-02 15:00', 'Deposit', 700),
    (1005, 'A3', '2099-01-03 11:20', 'Deposit', 400),
    (1006, 'A2', '2099-01-04 14:10', 'Withdrawal', 100),
    (1007, 'A1', '2099-01-05 10:00', 'Withdrawal', 500),
    (1008, 'A3', '2099-01-06 08:45', 'Withdrawal', 150);
    
    
/*
-- Question :
-You have a Bank_Transactions table that logs deposits and withdrawals by customers: 
-Write an SQL query to transform the data so that each customer_id has: 
	1. Cumulative balance after each transaction 
	2. A running balance column that updates based on transaction type 
		(Deposit increases balance, Withdrawal decreases balance) 
	3. An indicator column to specify if the account balance is below a threshold (<= 300)
*/

WITH cte AS(
	SELECT
		customer_id,
		transaction_date,
		transaction_type,
		amount,
		SUM(
			CASE
				WHEN transaction_type = 'Deposit' THEN +amount
				ELSE -amount
			END
		) OVER (PARTITION BY customer_id ORDER BY transaction_date) AS running_balance
	FROM Bank_Transactions
)
SELECT
	*,
	CASE
		WHEN running_balance <= 300 THEN 'Notify'
        ELSE ''
	END AS indicator
FROM cte;