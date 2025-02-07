-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Creating sls_tbl table
CREATE TABLE sls_tbl (
	pid INT, 
    sls_dt DATE, 
    sls_amt INT 
);

-- Inserting records into sls_tbl table:
INSERT INTO sls_tbl (pid, sls_dt, sls_amt)
VALUES 
(201, '2024-07-11', 140), 
(201, '2024-07-18', 160), 
(201, '2024-07-25', 150), 
(201, '2024-08-01', 180), 
(201, '2024-08-15', 170), 
(201, '2024-08-29', 130);


-- Question : Find the missing weeks in a sales table

-- Solution 1:

WITH RECURSIVE date_cte AS (
	SELECT min(sls_dt) AS s_date
    FROM sls_tbl
    UNION ALL
    SELECT DATE_ADD(s_date, INTERVAL 1 WEEK)
    FROM date_cte
    WHERE s_date < (SELECT MAX(sls_dt) FROM sls_tbl)
)
SELECT s_date
FROM date_cte dc
LEFT JOIN sls_tbl st
	ON dc.s_date = st.sls_dt
WHERE sls_amt IS NULL;

-- Solution 2:
DROP PROCEDURE IF EXISTS findMissingWeeks;
DELIMITER $$
CREATE PROCEDURE findMissingWeeks()
BEGIN
	DECLARE start_date DATE;
    DECLARE end_date DATE;
    
    SELECT MIN(sls_dt), MAX(sls_dt) INTO start_date, end_date FROM sls_tbl;
    
    CREATE TEMPORARY TABLE missing_weeks(missing_date DATE);
    
    WHILE start_date <= end_date DO
		IF NOT EXISTS (SELECT 1 FROM sls_tbl WHERE sls_dt = start_date) THEN
			INSERT INTO missing_weeks(missing_date) VALUES(start_date);
		END IF;
			SET start_date = DATE_ADD(start_date, INTERVAL 1 WEEK);
    END WHILE;
    
    SELECT * FROM missing_weeks;
    DROP TEMPORARY TABLE missing_weeks;
END $$
DELIMITER ;

CALL FindMissingWeeks();