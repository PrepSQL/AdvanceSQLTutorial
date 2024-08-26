-- -- Creating a table
CREATE TABLE Customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name  VARCHAR(255) NOT NULL,
	email VARCHAR(255)
);

-- Another table : CREATE TABLE 
CREATE TABLE Product(
	product_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	unit_price FLOAT NOT NULL, -- DEFAULT 0.0
	category_name VARCHAR(255),
	description TEXT	
);
-- drop table Orders;
-- DROP TABLE PRODUCT;

-- drop table Orders;
CREATE TABLE Orders(
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER REFERENCES Customer(customer_id) ON DELETE SET NULL,  --- with mentioned the target column
	product_id INTEGER REFERENCES Product ON DELETE SET NULL, --without mentioning the target column
	item_ordered_count int NOT NULL DEFAULT 1,
	ordered_date DATE 
);

Select * from Orders;

-- Let's insert data into customer
INSERT INTO CUSTOMER VALUES(1, 'James', 'Smith', 'james@gmail.com');
INSERT INTO CUSTOMER VALUES(2, 'Michael', 'Brown', 'michael@gmail.com');
INSERT INTO CUSTOMER VALUES(3, 'John', 'Miller', 'john@gmail.com');
INSERT INTO CUSTOMER VALUES(4, 'William', 'Johnson', 'william@gmail.com');
INSERT INTO CUSTOMER VALUES(5, 'George', 'Jones', 'george@gmail.com');
INSERT INTO CUSTOMER VALUES(6, 'Henry', 'Davis', 'henry@gmail.com');
INSERT INTO CUSTOMER VALUES(7, 'Britney', 'Williams', 'britney@gmail.com');
INSERT INTO CUSTOMER VALUES(8, 'Tailor', 'Swift', 'tailor@gmail.com');
INSERT INTO CUSTOMER VALUES(9, 'Joseph', 'Clark', 'joseph@gmail.com');
INSERT INTO CUSTOMER VALUES(10, 'Jim', 'carrey', 'jim@gmail.com');
INSERT INTO CUSTOMER VALUES(11, 'Ram', 'Basnet', 'ram@gmail.com');
INSERT INTO CUSTOMER VALUES(12, 'Anita', 'Karki', 'anita@gmail.com');
INSERT INTO CUSTOMER VALUES(13, 'Uogu', 'Wale', 'uogu@gmail.com');
INSERT INTO CUSTOMER VALUES(14, 'Sanjog', 'Thapa', 'sanjog@gmail.com');
INSERT INTO CUSTOMER VALUES(15, 'Sai', 'Kumar', 'sai@gmail.com');

select * from customer;
INSERT INTO Product VALUES (1, 'Mango', 2.3, 'Fruit', 'Mango fresh from market. 2.3 dollars per pound!');
INSERT INTO Product VALUES (2, 'Orange', 1.3,  'Fruit','Orange fresh from market. 2.3 dollars per pound!');
INSERT INTO Product VALUES (3, 'Apple', 2,  'Fruit','Apple fresh from market from california. 2 dollars per pound!');
INSERT INTO Product VALUES (4, 'Cabbage', 1, 'Vegetable','Cabbage fresh from market. 1 dollars per pound!');
INSERT INTO Product VALUES (5, 'Tomato', 1.2, 'Vegetable', 'Tomato fresh from market. 1.2 dollars per pound!');
INSERT INTO Product VALUES (6, 'Cauliflower', 2.9, 'Vegetable', 'Cauliflower fresh from market. 2.9 dollars per pound!');
INSERT INTO Product VALUES (7, 'Broccoli', 3, 'Vegetable', 'Broccoli fresh from market. 3 dollars per pound!');
INSERT INTO Product VALUES (8, 'Mango Juic', 5,'Grocery', 'Mango juice fresh from market. 5 dollars per bottle!');
INSERT INTO Product VALUES (9, 'Milk', 2.3, 'Grocery', 'Milk fresh from market. 2.3 dollars per gallon!');
INSERT INTO Product VALUES (10, 'Bread', 4.2, 'Grocery', 'Bread fresh from market. 4.2 dollars per bag!');

