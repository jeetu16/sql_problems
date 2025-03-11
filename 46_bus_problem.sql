-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create the bus Table
CREATE TABLE bus(
	personId INT, 
    personName VARCHAR(100),
    personWeight INT,
    turn INT
);

-- Insert values into bus table
INSERT INTO bus
VALUES
	(5,'john',120,2),
	(4,'tom',100,1),
	(3,'rahul',95,4),
	(6,'bhavna',100,5),
	(1,'ankita',79,6),
	(2,'Alex',80,3);
   
-- Question : Write a SQL Query to find the person_name of the last person that 
--            Can fit on the bus without exceeding the weight limit. Limit is 400.

-- Solution :

WITH cte AS (
	SELECT 
		*,
		SUM(personWeight) OVER(ORDER BY turn) AS cumWeight
	FROM bus
)
SELECT
	personName
FROM cte
WHERE cumWeight < 400
ORDER BY cumWeight DESC
LIMIT 1;