-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;



-- Create the table
CREATE TABLE american_express_transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_amount DECIMAL(10, 2) NOT NULL
);

-- Insert the data into the table
INSERT INTO american_express_transactions (transaction_id, user_id, transaction_date, transaction_amount)
VALUES
    (1, 269, '2018-08-15', 500),
    (2, 478, '2018-11-25', 400),
    (3, 269, '2019-01-05', 1000),
    (4, 123, '2020-10-20', 600),
    (5, 478, '2021-07-05', 700),
    (6, 123, '2022-03-05', 900);


-- Question : Write a SQL query to calculate the average transaction amount per year for each client, where the years are in the range of 2018 to 2022.

-- Solution :
SELECT
	YEAR(transaction_date) AS year,
    user_id,
    AVG(transaction_amount)
FROM american_express_transactions
GROUP BY year, user_id;