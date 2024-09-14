 -- Triggers
/*
Defination:
Triggers are stored programs, which are automatically executed or fired when some events occur. 
Triggers are, in fact, written to be executed in response to any of the following events −

A database manipulation (DML) statement (DELETE, INSERT, or UPDATE)
A database definition (DDL) statement (CREATE, ALTER, or DROP).
A database operation (SERVERERROR, LOGON, LOGOFF, STARTUP, or SHUTDOWN).

Usage:
- To allows you to specify SQL actions that should be executed automatically when a specific event occurs in the database. 
- To automatically update a record in one table whenever a record is inserted into another table.

Syntax:
[In postgres a Trigger can be created with following syntax]

CREATE [ OR REPLACE ] [ CONSTRAINT ] TRIGGER name { BEFORE | AFTER | INSTEAD OF } { event [ OR ... ] }
    ON table_name
    [ FROM referenced_table_name ]
    [ NOT DEFERRABLE | [ DEFERRABLE ] [ INITIALLY IMMEDIATE | INITIALLY DEFERRED ] ]
    [ REFERENCING { { OLD | NEW } TABLE [ AS ] transition_relation_name } [ ... ] ]
    [ FOR [ EACH ] { ROW | STATEMENT } ]
    [ WHEN ( condition ) ]
    EXECUTE { FUNCTION | PROCEDURE } function_name ( arguments )

where event can be one of:

    INSERT
    UPDATE [ OF column_name [, ... ] ]
    DELETE
    TRUNCATE


### Difference between Stored procedure and Triggers:
A stored procedure is a user defined piece of code written in the local version of PL/SQL, which may return a 
value (making it a function) that is invoked by calling it explicitly.

A trigger is a stored procedure that runs automatically when various events happen (eg update, insert, delete).

Trigger vs Stored Procedure: Using OOP concepts, Stored Procedure can be though of a method in an OOP and Triggers can be 
though of event handler
that can handle the event itself or do some processing and allow for the event to continue using a method.

Code Example:
*/

-- Let's create a value anamoly log table
Create table value_anamoly_log(
    id int,
    created_at timestamp,
    created_by_user varchar(255)
);


-- Example 1: Placing a trigger when person inserts an invalid data i.e price < 0 or price > 1000$

CREATE OR REPLACE FUNCTION anamoly_log_trigger_fxn()
RETURNS TRIGGER
AS
$$
BEGIN 
  IF NEW.unit_price <0  or NEW.unit_price > 1000 THEN
     INSERT INTO value_anamoly_log(id, created_at, created_by_user)
    VALUES (NEW.product_id, NOW(), CURRENT_USER);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or REPLACE TRIGGER anamoly_log_trigger
AFTER INSERT OR UPDATE
ON product
FOR EACH ROW
EXECUTE PROCEDURE anamoly_log_trigger_fxn();


-- Check item in value anamoly log table
SELECT * FROM value_anamoly_log; -- it should be empty

-- Now let insert values
-- This should trigger the function
INSERT INTO Product(name, unit_price, category_name, description) VALUES ('noodles',-1, 'Food', 'Made from wheat.');


-- Update statement
UPDATE  Product SET name= 'noodles1', unit_price= 2000 where product_id=13; -- should trigger function

-- Normal update statement
UPDATE  Product SET name= 'noodles', unit_price= 20 where product_id=13; -- no trigger 