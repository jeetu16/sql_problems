-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;


-- Creating table
CREATE TABLE office( 
	emp_id INT, 
	emp_status VARCHAR(10),
	time_id DATETIME
);

-- Inserting records into the table
INSERT INTO office 
VALUES 	('1', 'in', '2023-12-22 09:00:00'), 
		('1', 'out', '2023-12-22 09:15:00'),
		('2', 'in', '2023-12-22 09:00:00'),
		('2', 'out', '2023-12-22 09:15:00'),
		('2', 'in', '2023-12-22 09:30:00'),
		('3', 'out', '2023-12-22 09:00:00'),
		('3', 'in', '2023-12-22 09:15:00'),
		('3', 'out', '2023-12-22 09:30:00'),
		('3', 'in', '2023-12-22 09:45:00'),
		('4', 'in', '2023-12-22 09:45:00'),
		('5', 'out', '2023-12-22 09:40:00');


-- Quetion : Write a query to find out which employee currently in office


-- Solution :
WITH officeCte AS (
	SELECT 
		*,
        ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY time_id DESC) as rankTiming
	FROM office
)
SELECT 
	emp_id,
    emp_status,
    time_id
FROM officeCte
WHERE rankTiming = 1 and emp_status = 'in';
