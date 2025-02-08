-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Creating emp2 table
CREATE TABLE emp2(
	emp_id INT,
    emp_name VARCHAR(20),
    salary INT,
    manager_id INT,
    dept VARCHAR(20)
);

-- Inserting records into emp2 table:
INSERT INTO emp2 
VALUES 
		(1, 'Navin', 1300, 2, "Sales"),
		(2, 'Ankit', 1200, 3, "Sales"),
		(3, 'Kavya', 1250, 4, "Sales"),
		(4, 'Ranjit', 1600, 5, "Sales"),
		(5, 'John', 3000, 4, "Marketing"),
		(6, 'Yash', 1800, 3, "Marketing"),
		(7, 'Tom', 1500, 2, "Marketing");
        

-- Question : Write a SQL query to find lowest and highest salary emp in each dept.

-- Solution 1:
WITH cte AS (
	SELECT
		dept,
		MAX(salary) AS max_salary,
		MIN(salary) AS min_salary
	FROM emp2
	GROUP BY dept
)
SELECT
	cte.dept, 
    e1.emp_name AS highest_salary,
    e2.emp_name AS lowest_salary
FROM emp2 e1
JOIN cte
	ON e1.dept = cte.dept AND cte.max_salary = e1.salary
JOIN emp2 e2
	ON e2.dept = cte.dept AND cte.min_salary = e2.salary;
    
-- Solution 2:
WITH cte AS (
	SELECT
		dept,
        MIN(salary) AS min_salary,
        MAX(salary) AS max_salary
    FROM emp2
    GROUP BY dept
)
SELECT
	cte.dept,
    MIN(CASE WHEN e.salary = max_salary THEN emp_name END) AS highest_salary,
    MAX(CASE WHEN e.salary = min_salary THEN emp_name END) AS lowest_salary
FROM cte
RIGHT JOIN emp2 e
	ON cte.dept = e.dept
GROUP BY cte.dept;