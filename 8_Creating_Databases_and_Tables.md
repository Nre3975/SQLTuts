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

