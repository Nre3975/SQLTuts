/* 53: Primary Keys and Foreign Keys. */ 
 -- Add primary table when defining the tables structure. 

 CREATE TABLE table_name (
     column_name1 data_type PRIMARY KEY, 
     column_name2 data_type
     column_name3 data_type
 );
 
----------------------------------------------------------------------------------------------------------
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