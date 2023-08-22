SET SEARCH_PATH TO src;

CREATE OR REPLACE PROCEDURE src_load_src_tables
	()
LANGUAGE plpgsql
AS 
$$

BEGIN

-- 	Trucate & load aircrafts_data
	TRUNCATE TABLE src.aircrafts_data;
	INSERT INTO src.aircrafts_data
	SELECT *
	FROM bookings.aircrafts_data;
	
-- 	Trucate & load airports_data
	TRUNCATE TABLE src.airports_data;
	INSERT INTO src.airports_data
	SELECT *
	FROM bookings.airports_data;
	
-- 	Trucate & load boarding_passes
	TRUNCATE TABLE src.boarding_passes;
	INSERT INTO src.boarding_passes
	SELECT *
	FROM bookings.boarding_passes;

-- 	Trucate & load bookings
	TRUNCATE TABLE src.bookings;
	INSERT INTO src.bookings
	SELECT *
	FROM bookings.bookings;

-- 	Trucate & load flights
	TRUNCATE TABLE src.flights;
	INSERT INTO src.flights
	SELECT *
	FROM bookings.flights;

-- 	Trucate & load ticket_flights
	TRUNCATE TABLE src.ticket_flights;
	INSERT INTO src.ticket_flights
	SELECT *
	FROM bookings.ticket_flights;

-- 	Trucate & load tickets
	TRUNCATE TABLE src.tickets;
	INSERT INTO src.tickets
	SELECT *
	FROM bookings.tickets;
	
		
	RAISE NOTICE 'Table truncated and new data loaded successfully';
	
END;

$$




CALL src_load_src_tables();