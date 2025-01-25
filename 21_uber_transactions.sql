-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;


-- Creating Table :
CREATE TABLE transactions_uber (
  user_id INT,
  spend DECIMAL(10,2),
  transaction_date DATETIME
);

-- Inserting records into the table:
INSERT INTO transactions_uber (user_id, spend, transaction_date)
VALUES
  (111, 100.50, '2022-01-08 12:00:00'),
  (111, 55, '2022-01-10 12:00:00'),
  (121, 36, '2022-01-18 12:00:00'),
  (145, 24.99, '2022-01-26 12:00:00'),
  (111, 89.60, '2022-02-05 12:00:00'); 
  
-- Question : Write a SQL query to obtain the third transaction of every user. 
-- ------     The output should include the user_id, spend, and transaction_date

-- Solution : 
SELECT 
	user_id,
  spend,
  transaction_date
FROM (
	SELECT
		*,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) as trans_num
	FROM transactions_uber
) AS x
WHERE x.trans_num = 3;