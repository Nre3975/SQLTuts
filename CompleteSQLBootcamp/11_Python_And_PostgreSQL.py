/* 70: Overview of Python + PostgreSQL */ 

# Link for resources on Psycoog2: https://wiki.postgresql.org/wiki/Psycopg2_Tutorial

# Import psychopg2 library 
import psycopg2 as pg2

# Setup Connection to database. 
conn = pg2.connect(host = "127.0.0.1", user="postgres", password="Password1", database="SQLB_DVDRental")

# Ensure conn exists and is active (Closed = 0 means active, closed = 1 means not. )
conn

# Create cursor
cur = conn.cursor()

# Use cursor to execute a query
cur.execute('SELECT * FROM payment')

# Fetch one result from the cursor. 
cur.fetchone()

# Fetch all results from the cursor. 
cur.fetchall()

# Use cursor to execute a query
cur.execute('SELECT * FROM payment')

# Fetch a customer amount of results, and save to a variable 
data = cur.fetchmany(10)

# View list with stored results.  
data

# Close the connection. 
conn.close()










