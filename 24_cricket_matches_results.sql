-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Creating cricket_match Table:
CREATE TABLE cricket_match(
	match_id INT,
	team1 VARCHAR(20),
	team2 VARCHAR(20),
	result VARCHAR(20)
);

-- Inserting records into the cricket_match table:
INSERT INTO cricket_match 
VALUES
	(1,'ENG','NZ','NZ'),
	(2,'PAK','NED','PAK'),
	(3,'AFG','BAN','BAN'),
	(4,'SA','SL','SA'),
	(5,'AUS','IND','AUS'),
	(6,'NZ','NED','NZ'),
	(7,'ENG','BAN','ENG'),
	(8,'SL','PAK','PAK'),
	(9,'AFG','IND','IND'),
	(10,'SA','AUS','SA'),
	(11,'BAN','NZ','BAN'),
	(12,'PAK','IND','IND'),
	(13,'SA','IND','DRAW');
    
-- Question : Write a sql query to find team_name, no_of_match_played, no_of_win, no_of_lost count and draw.

-- Solution :

WITH cte AS (
	SELECT 
		team1 AS team_name,
		CASE WHEN team1 = result THEN 1 ELSE 0 END AS wins,
        CASE WHEN result = 'DRAW' THEN 1 ELSE 0 END AS draw
	FROM cricket_match
	UNION ALL
	SELECT 
		team2 AS team_name,
		CASE WHEN team2 = result THEN 1 ELSE 0 END AS wins,
        CASE WHEN result = 'DRAW' THEN 1 ELSE 0 END AS draw
	FROM cricket_match
)
SELECT
	team_name,
    COUNT(team_name) AS no_of_match_played,
    SUM(wins) AS no_of_win,
    COUNT(team_name) - SUM(wins) - SUM(draw) AS no_of_lost,
    SUM(draw) as draw
FROM cte
GROUP BY team_name
ORDER BY team_name;