SET SEARCH_PATH TO src;

-- Creating & loading the tables into the source schema

-- Loading tickets table
DROP TABLE IF EXISTS src.tickets;
	
SELECT *
INTO src.tickets
FROM bookings.tickets;

-- Loading ticket_flights table
DROP TABLE IF EXISTS src.ticket_flights;

SELECT *
INTO src.ticket_flights
FROM bookings.ticket_flights;

-- Loading flights table
DROP TABLE IF EXISTS src.flights;

SELECT *
INTO src.flights
FROM bookings.flights;

-- Loading bookings table
DROP TABLE IF EXISTS src.bookings;

SELECT *
INTO src.bookings
FROM bookings.bookings;

-- Loading boarding_passes table
DROP TABLE IF EXISTS src.boarding_passes;

SELECT *
INTO src.boarding_passes
FROM bookings.boarding_passes;

-- Loading airports_data table
DROP TABLE IF EXISTS src.airports_data;

SELECT *
INTO src.airports_data
FROM bookings.airports_data;

-- Loading aircraft_data table
DROP TABLE IF EXISTS src.aircrafts_data;

SELECT *
INTO src.aircrafts_data
FROM bookings.aircrafts_data;	
