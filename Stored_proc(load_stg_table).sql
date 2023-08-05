SET SEARCH_PATH TO stg;

CREATE OR REPLACE PROCEDURE stg_load_tables_proc()

LANGUAGE plpgsql
AS 
$$

BEGIN

-- Truncate and load into dim_customers
TRUNCATE TABLE stg.dim_customers;
INSERT INTO stg.dim_customers
SELECT passenger_id AS customer_id
	   , LOWER(passenger_name) AS customer_name
	   , contact_data::JSONB ->> 'phone' AS phone
	   , contact_data::JSONB ->> 'email' AS email
	   , NOW() AS load_date
FROM src.tickets;

-- Truncate and load into dim_flights
TRUNCATE TABLE stg.dim_flights;
INSERT INTO stg.dim_flights
SELECT flight_id 
	   , flight_no
	   , model::JSONB ->> 'en' AS aircraft_model
	   , scheduled_arrival - scheduled_departure AS estimated_time
	   , ar.airport_name::JSONB ->> 'en' AS departure_airport
	   , ar.city::JSONB ->> 'en' AS departure_city
	   , actual_departure AS departure_time
	   , ar2.airport_name::JSONB ->> 'en' AS arrival_airport
	   , ar2.city::JSONB ->> 'en' AS arrival_city
	   , actual_arrival AS arrival_time
	   , status
	   , NOW() load_date
FROM src.flights f
LEFT JOIN src.aircrafts_data  ac USING(aircraft_code)
LEFT JOIN src.airports_data ar ON ar.airport_code = f.departure_airport
LEFT JOIN src.airports_data ar2 ON ar2.airport_code = f.arrival_airport
ORDER BY flight_id;

-- Truncate and load into facts_tickets
TRUNCATE TABLE stg.fact_tickets;
INSERT INTO stg.fact_tickets
SELECT ticket_no AS ticket_id
	   , passenger_id AS customer_id
	   , tf.flight_id
	   , TO_CHAR(book_date::DATE, 'YYYYMMDD' )::INT AS book_date_id
	   , boarding_no
	   , seat_no AS boarding_seat
	   , fare_conditions AS boarding_category
	   , amount
	   , NOW() load_date
FROM src.tickets t
LEFT JOIN src.ticket_flights tf
USING(ticket_no)
LEFT JOIN src.bookings b
USING(book_ref)
LEFT JOIN src.boarding_passes bp
USING(ticket_no)
ORDER BY ticket_no;


RAISE NOTICE 'Tables truncated and new data loaded successfully';

END $$;





CALL stg_load_tables_proc();




 




