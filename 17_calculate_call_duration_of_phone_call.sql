-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

--  Creating call_start table
CREATE TABLE call_start(
	ph_no VARCHAR(10),
	start_time DATETIME
);
-- Inserting Records into the call_start table
INSERT INTO call_start VALUES
('contact_1','2024-05-01 10:20:00'),
('contact_1','2024-05-01 16:25:00'),
('contact_2','2024-05-01 12:30:00'),
('contact_3','2024-05-02 10:00:00'),
('contact_3','2024-05-02 12:30:00'),
('contact_3','2024-05-03 09:20:00');

--  Creating call_end table
CREATE TABLE call_end(
	ph_no VARCHAR(10),
    end_time DATETIME
);
-- Inserting Records into the call_end table
INSERT INTO call_end VALUES
('contact_1','2024-05-01 10:45:00'),
('contact_1','2024-05-01 17:05:00'),
('contact_2','2024-05-01 12:55:00'),
('contact_3','2024-05-02 10:20:00'),
('contact_3','2024-05-02 12:50:00'),
('contact_3','2024-05-03 09:40:00');


-- Question : Write a sql query to find out call duration(in minute) for every calls

-- Solution :

WITH callStarted AS (
	SELECT 
		*,
        DENSE_RANK() OVER(ORDER BY ph_no, start_time) as startCallRank
    FROM call_start
),
callEnded AS (
	SELECT 
		*,
        DENSE_RANK() OVER(ORDER BY ph_no, end_time) as endCallRank
    FROM call_end
)
SELECT cs.ph_no, cs.start_time, ce.end_time, minute(timediff(ce.end_time, cs.start_time)) as duration_in_minute
FROM callStarted cs
JOIN callEnded ce
ON cs.startCallRank = ce.endCallRank;

