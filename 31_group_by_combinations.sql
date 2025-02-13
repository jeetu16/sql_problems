-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Creating cube_sales table
CREATE TABLE cube_sales(
	product VARCHAR(20), 
    region VARCHAR(20), 
	sales_amount INT
);

-- Inserting records into cube_sales table:
INSERT INTO cube_sales(product, region, sales_amount)
VALUES
	('A', 'North', 100),
    ('A', 'South', 150),
    ('B', 'North', 200),
    ('B', 'South', 250);
    
    
-- Question : Write a query to get the total sales for each product, region, and combinations of these?

-- Solution 1;
SELECT product, region, SUM(sales_amount) AS total_sales
FROM cube_sales GROUP BY product, region
UNION ALL
SELECT product, NULL AS region, SUM(sales_amount)
FROM cube_sales GROUP BY product
UNION ALL
SELECT NULL AS product, region, SUM(sales_amount)
FROM cube_sales GROUP BY region
UNION ALL
SELECT NULL, NULL, SUM(sales_amount)
FROM cube_sales;

-- Solution 2:
SELECT 
    IFNULL(product, 'null') AS product, 
    IFNULL(region, 'null') AS region, 
    SUM(sales_amount) AS total_sales
FROM 
    cube_sales
GROUP BY 
    product, region WITH ROLLUP;
