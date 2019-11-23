/* 35: AS Statement. */ 
-- Create an Alias for a column / table selection etc. 
SELECT payment_id AS "my_payment_column"
  FROM payment;

SELECT customer_id, SUM(amount) AS "Total_Spent"
  FROM payment 
 GROUP BY customer_id; 

---------------------------------------------------------------------------
/* 36: Overview of Inner Join  */ 




------------------------------------------------------------------------------------

