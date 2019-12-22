/* 2.12: Challenge: SELECT Task. */
--1) Select name and email from customer: 
SELECT first_name, last_name, email
  FROM customer; 

------------------------------------------------------------------------------------------------------------------------
/* 2.14: Challenge: SELECT DISTINCT. */

--1) Check how many distinct years are in the table:
SELECT DISTINCT rating 
  FROM film; 

------------------------------------------------------------------------------------------------------------------------
/* 2.16: Challenge: SELECT WHERE. */

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
 
------------------------------------------------------------------------------------------------------------------------
/* 2.20: Challenge: ORDER BY.  */

-- 1) Customer IDs for top 10 payment amounts:
SELECT * 
  FROM payment 
 ORDER BY amount DESC
 FETCH FIRST 10 ROWS ONLY; 

SELECT * 
  FROM payment 
 ORDER BY amount DESC
 LIMIT 10;

-- 2) Titles of the movies with film IDs 1-5:
SELECT film_id 
  FROM film 
 FETCH FIRST 5 ROWS ONLY;

SELECT film_id 
  FROM film 
 ORDER BY film_id 
 LIMIT 5; 
------------------------------------------------------------------------------------------------------------------------
/* 2.24: General Challenge 1. */

-- 1) How many payment transactions were greater than $5.00? 
SELECT COUNT(amount) 
  FROM payment 
 WHERE amount > 5;

-- 2) How many actors have a first name that starts with the letter P? 
SELECT COUNT(first_name)
  FROM actor 
 WHERE first_name LIKE 'P%';

-- 3) How many unique districts are our customers from?
SELECT COUNT( DISTINCT DISTRICT ) 
  FROM ADDRESS;

-- 4) Retieve the list of names for those distinct districts. 
SELECT DISTINCT DISTRICT
  FROM ADDRESS;

-- 5) How many films have a rating of R and a replacement cost between $5 and $15?
SELECT COUNT(*) 
  FROM FILM 
 WHERE rating = 'R'
   AND replacement_cost BETWEEN 5.00 and 15.00;

-- 6) How many films have the word Truman somewhere in the title? 
SELECT COUNT(*) 
  FROM film 
 WHERE title ilike '%truman%';