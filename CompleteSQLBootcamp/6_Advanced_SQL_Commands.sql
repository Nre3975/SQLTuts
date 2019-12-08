/* 42: Overview of Advanced SQL Commands. */ 
-- Mathematical Functions
-- Timestamps & Extract Function. 
-- String Functions / Operators. 
-- SubQuery. 
-- Self Join. 

----------------------------------------------------------------------------------------------------------
/* 43: Timestamps and Extract */ 
-- PostgreSQL can extract parts from a date: 
-- Arithmetic can also be used on dates (Date + 7 for 7 days in the future etc). 
extract (unit_from_date); 

/* Extractable types: 
Day: Day of monty (1 - 31) 
dow: Day of week (0 = Sunday, 1 = Monday etc. )
doy: Day of Year (1 = 1st Jan, 365/366 = 31s Dec)
epoch: Number of seconds since 1970-01-01 00:00:00 / Number of seconds in an interval. 
hour: Hour (0 - 23) 
microseconds: Seconds * 1,000,000
millennium: Millenium Value
Milliseconds: Seconds * 1,000
Minute: Minute (0, 59)
Month: Month Number (1 - 12) / Number of months if interval. 
Quarter: Quater (1 - 4)
Second: Seconds / Fractional Seconds. 
Week: Number of the week based on ISO 8601. 
Year: Year as 4 digits. 
https://www.postgresql.org/docs/9.1/functions-datetime.html */ 

-- Other functions: (Like in Oracle, but without FROM dual;)
select age(timestamp, timestamp) -- Age between two times. 
select age(timestamp) -- Age since current date. 
select clock_timestamp() -- Current time. 
select current_date -- current date. 

-- Back to Extract: 
SELECT payment_date FROM payment; -- Returns: Strings like: "2007-02-15 22:25:46.996577"
SELECT extract(day from payment_date) FROM payment; -- Returns info extracted from above: 15

-- What days do customers shop on: 
SELECT customer_id, extract(day from payment_date) AS day
  FROM payment; 

-- Which month grossed the most cash. 
SELECT SUM(amount) AS total, EXTRACT(month FROM payment_date) AS month
  FROM payment
 GROUP BY month
 ORDER BY total DESC;

----------------------------------------------------------------------------------------------------------
/* 44: Mathematical Functions */ 
-- https://www.postgresql.org/docs/9.1/functions-math.html

-- Operators: Create new ID based on cust_id and rental_id
SELECT customer_id + rental_id AS new_id FROM payment;
SELECT customer_id * rental_id AS new_id FROM payment;
SELECT rental_id / customer_id AS new_id FROM payment;

-- Functions. Average value from the amount column. 
SELECT round(avg(amount), 2)
  FROM payment

----------------------------------------------------------------------------------------------------------
/* 45: String Functions and Operators. */ 
-- https://www.postgresql.org/docs/9.1/functions-string.html

-- String concatenation. 
SELECT first_name || ' ' || last_name AS name FROM customer; 

-- See how many characters a name has. 
SELECT first_name, char_length(first_name) 
  FROM customer;

-- String Case: 
SELECT UPPER(first_name)
  FROM customer;

----------------------------------------------------------------------------------------------------------
/* 46: SubQuery. */ 
-- A query nested inside another query within brackets. 
-- Subqueries are executed first in SQL Engine. 

-- Example 1: Want to find films whose rental rate is higher than average rental rate. 
-- Step 1: Find average rental rate, Step 2: Use this to find films higher than it. 
SELECT * 
  FROM film 
 WHERE rental_rate > (SELECT avg(rental_rate) FROM film);

-- If SubQuery returns multiple rows, use the IN operator. 
SELECT film_id, title 
  FROM film
 WHERE film_id IN (-- List of Film ID's returned between 29th and 30th May 2005. 
					SELECT i.film_id 
  					  FROM rental r 
 					 INNER JOIN inventory i ON r.inventory_id = i.inventory_id
 					 WHERE r.return_date BETWEEN '2005-05-29' AND '2005-05-30')