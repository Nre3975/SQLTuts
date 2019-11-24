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

------------------------------------------------------------------------------------
/* 38: Overview Of Join Types  */ 

/*  Table A                 Table B 
    ID | NAME               ID | NAME 
    1  | Pirate             1  | Rutabaga 
    2  | Monkey             2  | Pirate  
    3  | Ninja              3  | Darth Vader
    4  | Spaghetti          4  | Ninja 
*/ 

-- Inner join:
-- Returns only records which show in both table A and table B. 
SELECT * 
  FROM TableA 
 INNER JOIN TableB ON TableA.name = TableB.name; 

/*
1  | Pirate             2  | Pirate
3  | Ninja              4  | Ninja
*/ 

-- Full Outer Join. 
-- Returns set of all records in A and B with matching records from both sides 
-- where available. If no match, missing side will contain a null. 
SELECT * 
  FROM TableA
  FULL OUTER JOIN TableB ON TableA.name = TableB.name;

/*
1    | Pirate             2    | Pirate
2    | Monkey             NULL | NULL
3    | Ninja              4    | Ninja
4    | Spaghetti          NULL | NULL
NULL | NULL               1    | Rutabaga 
NULL | NULL               3    | Darth Vader
*/ 

-- Left Outer Join 
-- Returns all records from table A, with the matching records if available from 
-- Table B, If nothing available in Table B, returns NULL.
-- Doesn't bring back anything in Table B not in Table A. 
SELECT * 
  FROM TableA
  LEFT OUTER JOIN TableB ON TableA.name = TableB.name;

/*
1    | Pirate             2    | Pirate
2    | Monkey             NULL | NULL
3    | Ninja              4    | Ninja
4    | Spaghetti          NULL | NULL
*/

-- Right Outer Join. 
-- Same as Left Outer Join but reversed. 
SELECT * 
  FROM TableA
 RIGHT OUTER JOIN TableB ON TableA.name = TableB.name;

/*
NULL | NULL               1    | Rutabaga 
1    | Pirate             2    | Pirate
NULL | NULL               3    | Darth Vader
3    | Ninja              4    | Ninja
*/ 

--Left Outer Join with NULL WHERE. 
--Return records in Table A which are not in Table B. 
--Can be reversed using RIGHT instead of LEFT. 
SELECT * 
  FROM TableA
  LEFT OUTER JOIN TableB ON TableA.name = TableB.name
 WHERE TableB.ID IS NULL;

/*
2    | Monkey             NULL | NULL
4    | Spaghetti          NULL | NULL
*/

--FULL Outer join with NULL WHERE clause. 
--RETURN results unique to Table A or Table B, ignore any in both. 
SELECT * 
  FROM TableA 
  FULL OUTER JOIN TableB on TableA.name = TableB.name 
 WHERE TableA.ID IS NULL OR TableB.ID IS NULL OR 

 /*
2    | Monkey             NULL | NULL
4    | Spaghetti          NULL | NULL
NULL | NULL               1    | Rutabaga 
NULL | NULL               3    | Darth Vader
*/ 
