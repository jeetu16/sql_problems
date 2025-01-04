-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Query to create table:
CREATE TABLE sales_data (
    month varchar(10),
    category varchar(20),
    amount numeric
);

-- Insert data
INSERT INTO sales_data (month, category, amount) VALUES
    ('January', 'Electronics', 1500),
    ('January', 'Clothing', 1200),
    ('February', 'Electronics', 1800),
    ('February', 'Clothing', 1300),
    ('March', 'Electronics', 1600),
    ('March', 'Clothing', 1100),
    ('April', 'Electronics', 1700),
    ('April', 'Clothing', 1400);
    
-- 1 Transform Rows Into Columns
use local_mysql;
select * from sales_data;
-- solution 1 (this solution will be slow when it handles large data set becase of the inner query)

SELECT
	distinct sd.month,
    (SELECT amount FROM sales_data sd2 WHERE sd2.month = sd.month AND category = 'Electronics') AS electronics,
    (SELECT amount FROM sales_data sd2 WHERE sd2.month = sd.month AND category = 'Clothing') AS clothing
FROM sales_data sd;


-- solution 2 (this query will be fast when it handles large data set)

SELECT 
	month,
    MAX(CASE WHEN category = 'Electronics' THEN amount ELSE 0 END) AS electronics,
    MAX(CASE WHEN category = 'Clothing' THEN amount ELSE 0 END) AS clothing
FROM sales_data
GROUP BY month;

-- solution 3
SET @sql = NULL;
SELECT
    GROUP_CONCAT(DISTINCT
        CONCAT(
            'MAX(CASE WHEN category = ''',
            category,
            ''' THEN amount ELSE 0 END) AS `',
            category,
            '`'
        )
    ) INTO @sql
FROM sales_data;

SET @sql = CONCAT('SELECT month, ', @sql, ' 
                   FROM sales_data 
                   GROUP BY month');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


