/* 67: Assessment Test 3. */ 
-- Create a new database called "School" 

odmint@odlm:~$ sudo su postgres 
[sudo] password for odmint:          
postgres@odlm:/home/odmint$ psql
Password for user postgres: 
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help.

postgres=# CREATE DATABASE School WITH OWNER postgres;
CREATE DATABASE
postgres=# 

-- Create two tables: teachers and students.
-- Students table should have columns for student_id, first_name, last_name, 
-- Homeroom_number, phone,email, and graduation year.

DROP TABLE IF EXISTS students;
CREATE TABLE students ( 
	student_id			SERIAL		    PRIMARY KEY, 
	first_name 			VARCHAR(100)    NOT NULL,
	last_name           VARCHAR(100)    NOT NULL, 
	homeroom_number     INTEGER,
	phone               VARCHAR(50)     NOT NULL UNIQUE,
	email               VARCHAR(100)    UNIQUE,
	graduation_year     INTEGER
);

-- Teachers table should have columns for teacher_id, first_name, last_name,
-- homeroom_number, department, email, and phone.
DROP TABLE IF EXISTS teachers; 
CREATE TABLE teachers ( 
    teacher_id          SERIAL          PRIMARY KEY, 
    first_name          VARCHAR(100)    NOT NULL, 
    last_name           VARCHAR(100)    NOT NULL,
    homeroom_number     INTEGER         ,
    department          VARCHAR(100)    ,
    email               VARCHAR(100)    NOT NULL UNIQUE,
    phone               VARCHAR(50)     UNIQUE
);

-- Consider the following for constraints when making the tables: 
-- We must have a phone number to contact students in case of an emergency.
-- We must have ids as the primary key of the tables
-- Phone numbers and emails must be unique to the individual.


-- Insert a student named Mark Watney (student_id=1) who has a phone number of 777-555-1234 and doesn't have an email. He graduates in 2035 and has 5 as a homeroom number.

INSERT INTO students (first_name, last_name, homeroom_number, phone, email, graduation_year)
VALUES ('Mark', 'Watney', 5, '777-555-1234', NULL, 2035);

-- Insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom number of 5 and is from the Biology department. His contact info is: jsalk@school.org and a phone number of 777-555-4321.

INSERT INTO teachers (first_name, last_name, homeroom_number, department, phone, email)
VALUES ('Jonas', 'Salk', 5, 'Biology', '777-555-4321', 'jsalk@school.org');