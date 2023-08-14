CREATE OR REPLACE PROCEDURE dwh_insert_facts_table_proc()

LANGUAGE plpgsql

AS 
$$

BEGIN 

INSERT INTO dwh.fact_tickets(
	ticket_id 
	, customer_key 
	, flight_key
	, book_date_id 
	, boarding_no
	, boarding_seat 
	, boarding_category
	, amount 
)
SELECT t.ticket_id 
	, c.customer_key 
	, f.flight_key
	, t.book_date_id 
	, t.boarding_no
	, t.boarding_seat 
	, t.boarding_category
	, t.amount 
FROM stg.fact_tickets t
LEFT JOIN dwh.dim_customers c ON c.customer_id = t.customer_id
LEFT JOIN dwh.dim_flights f ON f.flight_id = t.flight_id;

RAISE NOTICE 'Facts tables data inserted successfully';

END $$;

CALL dwh_insert_facts_table_proc()