-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create the projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    project_completion_date DATE
);

-- Insert records into projects table
INSERT INTO projects (project_id, employee_name, project_completion_date) VALUES
(100, 'Ankit',  '2022-12-15'),
(101, 'Shilpa', '2023-01-03'),
(102, 'Shilpa', '2023-01-15'),
(103, 'Shilpa', '2023-01-22'),
(104, 'Rahul',  '2023-01-05'),
(105, 'Rahul',  '2023-01-12'),
(106, 'Mukesh', '2023-01-23'),
(108, 'Mukesh', '2023-02-04'),
(109, 'Mukesh', '2023-02-16'),
(110, 'Shilpa', '2023-02-24'),
(112, 'Rahul',  '2023-02-25');


-- TCS wants to award employees based on number of projects completed by each individual each month.
-- Question : Write an SQL to find best employee for each month along with number of projects completed by him/her
-- 			  in that month, display the output in descending order of number of completed projects.

-- Solution:
WITH cte AS (
	SELECT
		employee_name,
		LEFT(project_completion_date, 7) AS month,
		COUNT(1) AS completed_projects
	FROM projects
	GROUP BY employee_name, LEFT(project_completion_date, 7)
)
SELECT 
	employee_name,
    month,
    completed_projects
FROM (
	SELECT
		*, DENSE_RANK() OVER(PARTITION BY month ORDER BY completed_projects DESC) rnk
	FROM cte
) AS b
WHERE rnk = 1
ORDER BY completed_projects DESC;