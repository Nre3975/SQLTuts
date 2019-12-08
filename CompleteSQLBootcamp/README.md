# The Complete SQL Bootcamp. 
##### Udemy Course: https://www.udemy.com/course/the-complete-sql-bootcamp/

### Install PostgreSQL pgAdmin as per SQL folder Readme.  
* installation guide included in main SQL Directory. 

### Add DVD Rental data into a database via pgAdmin4.
#### Create database to hold the data: 
* Right click on Databases, select `CREATE DATABASE` 
* Give it an arbitrary name. 

#### Restore data into the database. 
* Right click on the database, select `Restore` 
* Search by filename, and navigate to dvdrental.tar. Will need to change the format being searched for to all files. 
* Go to `Restore Options` 
* Set: `Pre-Data`, `Post-data`, and `Data` to **Yes**, leave the rest default. 

#### Finalising
* Will likely encounter a popup box stating: `Failed (exit code 1).` This is fine to ignore. 
* Right click on database name and select `Refresh` 
* Right click on database name and select `Query Tool`
* Enter `SELECT * FROM film;` to ensure everything is working as intended. 