SELECT * FROM Product;

-- Lets insert data into this Orders table
INSERT INTO Orders VALUES (1, 1, 1, 1, '2024-01-01');
INSERT INTO Orders VALUES (2, 1, 2, 3, '2024-01-01');
INSERT INTO Orders VALUES (3, 3, 10, 2, '2024-01-01');
INSERT INTO Orders VALUES (4, 3, 9, 2, '2024-01-01');

INSERT INTO Orders VALUES (5, 5, 5, 3, '2024-01-02');
INSERT INTO Orders VALUES (6, 6, 6, 1, '2024-01-02');
INSERT INTO Orders VALUES (7, 7, 8, 4, '2024-01-02');

INSERT INTO Orders VALUES (8, 11, 2, 1, '2024-01-03');
INSERT INTO Orders VALUES (9, 12, 3, 1, '2024-01-03');
INSERT INTO Orders VALUES (10, 13, 3, 1, '2024-01-03');

INSERT INTO Orders VALUES (11, 14, 2, 3, '2024-02-04');
INSERT INTO Orders VALUES (12, 3, 10, 2, '2024-02-04');
INSERT INTO Orders VALUES (13, 3, 9, 2, '2024-02-04');

INSERT INTO Orders VALUES (14, 15, 5, 3, '2024-03-05');
INSERT INTO Orders VALUES (15, 8, 6, 2, '2024-03-05');
INSERT INTO Orders VALUES (16, 10, 9, 2, '2024-03-05');

Select * from Orders;
select * from product;
select customer_id, count(product_id) as ctn  from orders
group by customer_id
order by customer_id asc;
select * from customer;



-- Now Let's write the SQL queries. 
-- Query 1: CTE(Common table expression)
-- Combining data with CTE
/*Multi line comment 
CTE syntax
WITH expression_name [ ( column_name [,...n] ) ] 
AS 
( CTE_query_definition )

-- for multiple CTE expression
WITH
expression_name_1 AS
(CTE query definition 1)

[, expression_name_X AS
   (CTE query definition X)
 , etc ]


CTEs, like database views and derived tables, enable users to more easily write and maintain complex 
queries via increased readability and simplification.This reduction in complexity is achieved by deconstructing 
ordinarily complex queries into simple blocks to be used, and reused if necessary, in rewriting the query. 
Example use cases include:

Needing to reference a derived table multiple times in a single query
An alternative to creating a view in the database
Performing the same calculation multiple times over across multiple query components
*/
-- sum of [1, 2, 3 .... 99, 100] recursively

WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t;

-- This will show error... 
-- WITH t(n) AS (
--     VALUES (1)
--   UNION ALL
--     SELECT n+1 FROM t WHERE n < 100
-- )
-- SELECT sum(n) FROM t;


-- Non-recursive table
WITH regional_sales AS (
        SELECT region, SUM(amount) AS total_sales
        FROM orders
        GROUP BY region
     ), top_regions AS (
        SELECT region
        FROM regional_sales
        WHERE total_sales > (SELECT SUM(total_sales)/10 FROM regional_sales)
     )
SELECT region,
       product,
       SUM(quantity) AS product_units,
       SUM(amount) AS product_sales
FROM orders
WHERE region IN (SELECT region FROM top_regions)
GROUP BY region, product;

-- Example1: nonrecursive Total sales per product
WITH top_sales as (
	SELECT product_id, sum(item_ordered_count) as total_count from orders
	group by product_id
)

-- -- This one is not relevant here
-- Select name, category_name, total_count, 
-- round(cast(unit_price * total_count as numeric), 2) as total_amount 
-- from product
-- inner join top_sales
-- on product.product_id=top_sales.product_id
-- order by total_amount desc;

