-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Query to create table:
CREATE TABLE employees_with_performance (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    performance_rating VARCHAR(10),
    salary DECIMAL(10, 2)
);

-- Insert Data
INSERT INTO employees_with_performance (employee_id, name, performance_rating, salary) VALUES
(1, 'Alice', 'Excellent', 8000.00),
(2, 'Bob', 'Good', 6000.00),
(3, 'Charlie', 'Average', 4000.00),
(4, 'David', 'Excellent', 7200.00),
(5, 'Eve', 'Good', 4800.00),
(6, 'Frank', 'Poor', 3000.00),
(7, 'Grace', 'Excellent', 6500.00),
(8, 'Hank', 'Good', 5500.00),
(9, 'Ivy', 'Average', 3800.00),
(10, 'Jack', 'Excellent', 9000.00);



-- 19. Given a table orders with columns order_id (sequential integers), order_date, write a query to identify the missing order IDs.
SELECT * FROM orders;
WITH RECURSIVE numbers AS (
	SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM numbers
    WHERE num < (SELECT MAX(order_id) FROM orders)
)
SELECT num
FROM numbers n
LEFT JOIN orders o
ON n.num = o.order_id
WHERE order_id IS NULL;

-- 1. Classify employees into different performance levels based on both performance rating and salary: 'Top Performer' for 'Excellent' rating and salary greater than 7000, 'Good Performer' for 'Good' rating and salary  greater than 5000, and 'Others' for all other combination

-- Solution 1
SELECT 
	employee_id,
    NAME,
    salary,
    'Top Performer' AS performance_level
FROM employees_with_performance
WHERE performance_rating = 'Excellent' AND salary > 7000
UNION
SELECT 
	employee_id,
    name,
    salary,
    'Good Performer' AS performance_level
FROM employees_with_performance
WHERE performance_rating = 'Good' AND salary > 5000
UNION
SELECT 
	employee_id,
    name,
    salary,
    'Others' AS performance_level
FROM employees_with_performance
WHERE salary < 5000;

-- Solution 2
SELECT	
	employee_id,
    name,
    salary,
    CASE
		WHEN performance_rating = 'Excellent' AND salary > 7000 THEN 'Top Performer'
        WHEN performance_rating = 'Good' AND salary > 5000 THEN 'Good Performer'
        ELSE 'Others'
	END AS performance_level
FROM employees_with_performance;
