# Section 8 (Creating Databases and Tables) Notes. 

## 52: Data Types.

Constrain the type of data in a column. 

#### Supported Datatypes: 
##### Boolean. 
* Keywords: *Boolean*, *Bool* 
* Can be True, False or NULL (Not a true Boolean...)

##### Character. Keyword: Char/Varchar
* *char*: Single Character. 
* *char(n)*: Fixed length char over 1. 
  * If a string shorter than limit is entered, gaps will be padded. 
  * If a string longer than limit is entered, results in error. 
* *varchar(n)*: Variable length strings.   
  * If shorter no padding is used. 
  * If longer still errors. 

##### Number (Integers) 
* *Smallint*: 2 bytes Number, Range of: -32768 - 32767.
* *Integer*: 4 byte number. Range of: -214783648 - 214783648.
* *Numeric(p)*: Exact numeric number. 
* *Serial*: Like integer, but value is automatically populated into the column.

##### Number (Floats) 
* *Float(n)*: Floating point number of at least n precision. 
* *Real* / *Float8*: Double precision (8 Byte) FP Number. 
* *Numeric* / *numeric(p,s)*: Real number with p digits, with s number after decimal point. 

##### Temporal (Date-Time)
* *Date*: Date Data. 
* *Time*: Time Data
* *Timestamp*: Data and Time Data .
* *Interval*: Difference in timestamps
* *Timestamptz*: Timestamp and Timezone Data. 

##### Specal Types
* Outside of scope of lecture. 

##### Array
* Outside of scope of lecture. 

## 53: Primary Keys and Foreign Keys. 

#### Primary Key: 
* Column(s) which uniquely identofy a row in a table. 
* Defined using Primary Key Constraint. 
* Each table has 1 or 0 primary keys, but should always have one. 
* Defining primary key on column(s) will create an index on the same column(s) 
* Example: CustomerID. 
* Serials can be a good primary key ID, as they auto increment when new row added (Can use a Sequence in Oracle SQL)

#### Foreign Key: 
* Column(s) which uniquely identify a row in another table. 
* Often points to the primary key of another table, if not to the primary key it should be another column which had a unique constraint on it. 
* Defined through a foreign key constraint. 
* Maintains Referential integrity between child and parent tables
* FK sits in the child table of the primary keys parent table. 
* A table can have multiple foriegn keys to various other tables. 

#### Example: 
2 Tables: <code>so_items</code>, <code>so_headers</code>. 
###### so_headers: 
* Primary Key: Id. 
###### so_items: 
* Primary Key: item_id 
* Foreign Key: so_id (Links to Id from so_headers table) 

## 56: Create Table. 

#### Column Constraints. 
* Not Null: Value cannot be null. 
* Unique: Value of column must be unique against other rows. (Can be null, each null is unique in PostgreSQL.)
* Primary Key - Combination of Unique and Not Null. (Can be multiple columns.)
* Check Constraint: Check a condition when inserting / updating data. 
* References: Constrain value of the column that exists in a column in another table. (Used to define Foreign Key constraint.)

#### Table Constraints 
* Applied to entire table, not just a column. 
* Unique (Column_list)
* Primary Key (Column_list) 
* Check (Condition)
* References.

## 62: Alter Table.

#### Types of actions: 
* Add, Remove, Rename columns. 
* Set default value for a column. 
* Add check constraint to a column 
* Rename table. 

## 64 Check Constraint. 
* Constraint to specify if a value in a column should meet a specific requirement. 
* Uses Boolean expression to evaluate values of column. 

## 65 NOT NULL Constraint. 
* NULL: Missing or unknown information. Different to zero/empty. 
* NOT NULL ensures a column must have some data in it, cannot be a NULL value. 
*  
