-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

DROP TABLE IF EXISTS Product_Sales;
-- Create Product_Sales Table
CREATE TABLE IF NOT EXISTS Product_Sales (
    ProductID VARCHAR(10),
    StoreID VARCHAR(10),
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
    PRIMARY KEY (ProductID, StoreID, SaleDate)
);

-- Insert values into Product_Sales table
INSERT INTO Product_Sales (ProductID, StoreID, SaleDate, SaleAmount)
VALUES
    ('P001', 'S001', '2024-10-01', 500.00),
    ('P002', 'S002', '2024-10-05', 300.00),
    ('P001', 'S003', '2024-10-07', 700.00),
    ('P003', 'S001', '2024-10-08', 450.00),
    ('P001', 'S001', '2024-10-10', 600.00),
    ('P002', 'S002', '2024-10-15', 400.00),
    ('P003', 'S003', '2024-10-20', 500.00),
    ('P001', 'S002', '2024-10-12', 650.00),
	('P003', 'S003', '2024-10-21', 500.00);

/*
Question :

Write a SQL query to find the highest SaleAmount for each ProductID across all stores and the corresponding StoreID and SaleDate.
Use a correlated subquery to achieve this.
Conditions: If two or more rows have the same maximum SaleAmount for a ProductID, return the one with the earliest SaleDate.
*/

-- Solution 1 : according to question
SELECT 
	ProductID,
	StoreID,
	SaleDate,
	SaleAmount
FROM Product_Sales p1
WHERE SaleAmount = (
	SELECT MAX(SaleAmount)
    FROM Product_Sales p2
    WHERE p2.ProductID = p1.ProductID
)
AND SaleDate = (
	SELECT min(SaleDate)
    FROM Product_Sales p3
    WHERE p3.ProductID = p1.ProductID
    AND p3.SaleAmount = p1.SaleAmount
);


-- Solution 2:

WITH cte AS (
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY SaleAmount DESC, SaleDate ASC) AS rnk
	FROM Product_Sales
)
SELECT 
	ProductID,
    StoreID,
    SaleDate,
    SaleAmount
FROM cte
WHERE rnk = 1;



