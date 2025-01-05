-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Query to create table:
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees2 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    DateHired DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');

INSERT INTO Employees2 (EmployeeID, FirstName, LastName, DepartmentID, Salary, DateHired) VALUES
(1, 'Alice', 'Smith', 1, 50000, '2020-01-15'),
(2, 'Bob', 'Johnson', 1, 60000, '2018-03-22'),
(3, 'Charlie', 'Williams', 2, 70000, '2019-07-30'),
(4, 'David', 'Brown', 2, 80000, '2017-11-11'),
(5, 'Eve', 'Davis', 3, 90000, '2021-02-25'),
(6, 'Frank', 'Miller', 3, 55000, '2020-09-10'),
(7, 'Grace', 'Wilson', 2, 75000, '2016-04-05'),
(8, 'Henry', 'Moore', 1, 65000, '2022-06-17'),
(9, 'Steve', 'Smith', 1, 75000, '2017-03-12'),
(10, 'Scott', 'Boland', 2, 45000, '2022-09-12'),
(11, 'Pat', 'Cummins', 3, 70000, '2018-10-22'),
(12, 'Travis', 'Head', 3, 65000, '2020-09-30'),
(13, 'Joe', 'Root', 3, 90000, '2020-01-15');


-- 1: Find the top 3 highest-paid employees in each department.

-- Solution
SELECT 
	EmployeeID,
    FirstName,
    LastName,
    DateHired,
    DepartmentName,
    Salary,
    DepartmentID,
    salaryRank,
    MaxDeptSalary
FROM (
	SELECT
		e.*,
        d.DepartmentName,
        MAX(e.Salary) OVER(PARTITION BY d.DepartmentID) AS MaxDeptSalary,
		DENSE_RANK() OVER (PARTITION BY d.DepartmentID ORDER BY e.Salary DESC) as salaryRank
	FROM Employees2 e
    JOIN Departments d
    USING(DepartmentID)
) as Salary_Rank
WHERE salaryRank <= 3
ORDER BY MaxDeptSalary DESC;

-- 2: Find the average salary of employees hired in the last 5 years.

-- Solution
SELECT AVG(Salary)
FROM Employees2
WHERE DateHired >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 3: Find the employees whose salry is less than the average salary of employees hired in the last 5 years.

-- Solution 1
SELECT *
FROM Employees2 e
WHERE Salary < (
	SELECT AVG(Salary)
    FROM Employees2
    WHERE DateHired >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
);

-- Solution 2
SELECT 
	e.*
FROM Employees2 e
JOIN (
	SELECT AVG(Salary) as AverageSalary
    FROM Employees2
    WHERE DateHired >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
) AS e2
WHERE e.Salary < e2.AverageSalary;

-- Solution 3
SELECT
	*
FROM (
	SELECT
		*,
        AVG(CASE WHEN DateHired > DATE_SUB(CURDATE(), INTERVAL 5 YEAR) THEN Salary END) OVER() AS AverageSalary
	FROM Employees2
) AS e
WHERE e.Salary < e.AverageSalary;



