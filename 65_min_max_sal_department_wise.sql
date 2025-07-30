-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create the emps_tbl table
CREATE TABLE emps_tbl(
emp_name VARCHAR(50), 
dept_id INT, salary INT);

-- Insert records into emps_tbl table
INSERT INTO emps_tbl 
VALUES ('Siva', 1, 30000), ('Ravi', 2, 40000),
('Prasad', 1, 50000), ('Sai', 2, 20000), 
('Anna', 2, 10000);

-- Question : We need to Find department wise minimum salary emp_name and maximum salary emp_name.


-- Solution 1:
SELECT
	dept_id,
    MAX(CASE WHEN salary = (SELECT MIN(salary) FROM emps_tbl e2 WHERE e2.dept_id = e.dept_id) THEN emp_name END) AS min_sal_emp,
    MAX(CASE WHEN salary = (SELECT MAX(salary) FROM emps_tbl e2 WHERE e2.dept_id = e.dept_id) THEN emp_name END) AS max_sal_emp
FROM emps_tbl e
GROUP BY dept_id;

-- Solution 2:
WITH cte AS (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary) AS min_emp_rnk, 
		DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS max_emp_rnk
	FROM emps_tbl
)
SELECT
	dept_id,
    MAX(CASE WHEN min_emp_rnk = 1 THEN emp_name END) as min_salary_emp,
    MIN(CASE WHEN max_emp_rnk = 1 THEN emp_name END) as max_salary_emp
FROM cte
GROUP BY dept_id;

