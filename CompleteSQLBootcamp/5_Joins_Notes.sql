/* 35: AS Statement. */ 
-- Create an Alias for a column / table selection etc. 
SELECT payment_id AS "my_payment_column"
  FROM payment;

SELECT customer_id, SUM(amount) AS "Total_Spent"
  FROM payment 
 GROUP BY customer_id; 

------------------------------------------------------------------------------------
/* 36: Overview of Inner Join  */ 
-- Relate table in one table, to data in another tables. 
-- Can link from a FK in one table to a PK in another table. (But not required)

SELECT a.pka, a.columnname1, b.fka, b.columnname 
  FROM a -- Main Table. 
 INNER JOIN B on a.pka = b.fka; --Table joining to it, and condition. 

-- DBMS: For each row in Table A, see if a row in Table B matches condition. 

-- Inner Join: Returns rows in Table A that have corresponding rows in Table B.
-- Using ANSI standard Inner Join can be expressed as just JOIN. 

-- Example: Join customer and payment tables. (Ansii Join Style)
SELECT c.customer_id, c.first_name, c.last_name, c.email,
		p.payment_date 
  FROM customer c
 INNER JOIN payment p ON c.customer_id = p.customer_id;

-- Same join as above, done old style (Oracle style)
 SELECT c.customer_id, c.first_name, c.last_name, c.email,
		p.payment_date 
  FROM customer c, payment p
 WHERE c.customer_id = p.customer_id;

-- including Order By: 
SELECT c.customer_id, c.first_name, c.last_name, c.email,
		p.payment_date 
  FROM customer c
 INNER JOIN payment p ON c.customer_id = p.customer_id
 ORDER BY c.customer_id;
 
 -- Filter Results
 SELECT c.customer_id, c.first_name, c.last_name, c.email,
		p.payment_date 
  FROM customer c
 INNER JOIN payment p ON c.customer_id = p.customer_id
 WHERE c.customer_id = 2;

------------------------------------------------------------------------------------
/* 37: Examples of Inner Join  */ 
-- ANSI Join
SELECT p.payment_id, p.amount, 
		s.first_name, s.last_name 
  FROM payment p 
 INNER JOIN staff s ON p.staff_id = s.staff_id;
 
 -- Non-Ansi Join
SELECT p.payment_id, p.amount, 
		s.first_name, s.last_name 
  FROM payment p, staff s
 WHERE p.staff_id = s.staff_id; 

-- How many titles of each film are at store 1: 
-- ANSI Join
SELECT f.title, COUNT(f.title) AS "Copies_At_Store"
  FROM inventory i
 INNER JOIN film f ON i.film_id = f.film_id
 WHERE store_id = 1
 GROUP BY f.title
 ORDER BY f.title;
 
-- Non-Ansi Join
SELECT f.title, COUNT(f.title) AS "Copies_At_Store"
  FROM inventory i, film f 
 WHERE i.film_id = f.film_id
   AND store_id = 1
 GROUP BY f.title
 ORDER BY f.title;

-- Languages attached to the films: 
-- ANSI Join
SELECT f.title, l.name AS movie_language
  FROM film f
 INNER JOIN language l ON f.language_id  = l.language_id;
 
-- Non-ANSI Join
SELECT f.title, l.name AS movie_language
  FROM film f, language l
 WHERE f.language_id  = l.language_id;


