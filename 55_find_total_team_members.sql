-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create an Teams Table
DROP TABLE IF EXISTS Teams;
CREATE TABLE Teams (
    TeamID INT PRIMARY KEY,
    Members TEXT
);

-- Insert values into Teams Table
INSERT INTO Teams (TeamID, Members) VALUES
(1, 'Chris, Evan, Marty, Eva'),
(2, 'Jake, Olivia'),
(3, 'Sophia, Liam, Noah, Emma'),
(4, 'Ava, Lucas, Mia, Ethan, Amelia'),
(5, 'Benjamin, Charlotte'),
(6, 'Harper, Henry, Evelyn, Daniel, Ella'),
(7, 'Michael, Emily, Alexander'),
(8, 'James, Abigail, William, Isabella, Jack, Grace'),
(9, 'Sebastian, Chloe'),
(10, 'David, Lily, Samuel, Madison'),
(11, 'David, Lily, Samuel, Madison,Joe,Adam');


-- Question : Given a Teams table with columns TeamID (integer) and Members (comma-separated string of names), 
--            write a query to calculate and display the total number of members in each team.

-- Solution :

SELECT
	*,
    LENGTH(Members)-LENGTH(REPLACE(Members, ',', '')) + 1 AS total_members
FROM Teams;
