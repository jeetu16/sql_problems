-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create an Flights Table
CREATE TABLE Flights (
	cust_id INT, 
    flight_id VARCHAR(10), 
    origin VARCHAR(50), 
    destination VARCHAR(50)
);

-- Insert values into Flights Table
INSERT INTO Flights (cust_id, flight_id, origin, destination)
VALUES 
	(1, 'SG1234', 'Delhi', 'Hyderabad'), 
    (1, 'SG3476', 'Kochi', 'Mangalore'), 
    (1, '69876', 'Hyderabad', 'Kochi'), 
    (2, '68749', 'Mumbai', 'Varanasi'), 
    (2, 'SG5723', 'Varanasi', 'Delhi');
    
-- Question : Write a SQL query to find origin and final destination details.

-- Solution :
WITH first_flight AS (
	SELECT
		f1.cust_id,
		f1.origin
	FROM Flights f1
	LEFT JOIN Flights f2 ON f1.origin = f2.destination AND f1.cust_id = f2.cust_id
	WHERE f2.destination IS NULL
),
last_flight AS (
	SELECT
		f1.cust_id,
		f1.destination 
	FROM Flights f1
	LEFT JOIN Flights f2 ON f1.destination = f2.origin AND f1.cust_id = f2.cust_id
	WHERE f2.origin IS NULL
)
SELECT
	ff.cust_id,
    origin,
    destination
FROM first_flight ff
JOIN last_flight lf ON ff.cust_id = lf.cust_id;



