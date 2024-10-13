 -- Transaction and Rollback
/*
Defination:
Transactions in SQL are used to execute a set of SQL statements in a group. 
With transactions, either all the statements in a group execute or none of the statements execute. 
To revert the execution we use rollback.

Usage:
- Banking transaction where it's important to make sure all transaction pass or none of them pass.
- Any transaction where all the transaction need to complete or none of them complete.

Syntax:
BEGIN TRANSACTION [TRANSACTION_NAME]
    /*... SQL statement(s)...*/
END;

-- If rollback is present
ROLLBACK TO [SAVEPOINT_NAME]
Code Example:
*/


-- Example 1: Simple trannsaction 
BEGIN;
    UPDATE  Product SET name= 'noodles', unit_price= 25 where product_id=13;
    INSERT INTO Product(name, unit_price, category_name, description) VALUES ('rice',10, 'Food', 'white in color.');
    INSERT INTO Product(name, unit_price, category_name, description) VALUES ('butter',15, 'Food', 'smooth.');
COMMIT;

-- Example2: Transction with rollback, savepoint
BEGIN;
    UPDATE  Product SET name= 'long noodles', unit_price= 2.5 where product_id=13;
    SAVEPOINT my_savepoint;
    INSERT INTO Product(name, unit_price, category_name, description) VALUES ('white rice',10, 'Food', 'white in color.');
    SAVEPOINT my_savepoint;
    INSERT INTO Product(name, unit_price, category_name, description) VALUES ('smooth butter',15, 'Food', 'smooth.');

    -- rollback to the second savepoint
    ROLLBACK TO SAVEPOINT my_savepoint;
    SELECT * FROM Product;              

    -- release the second savepoint
    RELEASE SAVEPOINT my_savepoint;

    -- rollback to the first savepoint
    ROLLBACK TO SAVEPOINT my_savepoint;
    SELECT * FROM Product;              
COMMIT;


-- Check value
select * FROM product;