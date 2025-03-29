-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create an emp_pivot Table
CREATE TABLE emp_pivot (
emp_id INT,
salary_component_type VARCHAR(20),
val INT
);

-- Insert values into emp_pivot Table
INSERT INTO emp_pivot
VALUES 
	(1,'salary',10000),
    (1,'bonus',5000),
    (1,'hike_percent',10), 
    (2,'salary',15000),
    (2,'bonus',7000),
    (2,'hike_percent',8), 
    (3,'salary',12000),
    (3,'bonus',6000),
    (3,'hike_percent',7);
  
  
-- Question : Write a SQL query to convert original data to pivot table

-- Solution 1 :
SELECT
	distinct emp_id,
    (SELECT val FROM emp_pivot e2 WHERE e2.emp_id = e1.emp_id AND e2.salary_component_type = 'salary') AS salary,
    (SELECT val FROM emp_pivot e2 WHERE e2.emp_id = e1.emp_id AND e2.salary_component_type = 'bonus') AS bonus,
    (SELECT val FROM emp_pivot e2 WHERE e2.emp_id = e1.emp_id AND e2.salary_component_type = 'hike_percent') AS hike_percent
FROM emp_pivot e1;

-- Solution 2 :
SELECT
	emp_id,
    MAX(CASE WHEN salary_component_type = 'salary' THEN val END) AS salary,
    MIN(CASE WHEN salary_component_type = 'bonus' THEN val END) AS bonus,
    MIN(CASE WHEN salary_component_type = 'hike_percent' THEN val END) AS hike_percent
FROM emp_pivot
GROUP BY emp_id;
