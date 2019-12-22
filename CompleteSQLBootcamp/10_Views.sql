/* 69: Views */ 
-- View: Database object of a stored query. 
-- Logical table representing data of one+ underlying tables through select statement. 

-- Shows view of a select query, 
-- Does not store data physically. 

-- Simplifies complexity of query, by querying the view instead of the query. 
-- Can grant permissions to users to provide security. 

-- Syntax: 
CREATE VIEW view_name AS 
QUERY; 

-- Join Customer and address in a view. 
CREATE VIEW customer_info AS 
SELECT first_name, last_name, email, address, phone 
  FROM customer
  JOIN address ON customer.address_id = address.address_id;
 
-- Use Customer_info view instead to get the information. 
SELECT * FROM customer_info;

--Rename view: 
ALTER VIEW customer_info RENAME TO customer_address;
SELECT * FROM customer_address;

-- Delete View: 
DROP VIEW IF EXISTS customer_address;
