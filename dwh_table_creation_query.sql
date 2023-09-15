SET SEARCH_PATH TO dwh;

-- Creating dim_customers table

CREATE TABLE IF NOT EXISTS dim_customers(
	customer_key BIGINT GENERATED ALWAYS AS IDENTITY
	customer_id VARCHAR(50)
	, customer_name VARCHAR(100)
	, phone VARCHAR(50)
	, email VARCHAR(200)
	, date_created TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
	, date_modified TIMESTAMP

);

-- Creating dim_flights table

CREATE TABLE IF NOT EXISTS dim_flights(
	flight_key BIGINT GENERATED ALWAYS AS IDENTITY
	flight_id BIGINT
	, flight_no VARCHAR(20)
	, aircraft_model VARCHAR(50)
	, estimated_time TIME
	, departure_airport VARCHAR(50)
	, departure_city VARCHAR(50)
	, departure_time TIMESTAMP
	, arrival_airport VARCHAR(50)
	, arrival_city VARCHAR(50)
	, arrival_time TIMESTAMP
	, status VARCHAR(50)
	, date_created TIMESTAMP DEFAULT CURRENT_DATE NOT NULL
	, date_modified TIMESTAMP

);



-- Creating fact_tickets table

CREATE TABLE IF NOT EXISTS fact_tickets(
	ticket_key BIGINT GENERATED ALWAYS AS IDENTITY
	, ticket_id VARCHAR(50)
	, customer_id VARCHAR(50)
	, flight_id BIGINT
	, book_date_id INT
	, boarding_no INT
	, boarding_seat VARCHAR(10)
	, boarding_category VARCHAR(30)
	, amount NUMERIC(10,2)
	, f_load_date TIMESTAMP DEFAULT CURRENT_DATE NOT NULL

);
