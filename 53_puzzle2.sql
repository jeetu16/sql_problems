-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create an puzzle2 Table
CREATE TABLE puzzle2(
	teamID INT,
	memberID VARCHAR(10),
	condition1 VARCHAR(10),
	condition2 VARCHAR(10)
);

-- Insert values into puzzle2 Table
INSERT INTO puzzle2 
VALUES 
	(1,'m1','Y','Y'),
	(1,'m2','Y','Y'),
	(1,'m3','Y','Y'),
	(1,'m4','Y','N'),
	(2,'m1','Y','Y'),
	(2,'m2','Y','N'),
	(2,'m3','N','Y'),
	(2,'m4','N','N'),
	(2,'m5','N','Y'),
	(3,'m1','Y','Y'),
	(3,'m2','Y','N'),
	(3,'m3','N','Y'),
	(3,'m4','N','N'),
	(3,'m5','Y','Y');
    
-- Question : Write a SQL query to check if both condition1 and condition2 are 'Y'
--            and minimum of two members; if true then return 'Y' otherwise 'N'.

-- Solution :

WITH cte_flag AS (
	SELECT
		*,
		CASE
			WHEN condition1 = 'Y' AND condition2 = 'Y' THEN 1 ELSE 0
		END AS flag
	FROM puzzle2
),
cte_cnt AS (
	SELECT 
		*,
		SUM(flag) OVER(PARTITION BY teamID ORDER BY teamID) AS cnt
	FROM cte_flag
)
SELECT
	teamID,
    memberID,
    condition1,
    condition2,
    CASE
		WHEN condition1 = 'Y' and condition2 = 'Y' THEN 'Y' ELSE 'N'
	END AS result
FROM cte_cnt
WHERE cnt >=2;