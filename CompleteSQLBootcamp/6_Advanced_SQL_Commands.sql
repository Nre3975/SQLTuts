/* 43: Timestamps and Extract */ 
-- PostgreSQL can extract parts from a date: 
-- Arithmetic can also be used on dates (Date + 7 for 7 days in the future etc). 
extract (unit_from_date); 

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

----------------------------------------------------------------------------------------------------------
/* 47: Self Join. */ 
-- Join a table to itself. 
-- Combine rows with other rows from the same table
-- Use table alias to distinguish between the two versions of the table. 

/* Example Table: Which emploees are from the same location as Joe.
Employee_Name  |  Employee_location 
Joe            |  New York
Sunil          |  India
Alex           |  Russia
Albert         |  Canada
Jack           |  New York
*/

-- Create table:
CREATE TABLE employee (
	employee_name VARCHAR(100),
	employee_location VARCHAR(100)
);

INSERT INTO employee VALUES('Joe', 'New York');
INSERT INTO employee VALUES('Sunil', 'India');
INSERT INTO employee VALUES('Alex', 'Russia');
INSERT INTO employee VALUES('Albert', 'Canada');
INSERT INTO employee VALUES('Jack', 'New York');

SELECT * FROM employee;

--NB: Easier ways to do this, but using as example: 
-- SubQuery Method.
SELECT employee_name 
  FROM employee 
 WHERE employee_location IN (SELECT employee_location
							    FROM employee 
							   WHERE employee_name = 'Joe');

-- Self Join (More Efficient)
SELECT e1.employee_name 
  FROM employee AS e1, employee AS e2 
 WHERE e1.employee_location = e2.employee_location 
   AND e2.employee_name = 'Joe';

-- Doesn't need join syntax. 
-- More efficient than a subquery. 

-- Will create 2 versions of the table, E1, and E2. 
-- Query result looks like:
/*
e1.employee_name | e1.employee_location | e2.employee_name | e2.employee_location    
Joe              | New York             |	Joe              | New York
Jack             | New York             | Joe              | New York
*/

-- Customer Table Example: 
-- Find all customers who have a last_name matching another customers first name: 
SELECT c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name 
  FROM customer AS c1, customer AS c2 
 WHERE c1.first_name = c2.last_name;

-- With Join Syntax: 
SELECT c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name 
  FROM customer AS c1 
  JOIN customer AS c2 ON c1.first_name = c2.last_name;

-- Can also use left outer joins if needed, would be useless here...Would show people who 
-- don't have a matching first name as a C2 last name.  
SELECT c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name 
  FROM customer AS c1 
  LEFT JOIN customer AS c2 ON c1.first_name = c2.last_name