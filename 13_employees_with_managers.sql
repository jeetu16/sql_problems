-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

CREATE TABLE employees_with_manager (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    managerId INT
);

INSERT INTO employees_with_manager (id, name, department, managerId) VALUES 
(1, 'John', 'HR', NULL),
(2, 'Bob', 'HR', 1),
(3, 'Olivia', 'HR', 1),
(4, 'Emma', 'Finance', NULL),
(5, 'Sophia', 'HR', 1),
(6, 'Mason', 'Finance', 4),
(7, 'Ethan', 'HR', 1),
(8, 'Ava', 'HR', 1),
(9, 'Lucas', 'HR', 1),
(10, 'Isabella', 'Finance', 4),
(11, 'Harper', 'Finance', 4),
(12, 'Hemla', 'HR', 3),
(13, 'Aisha', 'HR', 2),
(14, 'Himani', 'HR', 2),
(15, 'Lily', 'HR', 2);


-- 1. Write a SQL query to find manager name who manage more than 4 employee
-- Solution 1
WITH cte AS (
	SELECT
		managerId,
        count(managerId) AS numberOfEmployees
	FROM employees_with_manager
    GROUP BY managerId
)
SELECT name, cte.numberOfEmployees FROM cte
JOIN employees_with_manager ewm
ON ewm.id = cte.managerId
WHERE numberOfEmployees > 4;

-- Solution 2
SELECT
	e1.name,
    count(e2.managerId) AS numberOfEmployees
FROM employees_with_manager e1
JOIN employees_with_manager e2
ON e1.id = e2.managerId
GROUP BY e2.managerId
HAVING numberOfEmployees > 4;



-- 2. Write a SQL query to find manager name of Each Employee

-- Solution 1:
SELECT e1.id, e1.name, e1.department, e2.name AS managerName
FROM employees_with_manager e1
JOIN employees_with_manager e2
ON e1.managerId = e2.id
UNION
SELECT 
	id,
    name,
    department,
    NULL
FROM employees_with_manager
WHERE managerId IS NULL
ORDER BY id;

-- Solution 2:
SELECT e1.id, e1.name, e1.department, e2.name AS managerName
FROM employees_with_manager e1
LEFT JOIN employees_with_manager e2
ON e1.managerId = e2.id;

