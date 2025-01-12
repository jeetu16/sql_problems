-- Create Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Select Database
USE local_mysql;

-- Create Authors table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    AuthorID INT,
    BookTitle VARCHAR(200),
    PublicationYear DATE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Insert records into Authors table
INSERT INTO Authors (AuthorID, AuthorName) VALUES
(1, 'Author A'),
(2, 'Author B'),
(3, 'Author C'),
(4, 'Author D'),
(5, 'Author E'),
(6, 'Author F');

-- Insert records into Books table
INSERT INTO Books (BookID, AuthorID, BookTitle, PublicationYear) VALUES
(1, 1, 'Book 1 by Author A', '2023-01-15'),
(2, 1, 'Book 2 by Author A', '2023-07-20'),
(3, 2, 'Book 1 by Author B', '2022-03-10'),
(4, 2, 'Book 2 by Author B', '2023-05-05'),
(5, 3, 'Book 1 by Author C', '2023-06-25'),
(6, 3, 'Book 2 by Author C', '2021-08-15'),
(7, 4, 'Book 1 by Author D', '2022-09-30'),
(8, 4, 'Book 2 by Author D', '2023-12-05'),
(9, 5, 'Book 1 by Author E', '2023-04-17'),
(10, 5, 'Book 2 by Author E', '2020-11-01'),
(11, 5, 'Book 3 by Author E', '2020-12-01');

-- 1. List all authors and number of books written

-- Solution 1

SELECT 
	a.AuthorID,
    a.AuthorName,
    COUNT(b.BookID) AS totalWrittenBooks
FROM Authors a
LEFT JOIN Books b
USING(AuthorID)
GROUP BY a.AuthorID;

-- Solution 2

SELECT 
    a.AuthorID,
    a.AuthorName,
    COALESCE(b.totalWrittenBooks, 0) AS totalWrittenBooks
FROM Authors a
LEFT JOIN (
    SELECT 
        AuthorID,
        COUNT(BookID) AS totalWrittenBooks
    FROM Books
    GROUP BY AuthorID
) b
ON a.AuthorID = b.AuthorID;


-- 2. Find books published in the last year and corresponding authors;

-- Solution 1

SELECT
	b.*,
    a.AuthorName
FROM Books b
JOIN Authors a
USING(AuthorID)
WHERE YEAR(PublicationYear) = YEAR(DATE_SUB(NOW(), INTERVAL 1 YEAR));

-- Solution 2

SELECT
    b.*,
    a.AuthorName
FROM Books b
JOIN Authors a
    ON b.AuthorID = a.AuthorID
WHERE b.PublicationYear LIKE '2023%';

      



