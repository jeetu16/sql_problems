-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create Employees Table
CREATE TABLE Employees 
(
  ID INT PRIMARY KEY,
  FirstName VARCHAR (50),
  LastName VARCHAR (50),
  Gender VARCHAR (50) ,
  Salary INT
);

-- Inser values into employees table

INSERT INTO Employees VALUES(1, 'Tony', 'Stark', 'Male', 80000),
							(2, 'Steve', 'Rogers', 'Male', 70000) ,
							(3, 'Thor', 'Odinson', 'Male', 65000), 
							(4, 'Nick', 'Fury', 'Male', 75000), 
							(5, 'Bruce', 'Banner', 'Male', 50000), 
							(6, 'Natasha', 'Ramanoff', 'Female', 65000),
							(7, 'Jane', 'Foster', 'Female', 45000),
							(8, 'Peter', 'Parker', 'Male', 80000);


-- 1. How to find the highest salary Employee?

-- Solution 1
SELECT *
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

-- Solution 2
SELECT e.*
FROM Employees e
JOIN (
	SELECT MAX(Salary) AS MaxSalary
    FROM Employees
) AS e2
ON Salary = e2.MaxSalary;

-- 2. How to find 2nd highest salary Employee?

-- Solution 1
SELECT *
FROM Employees
WHERE Salary = (
	SELECT MAX(Salary)
    FROM Employees
    WHERE Salary < (SELECT MAX(Salary) FROM Employees)
);

-- Solution 2
SELECT *
FROM (
	SELECT
		*,
        DENSE_RANK() OVER (ORDER BY Salary DESC) as Salary_Rank
	FROM Employees
) AS ranked_employees
WHERE Salary_Rank = 2;

-- Solution 3
SELECT e.*
FROM Employees e
JOIN (
	SELECT 
		DISTINCT Salary
    FROM Employees
    ORDER BY Salary DESC
    LIMIT 0, 1
) AS ms
ON e.Salary =  ms.Salary
ORDER BY e.Salary DESC;

-- 3. How to find nth highest salary Employee using a Sub-Query?

-- Solution 1
SELECT *
FROM Employees
WHERE Salary = (
	SELECT DISTINCT(Salary)
    FROM Employees
    ORDER BY Salary DESC
    LIMIT 3, 1
);

-- Solution 2
SELECT e.*
FROM Employees e
JOIN (
	SELECT DISTINCT Salary
    FROM Employees
    ORDER BY Salary DESC
    LIMIT 4, 1
) AS nth_salaries
ON e.Salary = nth_salaries.Salary
WHERE e.Salary = nth_salaries.Salary;

-- Solution 3
SELECT *
FROM Employees e1
WHERE (
	SELECT COUNT(DISTINCT e2.Salary)
    FROM Employees e2
    WHERE e2.Salary > e1.Salary
) = 4-1;

-- Solution 4
SELECT *
FROM (
	SELECT 
		*,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank
	FROM Employees
) AS salaryRanks
WHERE Salary_Rank = 4;

-- 4. How to find nth highest salary Employee in using a CTE?

-- Solution 1
WITH ranked_salaries AS (
	SELECT DISTINCT Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) as salaryRank
    FROM Employees
)
SELECT e.*
FROM Employees e
JOIN ranked_salaries rs
ON e.Salary = rs.Salary
WHERE rs.salaryRank = 4;

-- Solution 2
WITH Ranked_Salaries AS (
	SELECT DISTINCT Salary
    FROM Employees
	ORDER BY Salary DESC
    LIMIT 4
)
SELECT e.*
FROM Employees e
JOIN Ranked_Salaries rs
On e.Salary = rs.Salary
WHERE e.Salary = (Select MIN(Salary) FROM Ranked_Salaries);



-- 5. How to find the 2nd, 3rd or 15th highest salary Employees?

-- Solution 1
WITH ranked_salaries AS (
	SELECT DISTINCT Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) as salaryRank
    FROM Employees
)
SELECT 
	e.*,
    salaryRank
FROM Employees e
JOIN ranked_salaries rs
ON e.Salary = rs.Salary
WHERE rs.salaryRank IN (1, 3) 
ORDER BY salaryRank;

-- Solution 2
SELECT 
	e.*,
    rs.Salary_Rank
FROM Employees e
JOIN (
	SELECT 
		ID,
		DENSE_RANK() OVER (ORDER BY Salary DESC) as Salary_Rank
    FROM Employees
) AS rs
ON e.ID = rs.ID
WHERE rs.Salary_Rank IN (1, 3, 15);