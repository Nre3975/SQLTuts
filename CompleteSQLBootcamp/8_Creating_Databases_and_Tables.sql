/* 53: Primary Keys and Foreign Keys. */ 
 -- Add primary table when defining the tables structure. 

 CREATE TABLE table_name (
     column_name1 data_type PRIMARY KEY, 
     column_name2 data_type
     column_name3 data_type
 );
 
------------------------------------------------------------------------------------------------------------------------
/* 54: Resource for Create Table Code */ 
-- Code used in Lecture 56. 

CREATE TABLE account(
    user_id     serial          PRIMARY KEY,
    username    VARCHAR (50)    UNIQUE NOT NULL,
    password    VARCHAR (50)    NOT NULL,
    email       VARCHAR (355)   UNIQUE NOT NULL,
    created_on  TIMESTAMP       NOT NULL,
    last_login  TIMESTAMP
);

CREATE TABLE role(
    role_id     serial          PRIMARY KEY,
    role_name   VARCHAR (255)   UNIQUE NOT NULL
);

CREATE TABLE account_role
(
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    grant_date timestamp without time zone,
  
    PRIMARY KEY (user_id, role_id),

    CONSTRAINT account_role_role_id_fkey FOREIGN KEY (role_id)
        REFERENCES role (role_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT account_role_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES account (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION
);
 
----------------------------------------------------------------------------------------------------------
/* 56: Create Table */ 

-- Basic Syntax: 
CREATE TABLE table_name (
    column_name date_type column_constraint, 
    column_name date_type column_constraint, 
    table_constraint
)
INHERITS existing_table_name; 

/*  Inherit properties from an existing table. 
    * Contains all columns of existing table inheritted from. 
    * Also contains any addition columns named in create statement. */

-- Use LIKE to create table with same structure. 
-- Doesn't copy data/constraints, just layout schema. 
CREATE TABLE link_copy (LIKE link) ;

----------------------------------------------------------------------------------------------------------
/* 57: Challenge: Create Table */ 
CREATE TABLE challenge ( 
    customer_id     SERIAL          PRIMARY KEY,
    first_name      VARCHAR(100)    NOT NULL, 
    last_name       VARCHAR(100)    NOT NULL, 
    email           VARCHAR(100)    UNIQUE NOT NULL, 
    signup_date     TIMESTAMP       NOT NULL,
    time_logged     INTEGER  

);

----------------------------------------------------------------------------------------------------------
/* 59: Insert */ 

-- Insert using values. 
INSERT INTO table(column1, column2)
VALUES(value1, value2);

INSERT INTO table(column1, column2)
VALUES(value1, value2), 
VALUES(value1, value2), 
VALUES(value1, value2);

-- Create tables for testing: 
CREATE TABLE link ( 
	ID 		        serial 			PRIMARY KEY, 
	url		        VARCHAR(255)	NOT NULL, 
	name	        VARCHAR(255)	NOT NULL, 
	description	    VARCHAR(255), 
	rel             VARCHAR(50)
);

CREATE TABLE link_copy (LIKE link) ;


-- Testing Inserts: 
INSERT INTO link (url, name)
VALUES ('www.google.com', 'Google');

INSERT INTO link (url, name)
VALUES ('www.yahoo.com', 'Yahoo'),
       ('www.bing.com', 'Bing'),
	   ('www.amazon.com', 'amazon');

-- Insert using SELECT clause. 
INSERT INTO link_copy
SELECT * FROM link
WHERE name = 'Bing';

-- Note serials inserted will use the copied value, not the next increment 
-- for the table they're copied into. 

----------------------------------------------------------------------------------------------------------
/* 60: Update */ 
-- Update existing data in a table. 
UPDATE table_name 
   SET column1 = value1
       column2 = value2 
 WHERE condition; 

-- Update all rows description column to Empty Description.
UPDATE link 
   SET description = 'Empty Description';
   
-- Update rows matching a conditional
UPDATE link 
   SET description = 'Name starts with an A'
 WHERE UPPER(NAME) like 'A%';
   
-- Set Description to match name column. 
UPDATE link 
   SET description = name;

-- Return columns of updated entry 
UPDATE link 
   SET description = 'new description' 
 WHERE id = 1
RETURNING id, url, name, description;

----------------------------------------------------------------------------------------------------------
/* 61: Delete Statement */ 
-- Delete rows from table and return the number of rows deleted. 

-- Delete all rows in table: 
DELETE FROM table_name 

-- Delete specific rows in a table: 
DELETE FROM table_name 
 WHERE condition; 

-- Example: 
DELETE 
  FROM link
 WHERE name like 'B%';

-- Example using returning: 
DELETE 
  FROM link
 WHERE name = 'A'
 RETURNING id, url, name, description;

 ----------------------------------------------------------------------------------------------------------
/* 62: Alter Table */ 
-- Change table structures. 

--Syntax: 
ALTER TABLE table_name 
ACTION; 

-- Create table for testing. 
DROP TABLE IF EXISTS link; 
CREATE TABLE link (
	link_id		SERIAL			PRIMARY KEY ,
	title		VARCHAR(512) 	NOT NULL,
	url			VARCHAR(1024)	NOT NULL UNIQUE
);

-- Add Column 
ALTER TABLE link 
  ADD COLUMN active BOOLEAN; 
 
-- Delete Column 
ALTER TABLE link 
 DROP COLUMN active; 

 -- Rename Column 
 ALTER TABLE link 
 RENAME COLUMN title TO new_title_name;

 -- Rename Table 
ALTER TABLE link RENAME TO url_table

 ----------------------------------------------------------------------------------------------------------
/* 63: Drop Table */ 
-- Remove / Drop tables from Database. 

DROP TABLE [IF EXISTS] table_name [RESTRICT / CASCADE]; 
-- IF EXISTS: Checks if table exists first to stop errors if it doesn't. 
-- RESTRICT: Implicitly on all DROP TABLE statements. Doesn't drop table if it has dependant objects. 
-- Whereas CASCADE Will still drop it. 

--Example: Create and drop a table. 
CREATE TABLE test_two (
	test_id 	SERIAL		PRIMARY KEY
); 

SELECT * FROM test_two;

DROP TABLE IF EXISTS test_two;

 ----------------------------------------------------------------------------------------------------------
/* 64: Check Constraints */ 

DROP TABLE IF EXISTS new_users
CREATE TABLE new_users (
	user_id		SERIAL 			PRIMARY KEY, 
	first_name 	VARCHAR(100),	
	last_name	VARCHAR(100),
	birth_date	DATE 			CHECK(birth_date > '1900-01-01'),
	join_date 	DATE			CHECK(join_date > birth_date),
	salary		INTEGER			CHECK(salary > 0)
);

-- Cannot insert a new row that violates the check constraint: 
INSERT INTO new_users(first_name, birth_date, join_date, salary)
VALUES ('Joe', '1980-02-02', '1990-04-04', -10);

-- Manually naming the constraint using the CONSTRAINT keyword. 
CREATE TABLE sales (
	sales		INTEGER		CONSTRAINT positive_sales CHECK(sales>0)
);

----------------------------------------------------------------------------------------------------------
/* 65: NOT NULL Constraints */ 
CREATE TABLE learn_null ( 
    first_name      VARCHAR(100), 
    sales           INTEGER         NOT NULL
);

-- Insert to fail as it has a missing value for sales. 
INSERT INTO learn_null(first_name) 
VALUES ('John');

-- Insert to succeed as it has a value for sales: 
INSERT INTO learn_null(first_name, sales) 
VALUES ('John', 0)

----------------------------------------------------------------------------------------------------------
/* 66: Unique Constraints */ 
-- Every new row inserted, DBMS ensures this value isn't already present in other rows. 

CREATE TABLE people ( 
    id          SERIAL          PRIMARY KEY, 
    first_name  VARCHAR(50)     ,
    email       VARCHAR(100)    UNIQUE
);

-- Insert 2 rows, the second has a duplicate email...Will fail the insert. 
INSERT INTO people (id, first_name, email) 
VALUES (1, 'Joe', 'joe@joe.com');
INSERT INTO people (id, first_name, email) 
VALUES (2, 'Joe2', 'joe@joe.com');

