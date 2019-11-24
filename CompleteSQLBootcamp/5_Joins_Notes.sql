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

-- Inner Join: Returns rows in Table A that have corresponding rows in Table B.. 

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

