

SELECT 
    f.Flight_Number, 
    org.City AS Origin, 
    dest.City AS Destination, 
    a.Model AS Aircraft_Model, 
    COUNT(b.Booking_ID) AS Total_Passengers
FROM Flight f
JOIN Airport org ON f.Origin_Airport_ID = org.Airport_ID
JOIN Airport dest ON f.Destination_Airport_ID = dest.Airport_ID
JOIN Aircraft a ON f.Aircraft_ID = a.Aircraft_ID
LEFT JOIN Booking b ON f.Flight_ID = b.Flight_ID
GROUP BY f.Flight_ID, f.Flight_Number, org.City, dest.City, a.Model;

-- 2. List all passengers who have never made a booking.
SELECT Full_Name, Email
FROM Passenger
WHERE Passenger_ID NOT IN (SELECT Passenger_ID FROM Booking);

-- 3. Total revenue per flight exceeding 500, ordered from highest to lowest.
SELECT f.Flight_Number, SUM(b.Price_Paid) AS Total_Revenue
FROM Flight f
JOIN Booking b ON f.Flight_ID = b.Flight_ID
GROUP BY f.Flight_ID, f.Flight_Number
HAVING SUM(b.Price_Paid) > 500
ORDER BY Total_Revenue DESC;

-- 4. Crew members assigned to more than one flight.
SELECT c.Full_Name, COUNT(fc.Flight_ID) AS Assigned_Flights
FROM CrewMember c
JOIN FlightCrew fc ON c.CrewMember_ID = fc.CrewMember_ID
GROUP BY c.CrewMember_ID, c.Full_Name
HAVING COUNT(fc.Flight_ID) > 1;

-- 5. Flights where the average price is above the overall average price.
SELECT f.Flight_Number, AVG(b.Price_Paid) AS Avg_Flight_Price
FROM Flight f
JOIN Booking b ON f.Flight_ID = b.Flight_ID
GROUP BY f.Flight_ID, f.Flight_Number
HAVING AVG(b.Price_Paid) > (SELECT AVG(Price_Paid) FROM Booking);

-- 6. The flight with the highest number of bookings.
SELECT TOP 1 
    f.Flight_Number, 
    org.City AS Origin, 
    dest.City AS Destination, 
    COUNT(b.Booking_ID) AS Total_Bookings
FROM Flight f
JOIN Airport org ON f.Origin_Airport_ID = org.Airport_ID
JOIN Airport dest ON f.Destination_Airport_ID = dest.Airport_ID
JOIN Booking b ON f.Flight_ID = b.Flight_ID
GROUP BY f.Flight_ID, f.Flight_Number, org.City, dest.City
ORDER BY Total_Bookings DESC;

-- 9. Flights with at least one pilot and one flight attendant.
SELECT f.Flight_Number, COUNT(fc.CrewMember_ID) AS Total_Crew, f.Departure_DateTime
FROM Flight f
JOIN FlightCrew fc ON f.Flight_ID = fc.Flight_ID
JOIN CrewMember c ON fc.CrewMember_ID = c.CrewMember_ID
WHERE c.Role IN ('Pilot', 'Flight Attendant')
GROUP BY f.Flight_ID, f.Flight_Number, f.Departure_DateTime
HAVING 
    COUNT(CASE WHEN c.Role = 'Pilot' THEN 1 END) >= 1 AND 
    COUNT(CASE WHEN c.Role = 'Flight Attendant' THEN 1 END) >= 1;

-- 10. FINAL CHALLENGE: Complete Flight Summary
SELECT 
    f.Flight_Number, 
    org.City AS Origin_City, 
    dest.City AS Destination_City, 
    a.Model, 
    a.Manufacturer,
    COUNT(DISTINCT b.Booking_ID) AS Total_Passengers,
    COUNT(DISTINCT fc.CrewMember_ID) AS Total_Crew,
    ISNULL(SUM(b.Price_Paid), 0) AS Total_Revenue
FROM Flight f
JOIN Airport org ON f.Origin_Airport_ID = org.Airport_ID
JOIN Airport dest ON f.Destination_Airport_ID = dest.Airport_ID
JOIN Aircraft a ON f.Aircraft_ID = a.Aircraft_ID
LEFT JOIN Booking b ON f.Flight_ID = b.Flight_ID
LEFT JOIN FlightCrew fc ON f.Flight_ID = fc.Flight_ID
GROUP BY f.Flight_Number, org.City, dest.City, a.Model, a.Manufacturer
ORDER BY Total_Revenue DESC;



CREATE INDEX idx_flight_status ON Flight(Status);


CREATE UNIQUE INDEX idx_passenger_nid ON Passenger(National_ID);


CREATE INDEX idx_flight_route ON Flight(Origin_Airport_ID, Destination_Airport_ID);


CREATE INDEX idx_booking_price ON Booking(Price_Paid);

