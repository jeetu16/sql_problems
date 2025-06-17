-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create Activity table
CREATE TABLE Activity (
    machine_id INT,
    process_id INT,
    activity_type VARCHAR(10),
    timestamp DECIMAL(10,3)
);

-- Inser values into Activity table
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start', 0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.430),
(1, 1, 'end', 1.420),
(2, 0, 'start', 4.100),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.500),
(2, 1, 'end', 5.000);

-- Question: Write a SQL query to find the average time each machine takes to complete a process.alter
-- Solution 1:
 WITH cte AS (
	 SELECT
		*,
		LAG(timestamp) OVER(PARTITION BY machine_id, process_id ORDER BY process_id) AS start_time
	FROM Activity
),
execution_time_cte AS (
	SELECT
		*,
		timestamp-start_time AS execution_time
	FROM cte
	WHERE timestamp-start_time IS NOT NULL
)
SELECT 
	machine_id,
    SUM(execution_time)/COUNT(process_id) AS avg_time
FROM execution_time_cte
GROUP BY machine_id;

-- Solution 2:
SELECT
	machine_id,
    AVG(end_time-start_time) AS avg_time
FROM (
	SELECT
		machine_id,
		process_id,
		MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
		MIN(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
	FROM Activity
	GROUP BY machine_id, process_id
) a
GROUP BY machine_id;



 