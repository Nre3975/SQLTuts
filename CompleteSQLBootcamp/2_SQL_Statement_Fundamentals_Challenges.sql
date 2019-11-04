--  2.12: Challenge: SELECT Task. 

SELECT first_name, last_name, email
  FROM customer; 

---------------------------------------------------------------------------
-- 2.14: Challenge: SELECT DISTINCT. 

-- Check how many distinct years are in the table. 
SELECT DISTINCT rating 
  FROM film; 

---------------------------------------------------------------------------
-- 2.16: Challenge: SELECT WHERE. 

-- 1) What's the email for customer with name Nancy Thomas?
SELECT email 
  FROM customer 
 WHERE first_name = 'Nancy' 
   AND last_name = 'Thomas'

-- 2) What is the description for the movie: 'Outlaw Hanky'?
SELECT description 
  FROM film 
 WHERE title = 'Outlaw Hanky'

-- 3) What is the phone number for person living at 259 Ipoh Drive? 
SELECT phone 
  FROM address
 WHERE address = '259 Ipoh Drive'
 
---------------------------------------------------------------------------
-- 2.20: Challenge: ORDER BY. 

-- 1) Customer IDs for top 10 payment amounts. 
SELECT * 
  FROM payment 
 ORDER BY amount DESC
 FETCH FIRST 10 ROWS ONLY; 

SELECT * 
  FROM payment 
 ORDER BY amount DESC
 LIMIT 10;

-- 2) Titles of the movies with film IDs 1-5 
SELECT film_id 
  FROM film 
 FETCH FIRST 5 ROWS ONLY;

SELECT film_id 
  FROM film 
 ORDER BY film_id 
 LIMIT 5; 
---------------------------------------------------------------------------
-- 2.24: General Challenge 1. 