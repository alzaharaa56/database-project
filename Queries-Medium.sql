
SELECT 
    f.Flight_Number, 
    org.Name AS Origin_Airport, 
    dest.Name AS Destination_Airport
FROM Flight f
JOIN Airport org ON f.Origin_Airport_ID = org.Airport_ID
JOIN Airport dest ON f.Destination_Airport_ID = dest.Airport_ID;


SELECT 
    b.Booking_ID, 
    p.Full_Name, 
    f.Flight_Number
FROM Booking b
JOIN Passenger p ON b.Passenger_ID = p.Passenger_ID
JOIN Flight f ON b.Flight_ID = f.Flight_ID;


SELECT 
    c.Full_Name, 
    c.Role
FROM CrewMember c
JOIN FlightCrew fc ON c.CrewMember_ID = fc.CrewMember_ID
JOIN Flight f ON fc.Flight_ID = f.Flight_ID
WHERE f.Flight_Number = 'WY101';


SELECT 
    f.Flight_Number, 
    a.Model AS Aircraft_Model
FROM Flight f
JOIN Aircraft a ON f.Aircraft_ID = a.Aircraft_ID
WHERE f.Status = 'Completed';


SELECT 
    p.Full_Name, 
    COUNT(b.Booking_ID) AS Total_Bookings
FROM Passenger p
LEFT JOIN Booking b ON p.Passenger_ID = b.Passenger_ID
GROUP BY p.Passenger_ID, p.Full_Name
ORDER BY Total_Bookings DESC;


SELECT 
    Class, 
    SUM(Price_Paid) AS Total_Revenue
FROM Booking
GROUP BY Class;


SELECT 
    a.Registration_Number, 
    a.Model, 
    COUNT(f.Flight_ID) AS Flight_Count
FROM Aircraft a
LEFT JOIN Flight f ON a.Aircraft_ID = f.Aircraft_ID
GROUP BY a.Aircraft_ID, a.Registration_Number, a.Model;

SELECT 
    f.Flight_Number, 
    COUNT(b.Booking_ID) AS Booking_Count
FROM Flight f
JOIN Booking b ON f.Flight_ID = b.Flight_ID
GROUP BY f.Flight_ID, f.Flight_Number
HAVING COUNT(b.Booking_ID) > 1;

SELECT 
    p.Full_Name AS Passenger_Name, 
    f.Flight_Number, 
    org.City AS Origin, 
    dest.City AS Destination, 
    b.Class, 
    b.Price_Paid
FROM Booking b
JOIN Passenger p ON b.Passenger_ID = p.Passenger_ID
JOIN Flight f ON b.Flight_ID = f.Flight_ID
JOIN Airport org ON f.Origin_Airport_ID = org.Airport_ID
JOIN Airport dest ON f.Destination_Airport_ID = dest.Airport_ID;