-- A recursive SQL common table expression (CTE) is a query that continuously 
-- references a previous result until it returns an empty result. It's best used as a 
-- convenient way to extract information from hierarchical data.
-- What is hierarchical data? -
-- Hierarchical data is defined as a set of data items that are related to each 
-- other by hierarchical relationships. Hierarchical relationships exist where one 
-- item of data is the parent of another item.

-- WITH R AS (SELECT 1 AS n)
-- SELECT n + 1 FROM R


WITH orders_summary (productid, sum_product, count_product) 
AS
(
    SELECT 
        product_id
      , sum(item_ordered_count)
      , count(product_id)
	from orders
	group by product_id
	order by product_id
)
SELECT * FROM orders_summary;

-- same as 
-- WITH orders_summary
-- AS
-- (
--     SELECT 
-- 		product_id as productid
--       , sum(item_ordered_count) as sum_product
--       ,count(product_id) as count_product
-- 	from orders
-- 	group by product_id
-- 	order by product_id
-- )
-- SELECT * FROM orders_summary;

-- as would this:


-- Example of working
-- This would work:
WITH table1 (Number1, CAST1, Function1) 
AS
(
    SELECT 
        1
      , CAST('1' AS CHAR(1))
      , TO_CHAR(1, '9')
)
SELECT * FROM table1;



-- This would work
WITH table1 
AS
(
    SELECT 
        1 as Number1
      , CAST('1' AS CHAR(1)) as CAST1
      , TO_CHAR(1, '9') as Function1
)
SELECT * FROM table1;

-- 
-- This works too but without the column name so no need to show this example.
-- WITH table1 
-- AS
-- (
--     SELECT 
--         1 
--       , CAST('1' AS CHAR(1))
--       , TO_CHAR(1, '9') 
-- )
-- SELECT * FROM table1;

-------------------------END OF CTE-----------------

-- Query 2: Subqueries
-- 1. Subqueries basics
-- 2. [No need]Not using this one[Using subqueries to aggregate in multiple stages]
-- 3. Subqueries in conditional logic 
-- 4.[No need]Joining subqueries
-- 5. [No need]Subqueries and UNIONs
/*
Syntax: 
Select [columns] from ([sub_query expression]) sub

Select [columns] from abc where [column] in ([sub_query expression])

Select [columns] from abc where [column] = ([sub_query min/max() expression])

*/
-- Let's get all the orders whose category is 'Fruit' and order more than 1
select sub.* from (
	select orders.*, category_name, name from orders 
	inner join product 
	on orders.product_id=product.product_id
	where category_name='Vegetable'
) sub
where sub.item_ordered_count > 1;

-- Sub quer in conditional statement
-- with where and in: let's filter all the orders where item is fruit(without joins)
-- Filtering all products with 'Fruit' category
select * from orders 
where product_id in (select product_id from product where category_name='Fruit');

-- select any one item with maximum price 
select * from orders 
where product_id = (select product_id from product order by unit_price desc limit 1);

--------------------START of CASE in SQL------------------------
-- Query3: Transforming data with CASE in SQL (Conditional Summarization)
-- Let's categorize product with price, 
-- price <= $1 as 'Low Price'
-- price >= 1 and price <=3 'Average price' and
-- price > 3 'High price'
SELECT (CASE 
		WHEN unit_price <= 1 THEN 'Low Price'
		WHEN unit_price > 1 and unit_price <= 3 THEN 'Average Price' 
		WHEN unit_price >3 THEN 'High Price'
		end) as price_category,
		product_id, 
		unit_price
	from product;

-- Using grouping with CASE
WITH cte as (SELECT (CASE 
		WHEN unit_price <= 1 THEN 'Low Price'
		WHEN unit_price > 1 and unit_price <= 3 THEN 'Average Price' 
		WHEN unit_price >3 THEN 'High Price'
		end) as price_category,
		product_id, 
		unit_price
	from product)

