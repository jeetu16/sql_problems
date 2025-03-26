-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create an employees_level Table
CREATE TABLE employees_level (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    designation VARCHAR(50),
    manager_id INT REFERENCES employees_level(id) ON DELETE SET NULL
);

-- Insert values into employees_level Table
INSERT INTO employees_level (name, designation, manager_id) 
VALUES
	('Alice', 'CEO', NULL),               
	('Bob', 'CTO', 1),                     
	('Charlie', 'CFO', 1),                 
	('David', 'Engineering Manager', 2),   
	('Eve', 'Finance Manager', 3),         
	('Frank', 'Software Engineer', 4),     
	('Grace', 'Software Engineer', 4),     
	('Hannah', 'Accountant', 5);


-- Question : Write a SQL query to display the entire employee reporting hierarchy 
--            using a recursive CTE, showing each employee's level in the hierarchy.

-- Solution :
WITH RECURSIVE employee_hierarchy AS (
	SELECT id, name, manager_id, 1 as level
    FROM employees_level
    WHERE manager_id IS NULL
    UNION ALL
    SELECT el.id, el.name, el.manager_id, eh.level + 1
    FROM employees_level el
    JOIN employee_hierarchy eh
		ON el.manager_id = eh.id
)
SELECT *
FROM employee_hierarchy;