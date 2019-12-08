# SQLTuts
Collection of SQL tutorials. 
* Complete SQL Bootcamp - Udemy. 

# Installing PostgreSQL on Linux Mint 19.2: 
PostgreSQL Global Development Group (PGDG) maintain an apt repository of PostgreSQL packages located at http://apt.postgresql.org/pub/repos/apt/

#### Add package source to distro: 
Create sources file: 
* `sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > \`
* `/etc/apt/sources.list.d/postgresql.list' `

Add package repository key: 
*  `wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -`

Update and Upgrade Packages: 
*  `sudo apt-get update` 
*  `sudo apt-get upgrade` 

#### Install PostgreSQL
*  `sudo apt-get install postgresql-12` 

## Configuration Notes. 
#### Postgres user

* During installation a system user account "postgres" was created with an identical user account in postgres. 
* By default, the postgres user account isn't configured with a password,need to create one
* This postgres account has an all-access pass on your PostgreSQL database server, permission-wise.

#### Postgres Database
* PostgreSQL is installed with a default database postgres. 
* Use the postgres database for administration functions, and to create new databases on the PostgreSQL server.

#### PSQL Command Line Utility

* PostgreSQL consists of psql, a command line application for managing your databases and server. 
* PSQL gives total control of your postgres system from the terminal, together with the ability to execute SQL queries.
* Will use psql to perform our preliminary configuration and to create an initial database super user.

#### Option 1: Change postgres user to have a password 
1. Get access to the postgres account through your machine root user. 
2. Alter password on the user
```
odusern@odpc:~$ sudo su postgres
[sudo] password for odusern:          
postgres@odpc:/home/odusern$ psql
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help. 
postgres=# ALTER USER postgres WITH PASSWORD 'Password1';
ALTER ROLE
```

#### Option 2: Create seperate super user account. 
1. Get access to the postgres account through your machine root user. 
2. Use that postgres account to create a brand new super-user account for your PostgreSQL 

```
odusern@odpc:~$ sudo su postgres
postgres@odpc:/home/odusern$ psql
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help.
postgres=# CREATE USER odm
postgres-# WITH SUPERUSER CREATEDB CREATEROLE
postgres-# PASSWORD 'Password1';
CREATE ROLE
postgres=# 
```

#### This user will need adding to the pg_conf file to connect to the postgres database
1. Edit pg_conf file: `sudo nano /etc/postgresql/12/main/pg_hba.conf` Add the following: 

Database administrative login by Unix domain socket
local   all             postgres                                md5

TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             odmint                                  peer
local   all             odm                                     md5

2. Restart service: `sudo systemctl reload postgresq`
3. Connect to DB with new account: 
```
odmint@odlm:~$ sudo su
root@odlm:/home/odmint# psql -d postgres -U odm
Password for user odm: 
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help.
postgres=# 
```

#### Create another Database. 
```
odmint@odlm:~$ sudo su postgres
postgres@odlm:/home/odmint$ psql
Password for user postgres: 
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help.

postgres=# CREATE DATABASE test_database WITH OWNER postgres;
CREATE DATABASE
postgres=# \connect test_database;
You are now connected to database "test_database" as user "postgres".
```



#### NB: See current user accounts/databases whilst logged into psql: 
* List Databases: `\l`
* List Users: `\du`





### Install PG-Admin4 
 * `sudo apt-get install pgadmin4`

### Configure pgAdmin4
* Open pgAdmin from 
* If no servers are listed, create a new one using either the postgres account or one made earlier: 
   * Host name / address: 127.0.0.1
   * Port: 5432
   * Username: postgres
   * Password: Password1

* See individual courses for notes on database setups. 