-- -- go further by grouping these items. 
select price_category, count(orders.item_ordered_count)as item_count from orders
inner join cte
on cte.product_id=orders.product_id
group by price_category;

--------------------End of CASE in SQL------------------------

-- Query 4: Aggregating Items with Grouping
-- Finding sum and average grouping data without and with roll up,
-- Finding and count duplicate rows in SQL.(Check documents)
-- [No Need.]Grouping rows by a range. (Check the syntax.)

-- let's just count total items sold for different product
-- select count(item_ordered_count) as total_sales_number, product_id from orders
-- group by product_id;

-- lets calculate the total cost and get sum and average sales cost of an item
select product_id, sum(total_cost) as total_sales, sum(item_ordered_count) as total_item_sold,  
       sum(total_cost)/sum(item_ordered_count) as average_cost 
       from (
         select orders.item_ordered_count, orders.product_id, 
                orders.item_ordered_count * unit_price as total_cost from orders
         inner join product
         on orders.product_id=product.product_id
) sub
group by sub.product_id

-- checking if there are duplicate items or not.
select customer_id, product_id, count(*) as duplicate_count from orders
group by customer_id, product_id, item_ordered_count
having count(*)>1;
--------------------End of Aggregation------------------------

-- Let's create a table Employee in an organization with a lot of managers.

--Desc: Employeee in an office with manager. 
-- CREATE TABLE CompanyEmployee(
-- 	emp_id SERIAL PRIMARY KEY,
-- 	employee_name VARCHAR(255) NOT NULL,
-- 	manager_id VARCHAR(255)
-- )

-- There is a tournament of soccer going on and you have all the participant list with players 
-- included ; if it's a player is_player flag is set to 'Y' if not then to 'N'
-- In this event partent are also coming to watch these kids. 
-- Now we want to associate all the Players to their parents
-- Soccer Tournament
-- drop table TournamentParticipants;
CREATE TABLE TournamentParticipants(
	participant_id SERIAL PRIMARY KEY,
	participant_name VARCHAR(255) NOT NULL,
	parent_id int,
	is_player boolean
);

-- select * from TournamentParticipants;
INSERT INTO TournamentParticipants VALUES(1, 'James Smith', NULL, FALSE);
INSERT INTO TournamentParticipants VALUES(2, 'Michael Brown', 10 , TRUE);
INSERT INTO TournamentParticipants VALUES(3, 'John Miller',11 , TRUE);
INSERT INTO TournamentParticipants VALUES(4, 'William Johnson',12, TRUE);
INSERT INTO TournamentParticipants VALUES(5, 'George Jones', 13 , TRUE);
INSERT INTO TournamentParticipants VALUES(6, 'Henry Davis', 14, TRUE);
INSERT INTO TournamentParticipants VALUES(7, 'Britney Williams',15 ,TRUE);
INSERT INTO TournamentParticipants VALUES(8, 'Tom Swift', 18,TRUE);
INSERT INTO TournamentParticipants VALUES(9, 'Joseph Clark', 19, TRUE);
INSERT INTO TournamentParticipants VALUES(10, 'Jim Brown', NULL, FALSE); --10
INSERT INTO TournamentParticipants VALUES(11, 'Ram Miller',NULL, FALSE);
INSERT INTO TournamentParticipants VALUES(12, 'Anita Johnson', NULL, FALSE);
INSERT INTO TournamentParticipants VALUES(13, 'Uogu Jones', NULL,FALSE);
INSERT INTO TournamentParticipants VALUES(14, 'Sanjog Davis', NULL,FALSE);
INSERT INTO TournamentParticipants VALUES(15, 'Sai Williams', NULL,FALSE); --15
INSERT INTO TournamentParticipants VALUES(16, 'Harry Potter', 20, TRUE);
INSERT INTO TournamentParticipants VALUES(17, 'Peter Parker', 21, TRUE);
INSERT INTO TournamentParticipants VALUES(18, 'Harry Swift', NULL, FALSE);
INSERT INTO TournamentParticipants VALUES(19, 'Peter Clark', NULL, FALSE);
INSERT INTO TournamentParticipants VALUES(20, 'John Potter', NULL, FALSE);
INSERT INTO TournamentParticipants VALUES(21, 'Samantha Parker', NULL, FALSE);

