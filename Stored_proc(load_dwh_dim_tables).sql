CREATE OR REPLACE PROCEDURE dwh_upsert_dim_table_proc()

LANGUAGE plpgsql

AS 
$$

BEGIN 

-- loading dwh.dim_customers

ALTER TABLE dwh.dim_customers
ADD CONSTRAINT unique_customer_id UNIQUE (customer_id);

INSERT INTO dwh.dim_customers (
    customer_id,
    customer_name,
    phone,
    email
)
SELECT
    customer_id,
    customer_name,
    phone,
    email
FROM stg.dim_customers
ON CONFLICT (customer_id) 
DO UPDATE SET 
    customer_name = EXCLUDED.customer_name,
    phone = EXCLUDED.phone,
    email = EXCLUDED.email;


-- loading dwh.dim_flights

ALTER TABLE dwh.dim_flights
ADD CONSTRAINT uniqu_flight_id UNIQUE (flight_id);

INSERT INTO dwh.dim_flights(
    flight_id 
	, flight_no
	, aircraft_model
	, estimated_time
	, departure_airport
	, departure_city
	, departure_time
	, arrival_airport
	, arrival_city
	, arrival_time
	, status
)
SELECT 
    flight_id 
	, flight_no
	, aircraft_model
	, estimated_time
	, departure_airport
	, departure_city
	, departure_time
	, arrival_airport
	, arrival_city
	, arrival_time
    , status
FROM stg.dim_flights
ON CONFLICT (flight_id)
DO UPDATE SET 
    , flight_no = EXCLUDED.flight_no
	, aircraft_model = EXCLUDED.aircraft_model
	, estimated_time = EXCLUDED.estimated_time
	, departure_airport = EXCLUDED.departure_airport
	, departure_city = EXCLUDED.departure_city
	, departure_time = EXCLUDED.departure_time
	, arrival_airport = EXCLUDED.arrival_airport
	, arrival_city = EXCLUDED.arrival_city
	, arrival_time = EXCLUDED.arrival_time
    , status = EXCLUDED.status;


RAISE NOTICE 'dimension tables data inserted successfully';

END $$;

CALL dwh_upsert_dim_table_proc()