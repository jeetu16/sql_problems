-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create the user_visits table
CREATE TABLE user_visits (
 user_id INT,
 visit_date DATE
);

-- Insert records into user_visits table
INSERT INTO user_visits (user_id, visit_date) VALUES
(1, '2020-11-28'),(1, '2020-10-20'),(1, '2020-12-03'),(2, '2020-10-05'),
(2, '2020-12-09'),(3, '2020-11-11');

-- Assume today's date is '2021-1-1'
-- Write an SQL query that will, for each user_id, find out the largest window of days between each visit and the one right after it
-- (or today if you are considering the last visit).

-- Solution:
WITH cte AS (
	SELECT
		*,
		datediff(LEAD(visit_date,1, DATE '2021-01-01') OVER(PARTITION BY user_id ORDER BY visit_date), visit_date) AS duration_next_visit
	FROM user_visits
)
SELECT 
	user_id,
    MAX(duration_next_visit) AS max_gap_days
FROM cte
GROUP BY user_id;
