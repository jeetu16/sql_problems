-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;



-- Create Status table
DROP TABLE IF EXISTS Status;
CREATE TABLE Status (
    status BIT                          
    -- Using BIT type for 0 and 1 values
);

-- Insert the data into the Status table
INSERT INTO Status (status) VALUES
(1),
(1),
(0),
(1),
(1),
(1),
(0),
(1),
(0),
(1),
(1),
(1),
(1),
(0),
(0),
(1);
-- (1);

-- Question : Write an SQL query to determine the longest consecutive sequence of 1s that appears before a 0 in the dataset. 
--            The sequence should be uninterrupted, and only the lengths of 1s ending immediately before a 0 should be considered.

-- Solution :

WITH cte_rn AS (
	SELECT
		*,
		ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rnk
	FROM Status
),
cte_group AS (
	SELECT 
		*,
		SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) OVER(ORDER BY rnk) AS group_data
	FROM cte_rn
)
SELECT
	SUM(status) as count
FROM cte_group
GROUP BY group_data
HAVING count > 0;