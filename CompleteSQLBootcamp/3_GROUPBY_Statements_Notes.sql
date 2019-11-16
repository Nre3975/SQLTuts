/* 25: Min, Max, Sum, AVG. (And Count) */ 
-- Aggregate functions: Aggregate 1+ Rows of data into 1 

-- Minimum value in amount column. 
SELECT min(amount) 
  FROM payment;
 
 -- Maximum value in amount column. 
SELECT max(amount) 
  FROM payment;
 
 -- Total value in amount column. 
SELECT sum(amount) 
  FROM payment;

-- Average value in amount column. 
SELECT AVG(amount) 
  FROM payment;

-- Round average to 2 decimal points. 
SELECT ROUND(AVG(amount), 2)
  FROM payment;

-- Number of rows in payment column 
SELECT COUNT(amount)
  FROM payment;

---------------------------------------------------------------------------
/* 26: GROUP BY */
-- Divides rows returned by SELECT statement into groups. 
-- For each group can apply an aggregate functions for that group. 
-- Postgres more lenient than other DBMS and allows grouping by 
-- columns not returned. 

-- Group rows by the unique customer_id (Same as distinct customer_id) 
SELECT customer_id
  FROM payment
 GROUP BY customer_id; 

-- Get total amount spent by each person. 
SELECT customer_id, sum(amount) 
  FROM payment 
 GROUP BY customer_id;

 -- Order this by total spend. 
 SELECT customer_id, sum(amount) 
  FROM payment 
 GROUP BY customer_id 
 ORDER BY sum(amount) DESC;

-- How much has each staff member processed, and how many orders? 
SELECT staff_id, count(staff_id) AS "Orders_Processed", 
       sum(amount) AS "Total Processed"
  FROM payment
 GROUP BY staff_id
 ORDER BY count(staff_id);

-- How many films of each rating type are there 
SELECT rating, count(rating)
  FROM film 
 GROUP BY rating 
 ORDER BY count(rating) DESC;

-- How many films of each rental duration are there? 
SELECT rental_duration, count(rental_duration )
  FROM film 
 GROUP BY rental_duration 
 ORDER BY count(rental_duration) DESC; 

-- Average rental rate per movie rating. 
SELECT rating, round(avg(rental_rate) , 3) 
  FROM film
 GROUP BY Rating; 

 ---------------------------------------------------------------------------
 /* 26: HAVING */
 -- Filters grouped rows which satisfy condition. 
 -- Occurs AFTER rows have been grouped. (Where clause happens before rows are grouped)
 -- WHERE for GROUPBYs. 

-- Find customers who have spent more than 200 dollers. 
SELECT customer_id, SUM(amount) 
  FROM payment 
 GROUP BY customer_id 
HAVING sum(amount) > 200

-- Stores which have more than X customers per store. 
SELECT store_id, COUNT(customer_id)
  FROM customer 
 GROUP BY store_id
HAVING COUNT(customer_id) > 300 

-- Break down movie rating by average rental rate, only show ones where AVG is under 3
SELECT rating, AVG(rental_rate)
  FROM film
 WHERE rating in ('R', 'G', 'PG')
GROUP BY rating
HAVING AVG(rental_rate < 3)