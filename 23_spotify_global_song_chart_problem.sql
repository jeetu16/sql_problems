-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Creating artists Table:
CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    label_owner VARCHAR(100)
);

-- Creating songs Table:
CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    artist_id INT,
    name VARCHAR(100)
);

-- Creating global_song_rank Table:
CREATE TABLE global_song_rank (
    day INT,
    song_id INT,
    `rank` INT
);


-- Inserting records into the artists table:
INSERT INTO artists (artist_id, artist_name, label_owner) VALUES
(101, 'Ed Sheeran', 'Warner Music Group'),
(120, 'Drake', 'Warner Music Group'),
(125, 'Bad Bunny', 'Rimas Entertainment'),
(130, 'Lady Gaga', 'Interscope Records'),
(140, 'Katy Perry', 'Capitol Records');

-- Inserting records into the songs table:
INSERT INTO songs (song_id, artist_id, name) VALUES
(55511, 101, 'Perfect'),
(45202, 101, 'Shape of You'),
(22222, 120, 'One Dance'),
(19960, 120, 'Hotline Bling'),
(33333, 125, 'Dákiti'),
(44444, 125, 'Yonaguni'),
(55555, 130, 'Bad Romance'),
(66666, 130, 'Poker Face'),
(99999, 140, 'Roar'),
(101010, 140, 'Firework');

-- Inserting records into the global_song_rank table:
INSERT INTO global_song_rank (day, song_id, `rank`) VALUES
(1, 45202, 5),
(3, 45202, 2),
(1, 19960, 3),
(9, 19960, 6),
(1, 55511, 8),
(5, 22222, 7),
(2, 33333, 4),
(4, 44444, 8),
(6, 55555, 1),
(7, 66666, 10),
(5, 99999, 5);


-- Question : Our goal is to find the top 5 artists whose songs have appeared most frequently 
-- ------   : in the Top 10 of the global music charts. 

-- Solution 1
WITH top_five_artist AS (
	SELECT 
		a.artist_id,
		a.artist_name,
		count(a.artist_id) AS mostSongOccurred,
        DENSE_RANK() OVER(ORDER BY count(a.artist_id) DESC) as artist_ranking
	FROM artists a
	JOIN songs s
		ON a.artist_id = s.artist_id
	JOIN global_song_rank gsr
		ON s.song_id = gsr.song_id
	WHERE gsr.rank <= 10
	GROUP BY artist_id, artist_name
)
SELECT 
	artist_name,
    artist_ranking
FROM top_five_artist
WHERE artist_ranking < 6;

-- Solution 2
SELECT 
	artist_name,
    DENSE_RANK() OVER (ORDER BY COUNT(gsr.song_id) DESC) AS artist_rank
FROM artists a
JOIN songs s
	ON a.artist_id = s.artist_id
JOIN global_song_rank gsr
	ON s.song_id = gsr.song_id
WHERE gsr.rank <=10
GROUP BY artist_name
LIMIT 3;




