-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

DROP TABLE IF EXISTS teams;
CREATE TABLE teams(
	team_Id INT PRIMARY KEY, 
    team_name VARCHAR(20) NOT NULL, 
    city VARCHAR(20), 
    captain_Id INT
);

INSERT INTO teams 
VALUES 
	(1,'CSK','Chennai', 7),
	(2, 'GT', 'Gujarat', 39),
	(3, 'MI', 'Mumbai', 20),
    (4,'RCB','Bengolore',46),
    (5,'SRH','Hyderabad', 14),
	(6,'LSG','Luknow',98),
    (7,'DD','Delhi',100),
    (8,'RR','Rajastan',203);

DROP TABLE IF EXISTS players;
CREATE TABLE players(
	player_id INT PRIMARY KEY, 
    player_name VARCHAR(20) NOT NULL, 
    team_id INT, 
    role VARCHAR(20),
	salary INT, 
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

INSERT INTO players 
VALUES
	(46,'virat',4,'batsman',12000),
    (7,'dhoni',1,'batsman',11500),
    (50,'shardul',2,'bowler',6000),
	(18, 'Shami', 2, 'bowler', 8000),
    (25, 'hardik', 3, 'Allrounder', 8500),
    (32, 'Devilliers', 4, 'Batsman', 10000),
	(49, 'pant', 7, 'wicket keeper', 9500),
    (58, 'KLRahul', 6, 'Allrounder', 7500),
    (39, 'Gill', 2, 'batsman', 12000),
	(72, 'Jadeza', 1, 'Allrounder', 10000),
    (83, 'Baristow', 5, 'Batsman', 8500),
    (20, 'Pollard', 3, 'Allrounder', 9500),
	(67,'Sanju',8,'Wicketkeepr',9000);


DROP TABLE IF EXISTS matches;
CREATE TABLE matches( 
	match_id INT PRIMARY KEY, 
    team1_id INT,
    team2_id INT, 
	match_date DATE, 
    winner_id INT, 
    score_team1 INT, 
    score_team2 INT, 
	FOREIGN KEY (team1_id) REFERENCES teams(team_id),
	FOREIGN KEY (team2_id) REFERENCES teams(team_id),
	FOREIGN KEY (winner_id) REFERENCES teams(team_id)
);

INSERT INTO matches 
VALUES
	(1, 1, 8, '2022-01-01', 1, 160, 148),
    (2, 3, 2, '2022-02-01', 3, 140, 97),
    (3, 8, 7, '2022-03-01', 7, 170, 173),
	(4, 2, 5, '2022-04-01', 5, 130, 155),
    (5, 3, 6, '2022-05-01', 3, 160, 108),
    (6, 5, 7, '2022-06-01', 7, 158, 179),
	(7, 2, 4, '2022-03-01', 2, 182, 179),
	(8, 5, 3, '2022-04-21', 3, 149, 156),
    (10, 4, 6, '2022-11-01', 4, 130, 110),
	(9, 1, 8, '2022-05-01', 8, 97, 100),
    (11, 6, 4, '2022-03-01', 4, 123, 129),
    (12, 8, 1, '2022-04-11', 1, 118, 159),
	(13, 7, 5, '2022-01-01', 5, 138, 139),
    (14, 6, 3, '2022-05-07', 3, 200, 210),
    (15, 4, 2, '2022-01-01', 4, 195, 186),
	(16, 7, 1, '2022-05-08', 1, 182, 190);

select * from matches;
select * from teams;
select * from players;

-- Q1. What are the names of the players whose salary is greater than or equal to 10000? and how many of them?
-- Solution :
SELECT
	player_name,
    salary
FROM players
WHERE salary >= 10000
ORDER BY salary DESC;

SELECT COUNT(*) AS total_employees
FROM players
WHERE salary >= 10000;

-- Q2. find the total spend by each team on batsmans, bowers and allrounders.
-- Solution :
SELECT
	t.team_name,
    p.role,
    SUM(salary) AS total_spent
FROM players p
JOIN teams t
ON p.team_id = t.team_id
GROUP BY t.team_name, p.role
ORDER BY total_spent DESC;

-- Q3. list the players in each team
-- Solution :
SELECT
	t.team_name,
    GROUP_CONCAT(p.player_name ORDER BY p.player_name SEPARATOR ', ') AS player_name
FROM players p
JOIN teams t
ON p.team_Id = t.team_id
GROUP BY t.team_name
ORDER BY t.team_name;

-- Q4. list the no.of players from each team
-- Solution :
SELECT
	t.team_name,
    count(player_name) AS total_players
FROM players p
JOIN teams t
	ON p.team_id = t.team_id
GROUP BY t.team_name;

-- Q5. What is the team name of the player with player_id = 32 and 67.
-- Solution :
SELECT
	t.team_name,
    p.player_id,
    p.player_name
FROM players p 
JOIN teams t 
	ON p.team_id = t.team_id
WHERE player_id IN (32, 67);

-- Q6. find no.of players from each team and return team names and no.of players in each team
-- Solution : 
SELECT
	t.team_id,
    t.team_name,
    COUNT(*)
FROM teams t
JOIN players p
	ON t.team_id = p.team_id
GROUP BY t.team_id, t.team_name;

-- Q7. rank the players depending upon the salary they get
-- Solution :
SELECT
	t.team_id,
    t.team_name,
    p.player_name,
    p.role,
    p.salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
FROM players p
JOIN teams t
	ON p.team_id = t.team_id;


-- Q8. find top 3 teams who spend more money on players.
-- Solution :
SELECT
	t.team_id,
    t.team_name,
    SUM(p.salary) AS total_spend
FROM players p
JOIN teams t
	ON p.team_id = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY total_spend DESC
LIMIT 3;


-- Q9. What is the team name and captain name of the team_id =4
-- Solution :
SELECT
	t.team_id,
    t.team_name,
	p.player_name AS captain
FROM players p
JOIN teams t
	ON p.player_id = t.captain_id
WHERE t.team_id = 4;

-- Q10. What are the player names and their roles in the team with team_id =3,8
SELECT
	t.team_name,
    p.player_name,
    p.role
FROM players p 
JOIN teams t 
	ON p.team_id = t.team_id
WHERE t.team_id IN (3, 8);

-- Q11. What are the team names and the number of matches they have won? and show some rankings in points table use
-- both row number and dense rank functions to see the difference.
-- Solution 1(Using DENSE_RANK()):
WITH cte AS (
	SELECT
		winner_id,
		COUNT(*) AS won
	FROM matches
    GROUP BY winner_id
)
SELECT 
	DENSE_RANK() OVER(ORDER BY won DESC) AS Ranking,
	t.team_name,
    won
FROM cte
JOIN teams t
	ON cte.winner_id = t.team_id;

-- Solution 2(Using ROW_NUMBER())
WITH cte AS (
	SELECT
		winner_id,
		COUNT(*) AS won
	FROM matches
    GROUP BY winner_id
)
SELECT 
	ROW_NUMBER() OVER(ORDER BY won DESC) AS Ranking,
	t.team_name,
    IFNULL(won, 0)
FROM cte
RIGHT JOIN teams t
	ON cte.winner_id = t.team_id;
    

-- Q12 What is the average salary of players in the teams with different cities?
-- Solution :
SELECT
	t.city,
    AVG(p.salary) AS avg_salary
FROM players p
RIGHT JOIN teams t 
	ON p.team_id = t.team_Id
GROUP BY t.city
ORDER BY avg_salary DESC;

-- Q13. Which team won the most matches?
-- Solution :
SELECT
	t.team_name,
    COUNT(m.winner_id) AS won
FROM matches m
JOIN teams t 
	ON m.winner_id = t.team_Id
GROUP BY t.team_name
ORDER BY won DESC
LIMIT 1;

-- Q14. What is the date and the total score of the match and return date on which recorded maximum score.
SELECT 
	match_date,
	score_team1 + score_team2 AS total_score
FROM matches;

SELECT 
	match_date,
	score_team1 + score_team2 AS total_score
FROM matches
ORDER BY total_score DESC
LIMIT 1;