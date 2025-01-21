-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Creating Table :
CREATE TABLE office_hiring(
 emp_id INT,
 experience VARCHAR(20) ,
 salary INT
);

-- Inserting records into the table:
INSERT INTO office_hiring  
VALUES 
	(1, 'Junior', 10000),
	(2, 'Junior', 15000),
	(3, 'Junior', 40000),
	(4, 'Senior', 16000),
	(5, 'Senior', 20000),
	(6, 'Senior', 50000);
    
-- Quetion : Write a SQL query to hire maximum then junior if we have budget where total budget should be <= 60000 ?

-- Solution :

WITH cum_senior_salary_table AS (
	SELECT 
		*,
        SUM(salary) OVER (ORDER BY salary) AS cum_senior_salary
	FROM office_hiring
    WHERE experience = 'Senior'
), cum_junior_salary_table AS (
	SELECT 
		*,
        SUM(salary) OVER (ORDER BY salary) AS cum_junior_salary
	FROM office_hiring
    WHERE experience = 'Junior'
)
SELECT *
FROM cum_senior_salary_table
where cum_senior_salary <= 60000
UNION
SELECT *
FROM cum_junior_salary_table
WHERE cum_junior_salary <= 60000 - (
		SELECT 
			MAX(cum_senior_salary)
		FROM cum_senior_salary_table
		WHERE cum_senior_salary <= 60000
)
ORDER BY emp_id;