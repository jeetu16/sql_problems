-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create company_info table
CREATE TABLE company_info(
	company_name VARCHAR(10),
	year_cal INT,
	revenue INT
);

-- Insert the data into the company_info table
INSERT INTO company_info 
VALUES
		('x',2020,100),
		('x',2021,90),
		('x',2022,120),
        ('y',2020,100),
		('y',2021,100),
		('z',2020,100),
		('z',2021,120),
		('z',2022,130);

-- Question : Write a SQL Query to find company name only whose revenue is increasing every year or remain same

WITH CTE AS (
	SELECT 
		*,
		COALESCE(LEAD(revenue) OVER (PARTITION BY company_name ORDER BY year_cal), revenue) AS nest_year_rev,
		(COALESCE(LEAD(revenue) OVER (PARTITION BY company_name ORDER BY year_cal), revenue) - revenue) AS revenue_diff
	FROM company_info
)
SELECT
	company_name,
    year_cal,
    revenue
FROM CTE
WHERE company_name NOT IN (
	SELECT company_name
    FROM CTE
    WHERE revenue_diff < 0
);
