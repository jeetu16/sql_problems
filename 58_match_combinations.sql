-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;
 
-- Create teams2 table
CREATE TABLE teams2 (
    team_name VARCHAR(50) NOT NULL
);

-- Inser values into teams2 table
INSERT INTO teams2 (team_name) VALUES 
('CSK'),
('KKR'),
('GT'),
('DC'),
('LSG');

-- 1. You are given a table named teams2 with a single column team_name that contains team_name column.
--    Write a SQL query to generate all possible unique match combinations between the teams in the format: teaml VS team2
-- Constraints:
-- Each pair should appear only once (e.g., "CSK VS KKR" is valid, but "KKR VS CSK" should not appear again).
-- A team should not be matched with itself (e.g., "CSK VS CSK" is invalid).

-- Solution 1
SELECT
	concat(t1.team_name, " vs ", t2.team_name) AS matches
FROM teams2 t1, teams2 t2
WHERE t1.team_name < t2.team_name
ORDER BY matches;