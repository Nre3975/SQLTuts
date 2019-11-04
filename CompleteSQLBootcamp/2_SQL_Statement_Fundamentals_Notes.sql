/* 13: SELECT DISTINCT. */ 

-- Check how many distinct years are in the table. 
SELECT DISTINCT release_year FROM film;

-- Check how many distinct prices are in the table. 
SELECT DISTINCT rental_rate FROM film;

---------------------------------------------------------------------------
/* 15: SELECT WHERE. */ 
-- Where: Filter rows returned in SELECT statement. 
-- Operators: = > < >= <= <> != AND OR. 

SELECT last_name, first_name 
  FROM customer 
 WHERE first_name = 'Jamie' AND last_name = 'Rice'; 

SELECT customer_id, amount, payment_date 
  FROM payment 
 WHERE amount <= 1 OR amount >= 8; 

SELECT * 
  FROM customer 
 WHERE store_id = 1 AND address_id > 5

---------------------------------------------------------------------------
/* 17: COUNT */
-- Count number of rows where condition is true. 
-- Counting a specific column will NOT count null rows. 
SELECT COUNT(*) 
  FROM payment; 

-- Count unique values in a table: 
SELECT COUNT(DISTINCT amount)
  FROM payment; 

---------------------------------------------------------------------------
/* 18: Limit. */
-- Limit the number of rows returned, does not exist in ORACLE SQL. 
SELECT * 
  FROM customer
 LIMIT 5; 

-- FETCH NEXT Does exist in ORACLE and POSTGRES
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


/* 19: Order By. */
-- Sort data by column(s) in ascending or descending order. 
-- In postgres can also sort by columns not returned in the select statement

SELECT first_name
  FROM customer 
 ORDER BY first_name DESC; 

SELECT first_name, last_name
  FROM customer 
 ORDER BY first_name ASC, last_name DESC; 

SELECT email
  FROM customer
 ORDER BY last_name DESC; 

 