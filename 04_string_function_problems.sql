-- Creating the Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting the Database
USE local_mysql;

-- Create the table
CREATE TABLE users (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

-- Insert 10 records with different email domains
INSERT INTO users (Name, Email) VALUES
('John Doe', 'johndoe@example.com'),
('Alice Smith', 'alicesmith@example.org'),
('Bob Johnson', 'bobjohnson@company.net'),
('Charlie Brown', 'charlie.brown@domain.co'),
('Diana Ross', 'dianaross@mailservice.io'),
('Eve White', 'eve.white@website.co.uk'),
('Frank Green', 'frank.green@corporate.biz'),
('Grace Lee', 'grace.lee@techworld.ca'),
('Henry Black', 'henryblack@service.us'),
('Ivy Adams', 'ivy.adams@shoponline.eu');

-- 1. Extract the domain name from email column in users table.
-- SOLUTION
SELECT
	ID,
    Name,
    Email,
    SUBSTRING(Email, LOCATE('@', Email)+1) AS DomainName
FROM users;

-- 2. Extract the name from email column in users table.
-- SOLUTION
SELECT
	ID,
    Name,
    Email,
    LEFT(Email, LOCATE('@', Email) - 1) as UserName
FROM users;


