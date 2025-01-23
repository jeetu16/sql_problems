-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Creating Table :
CREATE TABLE transactions (
    product_id INT,
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);

-- Inserting records into the table:
INSERT INTO transactions (product_id, user_id, spend, transaction_date)
VALUES
(3673, 123, 68.90, '2022-07-08 10:00:00'),
(9623, 123, 274.10, '2022-07-08 10:00:00'),
(1467, 115, 19.90, '2022-07-08 10:00:00'),
(2513, 159, 25.00, '2022-07-08 10:00:00'),
(1452, 159, 74.50, '2022-07-10 10:00:00'),
(1452, 123, 74.50, '2022-07-10 10:00:00'),
(9765, 123, 100.15, '2022-07-11 10:00:00'),
(6536, 115, 57.00, '2022-07-12 10:00:00'),
(7384, 159, 15.50, '2022-07-12 10:00:00'),
(1247, 159, 23.40, '2022-07-12 10:00:00');  

-- Question : Write a SQL query to retrieve Walmart users' most recent transaction date, user ID, and the total number of products they purchased. 

-- Solution 1 :
WITH transCTE AS (
	SELECT 
		*,
		DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS purchaseRank
	FROM transactions
)
SELECT 
	transaction_date,
    user_id,
    COUNT(user_id) as purchase_count
FROM transCTE
WHERE purchaseRank = 1
GROUP BY user_id, transaction_date;

-- Solution 2:
WITH transCTE AS (
	select 
		*,
        MAX(transaction_date) OVER(PARTITION BY user_id) AS recent_trasn
	FROM transactions
)
SELECT 
	user_id,
    recent_trasn, 
	COUNT(*) AS purchase_count 
FROM transCTE
WHERE transaction_date=recent_trasn
GROUP BY user_id,recent_trasn;

