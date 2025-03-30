-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create an events Table
CREATE TABLE events(
	hall_id INT,
    from_date DATE,
    to_date DATE
);

-- Insert values into events Table
INSERT INTO events 
VALUES
	(1,'2025-01-05','2025-01-09'),
	(1,'2025-01-06','2025-01-10'),
	(1,'2025-01-07','2025-01-10'),
	(1,'2025-01-11','2025-01-15'),
	(2,'2025-02-15','2025-02-19'),
	(2,'2025-02-16','2025-02-20'),
	(2,'2025-02-21','2025-02-25');
    

-- Question : Write a SQL query to merge the overlapping events into a single event.

-- Solution :

WITH sorted_events AS (
    SELECT 
		*,
		LAG(to_date) OVER (PARTITION BY hall_id ORDER BY from_date) AS prev_to_date
    FROM events
),
grouped_events AS (
	SELECT 
		*,
		SUM(CASE WHEN from_date <= prev_to_date THEN 0 ELSE 1 END) 
		OVER (PARTITION BY hall_id ORDER BY from_date) AS grp
    FROM sorted_events
)
SELECT hall_id, 
   MIN(from_date) AS merged_from_date, 
   MAX(to_date) AS merged_to_date,
   COUNT(*) AS total_overlapping_events
FROM grouped_events
GROUP BY hall_id, grp
ORDER BY hall_id, merged_from_date;