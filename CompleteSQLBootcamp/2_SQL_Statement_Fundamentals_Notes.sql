/* 13: SELECT DISTINCT. */ 
-- Check how many distinct years are in the table:
SELECT DISTINCT release_year FROM film;

-- Check how many distinct prices are in the table:
SELECT DISTINCT rental_rate FROM film;

------------------------------------------------------------------------------------------------------------------------
/* 15: SELECT WHERE. */ 
-- Where: Filter rows returned in SELECT statement. 
-- Operators: = > < >= <= <> != AND OR. 

-- Find rows where first name and last name match clause: 
SELECT last_name, first_name 
  FROM customer 
 WHERE first_name = 'Jamie' AND last_name = 'Rice'; 

-- Rows where amount is <= 1 or >= 8: 
SELECT customer_id, amount, payment_date 
  FROM payment 
 WHERE amount <= 1 OR amount >= 8; 

-- Rows where store id is 1, and address id is more than 5: 
SELECT * 
  FROM customer 
 WHERE store_id = 1 AND address_id > 5

------------------------------------------------------------------------------------------------------------------------
/* 17: COUNT */
-- Count number of rows where condition is true. 

-- Counting a specific column will NOT count null rows:
SELECT COUNT(*) 
  FROM payment; 

-- Count unique values in a table: 
SELECT COUNT(DISTINCT amount)
  FROM payment; 

------------------------------------------------------------------------------------------------------------------------
/* 18: Limit. */
-- Limit the number of rows returned, does not exist in ORACLE SQL. 

-- Return 5 rows only:
SELECT * 
  FROM customer
 LIMIT 5; 

-- FETCH NEXT Does exist in ORACLE and POSTGRES:
SELECT * 
  FROM film 
 FETCH NEXT 5 ROWS ONLY;

 SELECT * 
  FROM film 
 FETCH FIRST 5 ROWS ONLY;

-- Fetch film ID 6 - 10... 
 SELECT * 
  FROM film 
 ORDER BY film_id  
OFFSET 5 ROWS
 FETCH FIRST 5 ROWS ONLY;

------------------------------------------------------------------------------------------------------------------------
/* 19: Order By. */
-- Sort data by column(s) in ascending or descending order. 
-- In postgres can also sort by columns not returned in the select statement

-- Order by first names Z-A:
SELECT first_name
  FROM customer 
 ORDER BY first_name DESC; 

-- Order By first name A-Z, duplicate first names will be orders by last_name Z-A:
SELECT first_name, last_name
  FROM customer 
 ORDER BY first_name ASC, last_name DESC; 

-- Order by a column not returned: (Can Oracle do this?)
SELECT email
  FROM customer
 ORDER BY last_name DESC; 

------------------------------------------------------------------------------------------------------------------------
/* 21: Between */
-- Match a value against a range of values. 
-- value BETWEEN HIGH AND LOW  == Value >- low AND value <= high; 
-- NOT BETWEEN to check value is not within a range. 

-- Any customer ids who had an amount between 2 values:
SELECT customer_id, amount  
  FROM payment 
 WHERE amount BETWEEN 8.00 AND 9.00
 LIMIT 5; 

-- Any customer ids who had an amount not between the same 2 values:
SELECT customer_id, amount  
  FROM payment 
 WHERE amount NOT BETWEEN 8.00 AND 9.00
 LIMIT 5; 

-- All orders between 2 dates:
SELECT payment_date
  FROM payment 
 WHERE payment_date BETWEEN '2007-02-07' AND '2007-02-15'

------------------------------------------------------------------------------------------------------------------------
/* 22: In */
-- Check when a value matches another value in a given list of values or subquery. 
-- Returns TRUE/FALSE. 
-- Can reverse with NOT. 

-- Find rental information if customer ID is in the list of values: 1, 2:
SELECT rental_id, customer_id, return_date
  FROM rental 
 WHERE customer_id IN (1, 2)
 ORDER BY return_date DESC;

/* Equal to (but much faster than): 
SELECT rental_id, customer_id, return_date
  FROM rental 
 WHERE customer_id = 1
    OR customer_id = 2 
 ORDER BY return_date DESC; */

-- Find rental information if customer ID is not in the list of values: 7, 13, 10:
SELECT rental_id, customer_id, return_date
  FROM rental 
 WHERE customer_id NOT IN (7, 13, 10) 
 ORDER BY return_date DESC;

-- All payments made for 7.99 or 8.99: 
SELECT * 
  FROM payment 
 WHERE amount IN (7.99, 8.99); 

------------------------------------------------------------------------------------------------------------------------
/* 23: Like */
-- String/Substring pattern matching. 
-- % = Wildcard Sequence, _ Single Wildcard Character. 
-- Can inverse with NOT.
-- CASE Sensitive: Postgres has iLike which is not case sensitive, ORACLE SQL does 
-- not have iLike, instead convert to UPPER/LOWER/INITCAP etc before comparing. 

-- Return rows where first name starts with Jen:
SELECT first_name, last_name 
  FROM customer
 WHERE first_name LIKE 'Jen%';

-- Returns rows where name is Jenn and 1 letter after: (Jenny, not Jennie):
SELECT first_name, last_name 
  FROM customer
 WHERE first_name LIKE 'Jenn_';

-- Return rows where name ends in a y:
SELECT first_name, last_name 
  FROM customer
 WHERE first_name LIKE '%y';

-- Return rows where name has 'er' anywhere in the name:
SELECT first_name, last_name 
  FROM customer
 WHERE first_name LIKE '%er%';

-- Names where 'her' are characters 2,3,4. With 1 letter before and any sequence after:
 SELECT first_name, last_name 
  FROM customer
 WHERE first_name LIKE '_her%';

-- Names not like Jen:
SELECT first_name, last_name 
  FROM customer
 WHERE first_name NOT LIKE 'Jen%';

-- ILIKE Example: 
SELECT first_name, last_name 
  FROM customer
 WHERE first_name ILIKE 'BAR%';