-- Example with self join:
-- Query 5: Joins 
-- Dealing with Hierarchical data (self joins)
SELECT 
   players.participant_id as PlayerID, 
   players.participant_name as PlayerName, 
   players.is_player as PlayerOrNot,
   parents.participant_name as ParentName, 
   parents.participant_id as ParentID,
   parents.is_player as ParentPlayerOrNot
from TournamentParticipants players 
JOIN TournamentParticipants parents
on players.parent_id=parents.participant_id;

-- Cross Joins
-- A cross join is a type of join that returns the Cartesian product of rows 
-- from the tables in the join. In other words, it combines each row from the 
-- first table with each row from the second table.
-- select * from product;
SELECT customer_id, 
       CONCAT(first_name,' ', last_name) as FullName, product_id, name as ProductName, category_name
from customer 
cross join product;

-- Inner, left, right, outer joins
SELECT customer.customer_id, 
       CONCAT(first_name, ' ', last_name) as FullName, product_id, order_id, item_ordered_count
from customer
inner join orders
on customer.customer_id=orders.customer_id;


-- Query 6:Views and Materialized Views
-- View: A view is a virtual table based on the result-set of an SQL statement.
-- Materialized View:
-- A materialized view is a pre-computed data set derived from a query specification 
-- (the SELECT in the view definition) and stored for later use. Because the data is pre-computed, 
-- querying a materialized view is faster than executing a query against the base table of the view.

-- A normal view when queried is computed everytime and a materialized view is precomputed so they give 
--  a boost in performance. 

-- Joining 3 tables multiple tables
CREATE VIEW TotalSalesView as (
   SELECT c.customer_id, 
          CONCAT(c.first_name, ' ', c.last_name) as FullName, 
          o.product_id, o.order_id, o.item_ordered_count,
          p.name as ProductName, p.unit_price as UnitPrice,
          CAST(o.item_ordered_count * p.unit_price AS NUMERIC) as TotalSalesPrice
   from customer c
   inner join orders o
   on c.customer_id=o.customer_id
   inner join product p
   on p.product_id=o.product_id
);

-- SELECT * FROM TotalSalesView;

-- Materialized View.  
CREATE MATERIALIZED VIEW TotalSalesMV as (
   SELECT c.customer_id, 
      CONCAT(c.first_name, ' ', c.last_name) as FullName, 
      o.product_id, o.order_id, o.item_ordered_count,
      p.name as ProductName, p.unit_price as UnitPrice,
      CAST(o.item_ordered_count * p.unit_price AS NUMERIC) as TotalSalesPrice
   from customer c
   inner join orders o
   on c.customer_id=o.customer_id
   inner join product p
   on p.product_id=o.product_id
);
-- SELECT * FROM TotalSalesMV;

--Query 7:  Window Functions

-- SUM() OVER() Computing running total in SQL.
-- AVG() OVER() Computing a moving average in SQL.
-- RANK() OVER ():  Find the Length of a Series Using Window Functions
-- ROW_NUMBER() No.of given rows. 
-- RANK() is slightly different from ROW_NUMBER(). If you order by start_time, for example, it might be the case that some terminals have rides with two identical start times. In this case, they are given the same rank, whereas ROW_NUMBER() gives them different numbers.
-- NTILE()  -- 
-- LAG() and LEAD() -- 

