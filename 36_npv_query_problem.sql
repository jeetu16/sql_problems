-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create npv Table
CREATE TABLE npv (
    id INT,
    year INT,
    npv DECIMAL(10, 2)
);

-- Create queries Table
CREATE TABLE queries (
    id INT,
    year INT
);

-- Insert values into npv table
INSERT INTO npv (id, year, npv)
VALUES 
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0); 


-- Insert values into queries table
INSERT INTO queries (id, year) VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);


-- Question : Find the npv of each query from the queries table. Return the output order by id and year in ascending order.
-- Note     : If no NPV is available for a particular combination in the npv table, assign a 0 value of instance. 

-- Solution :
SELECT
	q.*,
    COALESCE(npv, 0)
FROM queries q
LEFT JOIN npv n
ON q.id = n.id
AND q.year = n.year
ORDER BY q.id, q.year;