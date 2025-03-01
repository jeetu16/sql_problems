-- Drop tables and sequence:
DROP TABLE student_batch_maps;
DROP TABLE instructor_batch_maps;
DROP TABLE attendances;
DROP TABLE sessions;
DROP TABLE test_scores;
DROP TABLE tests;
DROP TABLE users2;
DROP TABLE batches;

-- 1.users2 table:  name(user name), active(boolean to check if user is active)
CREATE TABLE users2 (
  id INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-incrementing primary key
  name VARCHAR(50) NOT NULL,           -- Name column with max 50 characters
  active TINYINT(1) NOT NULL DEFAULT 1, -- Boolean stored as TINYINT(1)
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Default to current time
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Auto-update on modification
);

INSERT INTO users2 (id, name, active, created_at, updated_at) 
VALUES 
(1, 'Rohit', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(2, 'James', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(3, 'David', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(4, 'Steven', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(5, 'Ali', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(6, 'Rahul', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(7, 'Jacob', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(8, 'Maryam', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(9, 'Shwetha', 0, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(10, 'Sarah', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(11, 'Alex', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(12, 'Charles', 0, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(13, 'Perry', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(14, 'Emma', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(15, 'Sophia', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(16, 'Lucas', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(17, 'Benjamin', 1, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(18, 'Hazel', 0, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY));



-- 2.batches  table:  name(batch name), active(boolean to check if batch is active)
CREATE TABLE batches (
  id INT PRIMARY KEY NOT NULL,
  name VARCHAR(100) UNIQUE NOT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO batches (id, name, active, created_at, updated_at) 
VALUES 
(1, 'Statistics', 1, DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY)),
(2, 'Mathematics', 1, DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY)),
(3, 'Physics', 0, DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY));

-- 3.student_batch_maps  table: this table is a mapping of the student and his batch. deactivated_at is the time when a student is made inactive in a batch.
CREATE TABLE student_batch_maps (
  id INT PRIMARY KEY NOT NULL,
  user_id INT NOT NULL,
  batch_id INT NOT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  deactivated_at TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users2(id),
  FOREIGN KEY (batch_id) REFERENCES batches(id)
);

INSERT INTO student_batch_maps (id, user_id, batch_id, active, deactivated_at, created_at, updated_at) 
VALUES 
(1, 1, 1, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(2, 2, 1, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(3, 3, 1, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(4, 4, 1, 0, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(5, 5, 2, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(6, 6, 2, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(7, 7, 2, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(8, 8, 2, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(9, 9, 2, 0, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(10, 10, 3, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(11, 11, 3, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(12, 12, 3, 0, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(13, 13, 3, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(14, 14, 3, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY)),
(15, 4, 2, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY)),
(16, 9, 3, 0, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)),
(17, 9, 1, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)),
(18, 12, 1, 1, CURRENT_TIMESTAMP, DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY), DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY));


-- 4.instructor_batch_maps  table: this table is a mapping of the instructor and the batch he has been assigned to take class/session.
CREATE TABLE instructor_batch_maps (
  id INT PRIMARY KEY NOT NULL,
  user_id INT NOT NULL,
  batch_id INT NOT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users2(id),
  FOREIGN KEY (batch_id) REFERENCES batches(id)
);

INSERT INTO instructor_batch_maps (id, user_id, batch_id, active, created_at, updated_at) VALUES
(1, 15, 1, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_SUB(CURDATE(), INTERVAL 4 DAY)),
(2, 16, 2, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_SUB(CURDATE(), INTERVAL 4 DAY)),
(3, 17, 3, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_SUB(CURDATE(), INTERVAL 4 DAY)),
(4, 18, 2, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_SUB(CURDATE(), INTERVAL 4 DAY));


-- 5.sessions table: Every day session happens where the teacher takes a session or class of students.
CREATE TABLE sessions (
  id INT PRIMARY KEY NOT NULL,
  conducted_by INT NOT NULL,
  batch_id INT NOT NULL,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (conducted_by) REFERENCES users2(id),
  FOREIGN KEY (batch_id) REFERENCES batches(id)
);

INSERT INTO sessions (id, conducted_by, batch_id, start_time, end_time, created_at, updated_at) VALUES
(1, 15, 1, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 240 MINUTE), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 180 MINUTE), CURDATE(), CURDATE()),
(2, 16, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 240 MINUTE), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 180 MINUTE), CURDATE(), CURDATE()),
(3, 17, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 240 MINUTE), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 180 MINUTE), CURDATE(), CURDATE()),
(4, 15, 1, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 180 MINUTE), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 120 MINUTE), CURDATE(), CURDATE()),
(5, 16, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 180 MINUTE), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 120 MINUTE), CURDATE(), CURDATE()),
(6, 18, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 120 MINUTE), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 60 MINUTE), CURDATE(), CURDATE());


-- 6.attendances table: After session or class happens between teacher and student, attendance is given by student. students provide ratings to the teacher.
CREATE TABLE attendances (
  student_id INT NOT NULL,
  session_id INT NOT NULL,
  rating DOUBLE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (student_id, session_id),
  FOREIGN KEY (student_id) REFERENCES users2(id),
  FOREIGN KEY (session_id) REFERENCES sessions(id)
);

INSERT INTO attendances (student_id, session_id, rating, created_at, updated_at) VALUES
(1, 1, 8.5, CURDATE(), CURDATE()),
(2, 1, 7.5, CURDATE(), CURDATE()),
(3, 1, 6.0, CURDATE(), CURDATE()),
(5, 2, 8.5, CURDATE(), CURDATE()),
(6, 2, 7.5, CURDATE(), CURDATE()),
(7, 2, 6.0, CURDATE(), CURDATE()),
(8, 2, 6.0, CURDATE(), CURDATE()),
(10, 3, 9.5, CURDATE(), CURDATE()),
(11, 3, 7.0, CURDATE(), CURDATE()),
(13, 3, 8.0, CURDATE(), CURDATE()),
(14, 3, 6.0, CURDATE(), CURDATE()),
(1, 4, 7.0, CURDATE(), CURDATE()),
(2, 4, 5.5, CURDATE(), CURDATE()),
(5, 5, 5.0, CURDATE(), CURDATE()),
(5, 6, 6.0, CURDATE(), CURDATE()),
(9, 2, 4.0, CURDATE(), CURDATE()),
(12, 3, 5.0, CURDATE(), CURDATE());


-- 7.tests table: Test is created by instructor. total_mark is the maximum marks for the test.
CREATE TABLE tests (
   id INT PRIMARY KEY NOT NULL,
   batch_id INT,
   created_by INT,
   total_mark INT NOT NULL,
   created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   FOREIGN KEY (batch_id) REFERENCES batches(id),
   FOREIGN KEY (created_by) REFERENCES users2(id)
);

INSERT INTO tests (id, batch_id, created_by, total_mark, created_at, updated_at) VALUES
(1, 1, 15, 100, CURDATE(), CURDATE()),
(2, 2, 16, 100, CURDATE(), CURDATE()),
(3, 3, 17, 100, CURDATE(), CURDATE()),
(4, 2, 18, 100, CURDATE(), CURDATE()),
(5, 1, 15, 50, CURDATE(), CURDATE()),
(6, 1, 15, 25, CURDATE(), CURDATE()),
(7, 1, 15, 25, CURDATE(), CURDATE()),
(8, 2, 16, 50, CURDATE(), CURDATE()),
(9, 3, 17, 50, CURDATE(), CURDATE());

-- 8.test_scores table: Marks scored by students are added in the test_scores table.
CREATE TABLE test_scores (
  test_id INT,
  user_id INT,
  score INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (test_id, user_id),
  FOREIGN KEY (test_id) REFERENCES tests(id),
  FOREIGN KEY (user_id) REFERENCES users2(id)
);

INSERT INTO test_scores (test_id, user_id, score, created_at, updated_at) VALUES
(1, 1, 80, CURDATE(), CURDATE()),
(1, 2, 60, CURDATE(), CURDATE()),
(1, 3, 30, CURDATE(), CURDATE()),
(2, 5, 80, CURDATE(), CURDATE()),
(2, 6, 35, CURDATE(), CURDATE()),
(2, 7, 38, CURDATE(), CURDATE()),
(2, 8, 90, CURDATE(), CURDATE()),
(3, 10, 65, CURDATE(), CURDATE()),
(3, 11, 85, CURDATE(), CURDATE()),
(3, 13, 95, CURDATE(), CURDATE()),
(3, 14, 100, CURDATE(), CURDATE()),
(5, 1, 40, CURDATE(), CURDATE()),
(5, 2, 35, CURDATE(), CURDATE()),
(5, 3, 45, CURDATE(), CURDATE()),
(6, 1, 22, CURDATE(), CURDATE()),
(6, 2, 12, CURDATE(), CURDATE()),
(7, 1, 16, CURDATE(), CURDATE()),
(7, 3, 10, CURDATE(), CURDATE()),
(8, 5, 15, CURDATE(), CURDATE()),
(8, 6, 20, CURDATE(), CURDATE()),
(9, 13, 25, CURDATE(), CURDATE()),
(9, 14, 35, CURDATE(), CURDATE());

-- Using the above table schema, please write the following queries for below questions.

/* ******************** QUESTION #1 ******************** */
-- > 1.Calculate the average rating given by students to each teacher for each session created. Also, provide the batch name for which session was conducted.
WITH cte AS (
	SELECT 
		a.session_id,
		b.name AS batch_name,
		u.name AS teacher_name,
		a.rating
	FROM attendances a
	JOIN sessions s
		ON a.session_id = s.id
	JOIN users2 u
		ON s.conducted_by = u.id
	JOIN batches b
		ON s.batch_id = b.id
)
SELECT
	  session_id,
    teacher_name,
    batch_name,
    ROUND(AVG(rating),2) AS avg_rating
FROM cte
GROUP BY session_id, batch_name, teacher_name
ORDER BY 2;

/* ******************** QUESTION #2 ******************** */
-- > 2.Find the attendance percentage  for each session for each batch. Also mention the batch name and users name who has conduct that session

WITH tse AS (
	SELECT
		s.id AS session_id,
		sbm.batch_id,
		COUNT(user_id) AS total_student_enrolled
	FROM student_batch_maps sbm
  JOIN sessions s ON sbm.batch_id = s.batch_id
	WHERE sbm.active = 1
	GROUP BY sbm.batch_id, s.id
),
tsp AS (
	SELECT
		s.id AS session_id,
		COUNT(student_id) AS total_student_attended
	FROM sessions s
  LEFT JOIN attendances a ON a.session_id = s.id
  LEFT JOIN student_batch_maps sbm ON sbm.user_id = a.student_id AND sbm.batch_id = s.batch_id
  WHERE sbm.active = 1
	GROUP BY session_id
)
SELECT
	e.session_id,
    e.batch_id,
    u.name AS teacher,
    b.name AS batch,
    COALESCE((p.total_student_attended * 100) / NULLIF(e.total_student_enrolled, 0), 0) AS attendance_percentage
FROM tse e
LEFT JOIN tsp p ON e.session_id = p.session_id
JOIN batches b ON b.id = e.batch_id
JOIN sessions s ON s.id = e.session_id
JOIN users2 u ON u.id = s.conducted_by
ORDER BY session_id;

/*

3.What is the average marks scored by each student in all the tests the student had appeared?

4.A student is passed when he scores 40 percent of total marks in a test. Find out how many students passed in each test. Also mention the batch name for that test.

5.A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
 At a time, one student can be active in one batch only. One Student can not be transferred more than four times. Calculate each students attendance percentage for all the sessions created for his past batch. Consider only those sessions for which he was active in that past batch.

6. What is the average percentage of marks scored by each student in all the tests the student had appeared?

7. A student is passed when he scores 40 percent of total marks in a test. Find out how many percentage of students have passed in each test. Also mention the batch name for that test.

8. A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
    At a time, one student can be active in one batch only. One Student can not be transferred more than four times.
    Calculate each students attendance percentage for all the sessions.

*/
