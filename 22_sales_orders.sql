-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;


-- Creating Sales Order Table:
CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY,
    sale_date DATE,
    order_cost DECIMAL(10, 2),
    customer_id INT,
    seller_id INT
);

-- Creating sellers Table:
CREATE TABLE sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100)
);

-- Inserting records into the sales order table:
INSERT INTO sales_orders (order_id, sale_date, order_cost, customer_id, seller_id) VALUES
(1, '2020-03-01', 1500.00, 101, 1),
(2, '2020-05-25', 2400.00, 102, 2),
(3, '2019-05-25', 800.00, 101, 3),
(4, '2020-09-13', 1000.00, 103, 2),
(5, '2019-02-11', 700.00, 101, 2);

-- Inserting records into the sellers table:
INSERT INTO sellers (seller_id, seller_name) VALUES
(1, 'Daniel'),
(2, 'Ben'),
(3, 'Frank');

-- Question : Write a query to report the names of all the seller who did not make any sales in 2020. 
-- -------  : Return the result table ordered by seller name in ascending order.

-- Solution 1: 
SELECT seller_name
FROM sellers
WHERE seller_id NOT IN (
	SELECT DISTINCT seller_id
    FROM sales_orders
    WHERE EXTRACT(YEAR FROM sale_date) = 2020
);


-- Solution 2(Using RIGHT JOIN):
SELECT
	s.seller_name
FROM (
	SELECT *
    FROM sales_orders
    WHERE EXTRACT(year from sale_date) = 2020
) as so
RIGHT JOIN sellers s
ON so.seller_id = s.seller_id
WHERE so.order_id IS NULL;

-- Solution 3(Using LEFT JOIN):
SELECT seller_name
FROM sellers s
LEFT JOIN (
	SELECT DISTINCT seller_id
    FROM sales_orders
    WHERE YEAR(sale_date) = 2020
)  so
	ON s.seller_id = so.seller_id
WHERE so.seller_id IS NULL;