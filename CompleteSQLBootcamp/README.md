# The Complete SQL Bootcamp. 
* Hosted on [Udemy](https://www.udemy.com/course/the-complete-sql-bootcamp/)
* Uses PAGILA database (PostgreSQL version of Sakila)

## Install PostgreSQL pgAdmin as per SQL folder Readme.  
* installation guide included in main SQL Directory. 

## Restore DVD Rental database.
### Via Terminal commands: 
```
rcn@acn:~$ sudo su postgres
[sudo] password for rcn:          
postgres@acn:/home/rcn$ psql
Password for user postgres: 
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help.

postgres=# CREATE DATABASE testdb WITH OWNER postgres;
CREATE DATABASE
postgres=# \q
postgres@acn:/home/rcn$ pg_restore -C -U odm -d testdb /home/rcn/Downloads/dvdrental.tar
Password: 
pg_restore: while PROCESSING TOC:
pg_restore: from TOC entry 7; 2615 2200 SCHEMA public postgres
pg_restore: error: could not execute query: ERROR:  schema "public" already exists
Command was: CREATE SCHEMA public;


pg_restore: warning: errors ignored on restore: 1
postgres@acn:/home/rcn$ 
```
NB: This error can be ignored, the restore worked fine. 

### Via pgAdmin4 GUI.
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