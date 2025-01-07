-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Query to create table:
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

-- Insert Data
INSERT INTO orders (order_id, order_date) VALUES
(1, '2024-07-01'),
(2, '2024-07-02'),
(3, '2024-07-03'),
(5, '2024-07-05'),
(6, '2024-07-06'),
(7, '2024-07-07'),
(9, '2024-07-09'),
(10, '2024-07-10'),
(11, '2024-07-11'),
(13, '2024-07-13'),
(14, '2024-07-14'),
(15, '2024-07-15'),
(16, '2024-07-16'),
(18, '2024-07-18'),
(19, '2024-07-19'),
(20, '2024-07-20');


-- 1. Given a table orders with columns order_id (sequential integers), order_date, write a query to identify the missing order IDs.
-- Solution
WITH RECURSIVE sequence_number AS (
    -- Start with the minimum order_id in the table
    SELECT MIN(order_id) AS order_id
    FROM orders
    UNION ALL
    -- Incrementally add 1 to the order_id until reaching the maximum order_id
    SELECT order_id + 1
    FROM sequence_number
    WHERE order_id < (SELECT MAX(order_id) FROM orders)
)
SELECT s.order_id
FROM sequence_number s
LEFT JOIN orders o ON s.order_id = o.order_id
WHERE o.order_id IS NULL;