-- In SQL, a window function or analytic function[1] is a function which uses values from one or 
-- multiple rows to return a value for each row. (This contrasts with an aggregate function, which 
-- returns a single value for multiple rows.) Window functions have an OVER clause; any function 
-- without an OVER clause is not a window function, but rather an aggregate or single-row (scalar) 
-- function.
-- Tell about common window functions.
-- Example of SUM() and Avg()
SELECT product_id, name, unit_price,
       SUM(unit_price) over() as TotalUnitPrice
FROM product;

SELECT product_id, name, unit_price,
       avg(unit_price) over() as AveragePrice
FROM product;

-- Check row_number(), rank(), and dense_rank()
-- RANK() OVER() Let's rank item based on price
-- select * from product;
select product_id, name, unit_price, category_name,
       RANK() OVER(partition by category_name order by unit_price) as RankItem
FROM product
order by category_name;

-- -- Example: NTILE() -- Not using these Ranked tiles. 
SELECT 
      (NTILE (4) OVER ()) AS grouped_item,
      category_name,
      product_id, name
FROM product;

-- Example: LAG(), LEAD()
SELECT
  LAG(first_name, 1) 
    OVER(ORDER BY first_name) "prev fname",
  first_name, 
  LEAD(first_name, 1) 
    OVER(ORDER BY first_name) "next fname"
 FROM customer
 ORDER BY first_name;


-- Query 8: SQL triggers
/*
Triggers are stored programs, which are automatically executed or fired when some events occur. Triggers are, in fact, written to be executed in response to any of the following events −

A database manipulation (DML) statement (DELETE, INSERT, or UPDATE)

A database definition (DDL) statement (CREATE, ALTER, or DROP).

A database operation (SERVERERROR, LOGON, LOGOFF, STARTUP, or SHUTDOWN).

Why people use SQL trigger? 
to allows you to specify SQL actions that should be executed 
automatically when a specific event occurs in the database. you can use a trigger to 
automatically update a record in one table whenever a record is inserted into another table.

Syntax for a trigger:

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

*/
-- Create table value_anamoly_log(
-- id int,
-- created_at timestamp,
-- created_by_user varchar(255)
-- );

-- select * from value_anamoly_log;


-- Placing a trigger when person inserts an invalid data
-- i.e <0 or greater than 1000$


-- -- This one works---------
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

SELECT * FROM value_anamoly_log;

-- Let's try to insert value in products
-- select * from product;
INSERT INTO Product(name, unit_price, category_name, description) VALUES ('noodles',-1, 'Food', 'Made from wheat.');
-- LETS CHECK THE VALUES
-- This worked
SELECT * FROM value_anamoly_log;
UPDATE  Product SET name= 'noodles1', unit_price= 2000 where product_id=13;

-- update with normal values third test
-- UPDATE  Product SET name= 'noodles', unit_price= 20 where product_id=13;


-- Query 9: SQL transactions and Rollup.
/*
Transactions in SQL are used to execute a set of SQL statements in a 
group. With transactions, either all the statements in a group 
execute or none of the statements execute. To revert 
the execution we use rollback.

*/

BEGIN;
   UPDATE  Product SET name= 'noodles', unit_price= 25 where product_id=13;
   INSERT INTO Product(name, unit_price, category_name, description) VALUES ('rice',10, 'Food', 'white in color.');
   INSERT INTO Product(name, unit_price, category_name, description) VALUES ('butter',15, 'Food', 'smooth.');
COMMIT;

-- Query 10: Stored Procedure
--  Insert values using procedure. 

CREATE OR REPLACE PROCEDURE increase_price_by_10_percentage() 
language plpgsql
AS $$
   begin
         update product set unit_price = round(cast(1.10 * unit_price as numeric), 2);
   end $$;


-- second procedure for decreasing 
CREATE OR REPLACE PROCEDURE decrease_price_by_10_percentage() 
language plpgsql
AS $$
   begin
      update product set unit_price = round(cast(0.9 * unit_price as numeric), 2);
   end $$;

