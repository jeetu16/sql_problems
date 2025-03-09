-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create puzzle Table
CREATE TABLE IF NOT EXISTS puzzle(
	id INT,
    rules VARCHAR(10),
    VALUE INT
);

-- Insert values into puzzle table
INSERT INTO puzzle 
VALUES 
	(1,'1+3',10),
	(2,'2*5',12),
	(3,'3-1',14),
	(4,'4/1',15),
	(5,'5+4',18);
  
-- Question : Solve puzzle problem.

-- Solution :

WITH cte AS (SELECT 
	*,
	REGEXP_SUBSTR(rules, '^[0-9]+') AS first_id,        
	REGEXP_SUBSTR(rules, '[+*/-]') AS operation,
	REGEXP_SUBSTR(rules, '[0-9]+$') AS second_id 
FROM puzzle)
SELECT
	a.*,
    b.VALUE AS fv,
    c.VALUE AS sv,
    ROUND(CASE
		WHEN a.operation = '+' THEN b.VALUE + c.VALUE
        WHEN a.operation = '-' THEN b.VALUE - c.VALUE
        WHEN a.operation = '*' THEN b.VALUE * c.VALUE
        WHEN a.operation = '/' THEN b.VALUE / c.VALUE
	END) AS result
FROM cte a
JOIN cte b ON a.first_id = b.id
JOIN cte c ON a.second_id = c.id
ORDER BY a.id;

