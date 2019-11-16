/* 3.27: Challenge: SELECT Task. */

--1) How many payments did each staff memeber handle? What was the total amount processed by each
SELECT P.STAFF_ID, S.FIRST_NAME || ' ' || S.LAST_NAME AS NAME, COUNT(P.AMOUNT) AS PAYMENTS_HANDLED, SUM(P.AMOUNT) TOTAL_AMOUNT
  FROM PAYMENT P, STAFF S
 WHERE p.staff_id = S.staff_id
 GROUP BY P.STAFF_ID,  S.FIRST_NAME || ' ' || S.LAST_NAME; 
 
 --2) What is the average replacement cost of a movie broken down by rating? 
 SELECT rating, ROUND(AVG(replacement_cost), 2)
  FROM film
 GROUP BY rating; 

--3) What are the customer ID's of the top 5 spenders? 
SELECT p.customer_id, c.first_name || ' ' || c.last_name AS NAME, SUM(amount) AS TOTAL
  FROM payment P, customer C 
 WHERE p.customer_id = c.customer_id 
 GROUP BY p.customer_id, c.first_name || ' ' || c.last_name
 ORDER BY sum(amount) DESC
 FETCH NEXT 5 ROWS ONLY; 