-- select * from product;
 
-- To call the procedure you simply do:
CALL increase_price_by_10_percentage();
call decrease_price_by_10_percentage();

-- Query 11: Optimizing DB performance: SQL Indexing...
/*
What is indexing ?
Indexing is a technique of optimizing SQL queries. 
-- Indexing is usually prefered for larger tables for efficiency of a database 
Link: https://codedamn.com/news/sql/advanced-indexing-strategies-sql-optimal-performance 

An index is a database object that helps to speed up the search and retrival of data from a table. By creating index on 
one or more columns the db engine can quickly locate the required rows and does not have to scan the entire table. 
An indexing internally uses algorithms such as Binary search, B-Tree, zig-zag algorithms, etc. to make optimization.



-- Types of indexes:
1. Clustered index
2. Non-Clustered Index
3. Covering Index
4. Filtered Index
5. Full-Text Index

Indexing best practices (3 Points):

#Point1: Selective Indexing
It's important to be selective when creating indexes. Focus on columns that are frequently used in WHERE clauses, JOIN
conditions, and ORDER BY clauses. Indexing columns that are not commonly used in quereis can lead to unnecessary overhead 
and limited performance benefits. 

#Point 2:  In creating Compositie Indexes
A composite index is an index that includes multiple columns. When creating composite indexes, consider the order of the columns in the index. The most selective column should be the first one in the index, followed by the second most selective, and so on. This ordering allows the database engine to efficiently filter rows using the index, leading to improved performance.

Here's an example of creating a composite index:

CREATE INDEX idx_customers_city_country
ON customers (city, country);


# Point 3: Index Maintenance
Regular index maintenance is crucial for maintaining optimal performance. Over time, as data is added, updated, or deleted, indexes can become fragmented, leading to reduced query performance. To address this issue, periodically rebuild or reorganize your indexes. In SQL Server, you can use the ALTER INDEX statement to perform index maintenance:

-- Rebuild an index
SQL(MySQL)> ALTER INDEX idx_customers_city_country ON customers REBUILD;
POSTGRES> REINDEX INDEX index_name;

-- Reorganize an index
ALTER INDEX idx_customers_city_country ON customers REORGANIZE;

-- To create index
Syntax: CREATE INDEX index_name on table_name (column1, column2, ....);

-- Once the index is created database will automatically perform optimiation on select/retrive
on the table you have created index on. You don't have to reference the index. 

Does index automatically update on insert/update/delete ? If so what is rebuild index?
Solution: https://stackoverflow.com/questions/15381882/does-inserting-updating-deleting-record-auto-update-indexes
Yes it does automatically update the index, however, when the tables gets bigger and index 
gragment gets too high the indexes also become in efficient in such cases we have to rebuld the index so
we can rearrange the indexing values in the disk.

When index fragmentation becomes too high, indexes will be very inefficient. 
There is need to rebuild index.
Let SQL Server Tell You Which Indexes to Rebuild
Rebuilding an index drops and re-creates the index. This removes fragmentation, 
reclaims disk space by compacting the pages based on the existing fill factor setting, and reorders the index rows in contiguous pages.
Reorganizing and Rebuilding Indexes

*/

-- Create index
---- Execution Time: 85ms 
SELECT 
      customer_id, count(product_id) from orders 
group by customer_id
order by customer_id asc;


-- Create index
CREATE INDEX idx_orders on orders(customer_id, product_id);

---- Execution time: After indexing- 47ms
SELECT 
      customer_id, count(product_id) 
from orders 
group by customer_id
order by customer_id asc;

-- Droping indexing
DROP INDEX idx_orders;

