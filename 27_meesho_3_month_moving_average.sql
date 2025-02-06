-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;



-- Creating meesho_customers table
CREATE TABLE meesho_customers (
    Customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Join_Date DATE
);

-- Creating meesho_orders table
CREATE TABLE meesho_orders (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_Date DATE,
    Amount DECIMAL(10, 2)
);

-- Inserting records into meesho_customers table:
INSERT INTO meesho_customers (Customer_id, Name, Join_Date) 
VALUES
(1, 'John', '2023-01-10'),
(2, 'Simmy', '2023-02-15'),
(3, 'Iris', '2023-03-20');

-- Inserting records into meesho_orders table:
INSERT INTO meesho_orders (Order_id, Customer_id, Order_Date, Amount) 
VALUES
(1, 1, '2023-01-05', 100.00),
(2, 2, '2023-02-14', 150.00),
(3, 1, '2023-02-28', 200.00),
(4, 3, '2023-03-22', 300.00),
(5, 2, '2023-04-10', 250.00),
(6, 1, '2023-05-15', 400.00),
(7, 3, '2023-06-10', 350.00);

-- Question : You are given two tables: Customers and Orders. Your task is to calculate the 3-month moving 
--            average of sales revenue for each month, using the sales data in the Orders table.

WITH monthlySales AS (
	SELECT
		DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(Amount) as monthly_sales
    FROM meesho_orders
    GROUP BY month
)
SELECT 
	month,
    monthly_sales,
    ROUND(AVG(monthly_sales) OVER(ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_sales
FROM monthlySales;

SELECT *
FROM meesho_orders;