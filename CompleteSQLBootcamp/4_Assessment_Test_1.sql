/* 32: Assessment Test 1. */ 

--1) Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
SELECT CUSTOMER_ID, SUM(AMOUNT) AS TOTAL_SPENT
  FROM payment
 WHERE STAFF_ID = 2
 GROUP BY CUSTOMER_ID
HAVING SUM(AMOUNT) > 110; 

---------------------------------------------------------------------------
--2) How many films begin with the letter J?
SELECT COUNT(*)
  FROM film
 WHERE title like 'J%';

---------------------------------------------------------------------------
--3 What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
SELECT first_name, last_name
  FROM customer
 WHERE first_name LIKE 'E%'
   AND address_id < 500
 ORDER BY CUSTOMER_ID DESC 
 LIMIT 1;