-- REINDEX rebuilds an index using the data stored in the index's table, replacing the old copy of the index. There are several scenarios in which to use REINDEX:
-- An index has become corrupted, and no longer contains valid data. Although in theory this should never happen, in practice indexes can become corrupted due to software bugs or hardware failures. REINDEX provides a recovery method.
-- Rebuilding index
ALTER INDEX idx_orders ON orders REBUILD; -- this does not work in postgres.
REINDEX INDEX idx_orders;






/*
Avoid indexing in :
1. Smaller tables 
2. Tables that have lot of batch updates or inserts
3. Columns that have a lot of null values.
4. Columns/Attributed that are changed(manipulated) frequently.
5. In attributes which are not used in query state or conditions.
(E.g. You have a column that you do not use for filter but have as an index attribute)
*/

-- Query 12: SQL functions
-- Some common functions date time function - 
-- String functions - Length(), Trim(),LOWER(), UPPER() {UCASE() in MySQL}, LOCATE(), ascii('charvalue'), LEFT('STR', length), RIGHT('STR', length) SUBSTRING('STR', START, LENGTH), REVERSE(), LTRIM(), RTRIM(), FORMAT('0.08','Percent') 
-- Numeric functions CEIL(), COS(), SIN(), FLOOR(), EXP(), GREATEST(), LOG()
-- Statistical functions - avg(), sum(), count(), min(), max(), var()/variance(), stddev()/stddev_pop(), corr(), covar_pop(), percentile_cont()
-- Others: CONCAT(), COALESCE(), CAST()

-- Functions help to perform certain operations on values in a column

-- String function: Lets get lentgh
-- select first_name, last_name , Length(first_name) as length_fname from customer;

-- substr
select substring(first_name, 1, 5) as substring_fname,  -- Starting index is 1, lenght =5
	    LEFT(first_name, 3) as left_fname, -- 3 character from left
	    RIGHT(first_name, 3) as right_fname, -- 3 character from right
       lower(first_name) as lower_fname,  
	    TRIM(first_name) AS trim_fname,
	    reverse(first_name) as reverse_fname,
	    upper(first_name) as upper_fname, -- UCASE(first_name) in MySQL for upper case
	    ascii(first_name) as ascii_fname --- returns ascii value of first character in first_name
from customer;   

-- -- Numeric functions
select unit_price, 
		CEIL(unit_price) as ceil_price, 
		floor(unit_price) as floor_price,
		EXP(unit_price) as exponential_price,
		SIN(unit_price) as sin_price,
		ROUND(unit_price) as round_price
from product;


-- Statistical function
SELECT avg(unit_price) as avg_price, 
  	   sum(unit_price) as sum_price, 
	   count(unit_price) as count_price, 
	   min(unit_price) as min_price, 
	   max(unit_price) as max_price, 
	   variance(unit_price) as var_price, 
	   stddev_pop(unit_price) as stddev_price
from product;


-- Others: Concat(), COALESCE() AND CAST('column_value' as [type:int, varchar,..]) 

SELECT 
      CONCAT(name,' ', category_name) as full_name,
	   COALESCE(category_name, 'UNKNOWN_CATEGORY') as coalesce_fname, 
	   CAST(unit_price as varchar) as cast_price
from product;



-- Lets ignore this pivot thing for now. 
-- This one will not be that much important 
-- Query 13: Pivot (transform rows of data into columns) and unpivot 
-- Simple pivot using group
-- select  ordered_date,
-- 		sum(item_ordered_count) as count_total_orders_by_date,
-- 		count(item_ordered_count) as count_single_orders
-- from orders
-- group by ordered_date;

-- SELECT [Date] AS 'Day',
-- [Sammich], [Pickle], [Apple], [Cake]
-- FROM (
--     SELECT [Date], FoodName, AmountEaten FROM FoodEaten
-- ) AS SourceTable
-- PIVOT (
--     MAX(AmountEaten)
--     FOR FoodName IN ([Sammich], [Pickle], [Apple], [Cake])
-- ) AS PivotTable

-- For unpivot: you use unpivot function which will not be used here. 






