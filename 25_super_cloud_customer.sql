-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Creating products table
DROP TABLE IF EXISTS microsoft_products;
CREATE TABLE microsoft_products (
    product_id INT PRIMARY KEY,
    product_category VARCHAR(100),
    product_name VARCHAR(100)
);

-- Creating customer_contracts table
DROP TABLE IF EXISTS customer_contracts;
CREATE TABLE customer_contracts (
    customer_id INT,
    product_id INT,
    amount INT,
    FOREIGN KEY (product_id)
        REFERENCES microsoft_products (product_id)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

-- Inserting records into microsoft_products table:
INSERT INTO microsoft_products
VALUES
	(1, "Analytics", "Azure Databricks"),
	(2, "Analytics", "Azure Stream Analytics"),
	(3, "Containers", "Azure Kubernetes Service"),
	(4, "Containers", "Azure Service Fabric"),
	(5, "Compute", "Virtual Machines"),
	(6, "Compute", "Azure Function");
    
-- Inserting records into customer_contracts table:
INSERT INTO customer_contracts
VALUES
	(1, 1, 1000),
	(2, 2, 2000),
	(3, 1, 1100),
	(4, 1, 1000),
	(7, 1, 1000),
	(7, 3, 4000),
	(6, 4, 2000),
	(1, 5, 1500),
	(2, 5, 2000),
	(4, 5, 2200),
	(7, 6, 5000),
	(1, 2, 2000);
    
-- Question : Write a query to identifying "Supercloud" customers. These are customers who have purchased 
-- -------- : at least one product from every product category available.

WITH cte AS (
	SELECT
		c.*,
		p.product_category
	FROM microsoft_products p
	JOIN customer_contracts c
	ON p.product_id = c.product_id
)
SELECT 
	customer_id
FROM cte
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = (
											SELECT COUNT(DISTINCT product_category)
                                            FROM microsoft_products
										  );

    
    