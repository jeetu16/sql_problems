-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create HotelBookings Table
CREATE TABLE HotelBookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    HotelID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    BookingStatus VARCHAR(20)
);


-- Insert values into HotelBookings table
INSERT INTO HotelBookings (BookingID, CustomerID, HotelID, CheckInDate, CheckOutDate, BookingStatus) VALUES
(1, 301, 501, '2025-02-10', '2025-02-15', 'Completed'),
(2, 301, 502, '2025-02-12', '2025-02-18', 'Completed'),
(3, 302, 501, '2025-02-20', '2025-02-25', 'Cancelled'),
(4, 303, 503, '2025-02-05', '2025-02-10', 'Completed'),
(5, 301, 504, '2025-03-01', '2025-03-05', 'Confirmed'),
(6, 303, 505, '2025-02-08', '2025-02-12', 'Completed');


-- Question : Write a query to find customers who had overlapping bookings at different hotels
--            (i.e., bookings with overlapping dates but at different hotels).

-- Solution :

SELECT 
	DISTINCT b2.CustomerID
FROM HotelBookings b1
JOIN HotelBookings b2
ON b1.BookingID != b2.BookingID
AND b1.BookingStatus IN ('Completed', 'Confirmed')
AND b2.BookingStatus IN ('Completed', 'Confirmed')
AND b1.CustomerID = b2.CustomerID
AND b1.HotelID != b2.HotelID
AND b1.CheckInDate <= b2.CheckOutDate
AND b2.CheckInDate <= b1.CheckOutDate;