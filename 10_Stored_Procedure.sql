 -- Stored Procedure
/*
Defination:
A stored procedure is a prepared SQL query that can be saved, so that the query can be reused over and over again. 
We save one or more queries as stored procedure and call the procedure to execute it. 

Usage:
- To enhance security by allowing controlled access to database operation and reducing SQL injection
- Improving the business logic by directly including the business logic and process in the database.
- Improving performance by reducing the overhead of repeatedly sending SQL statements(through API) to database.
- To improve maintainability by modularizing the query into multiple stored procedure.

Syntax:

CREATE PROCEDURE procedure_name
    (parameter1 data_type, parameter2 data_type, ...)
AS
BEGIN
    -- SQL statements and logic
END;


Code Example:
*/


-- Example 1: Increase all the price by 10 % in the catalogue. 

CREATE OR REPLACE PROCEDURE increase_price_by_10_percentage() 
language plpgsql
AS $$
begin

update product set unit_price = round(cast(1.10 * unit_price as numeric), 2);

end $$;

-- To call the procedure you simply do:
CALL increase_price_by_10_percentage();

