# SQLTuts Readme.
Collection of SQL tutorials. 
1. The Complete SQL Bootcamp - [Udemy Link](https://www.udemy.com/course/the-complete-sql-bootcamp/)

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

## Configuration Notes: 
#### Postgres user
* During installation a system user account "Postgres" is created with an identical super user account in postgres. 
* This postgres account has an all-access pass on your PostgreSQL database server, permission-wise.
* By default, the postgres user account isn't configured with a password. 

#### Postgres Database
* PostgreSQL is installed with a default database called postgres. 
* Use the postgres database for administration functions, and to create new databases on the PostgreSQL server.

#### PSQL Command Line Utility
* PostgreSQL consists of psql, a command line application for managing your databases and server. 
* PSQL gives total control of your postgres system from the terminal, together with the ability to execute SQL queries.
* Will use psql to perform our preliminary configuration and to create an initial database super user.

## Configuring the Users and Database: 
### Users:
#### Option 1: Change postgres user to have a password 
1. Get access to the postgres account through your machine root user. 
2. Alter password on the user
```
rcn@acn:~$ sudo su postgres
[sudo] password for rcn:          
postgres@acn:/home/rcn$ psql
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help. 
postgres=# ALTER USER postgres WITH PASSWORD 'Password1';
ALTER ROLE
```

#### Option 2: Create seperate super user account. 
1. Get access to the postgres account through your machine root user. 
2. Use that postgres account to create a brand new super-user account for your PostgreSQL (This is better from security perspective)

```
rcn@acn:~$ sudo su postgres
postgres@acn:/home/rcn$ psql
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

Database   administrative login by Unix domain socket 
|local      |     all       |   postgres     |                   |        md5        |
| --------- | ------------  | -------------- | ----------------- | ----------------- |
|           |               |                |                   |                   |
| **TYPE**  |  **DATABASE** |   **USER**     |    **ADDRESS**    |     **METHOD**    |
| local     |  all          |    rcn         |                   |        peer       |
| local     |  all          |    odm         |                   |        md5        |

1. Restart service: `sudo systemctl reload postgresq`
2. Connect to DB with new account: 
```
rcn@acn:~$ sudo su
root@acn:/home/rcn# psql -d postgres -U odm
Password for user odm: 
psql (12.1 (Ubuntu 12.1-1.pgdg18.04+1))
Type "help" for help.
postgres=# 
```

### Databases: 
#### Create another Database. 
```
rcn@acn:~$ sudo su postgres
postgres@acn:/home/rcn$ psql
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

## PG-Admin4
### Install PG-Admin4 
 * Installation is simple via apt: `sudo apt-get install pgadmin4`

### Configure pgAdmin4
* Open pgAdmin from applications menu.
* If no servers are listed, create a new one using either the postgres account or one made earlier: 
   * Host name / address: 127.0.0.1
   * Port: 5432
   * Username: postgres
   * Password: Password1


See individual courses for notes on further setups. 