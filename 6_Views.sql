 -- Views and Materialized Views
/*
Defination:
View: A view is a virtual table based on the result-set of an SQL statement.

Materialized View:
A materialized view is a pre-computed data set derived from a query specification 
(the SELECT in the view definition) and stored for later use. Because the data is pre-computed, 
querying a materialized view is faster than executing a query against the base table of the view.

Difference between View and Materialized View:
The data in a view is always up-to-date because it's derived directly from the source tables each time it's accessed. 
A materialized view, on the other hand, stores the results of a specific query as a physical table in the database.

A normal view when queried is computed everytime and a materialized view is precomputed so they give 
a boost in performance. 

SQL View:
A view is a virtual table defined by a SQL query. It does not store data physically but provides a way to look at data from one or more tables.
Materialized View:
A materialized view (also known as a snapshot) is a database object that stores the result of a query physically. Unlike a regular view, it holds data on disk and needs to be refreshed to stay updated.

Usage:
- Saving computing a query multiple times using materialized view
- Simplifying query and reducing re-write of same logic
- Separate table like operation for analytics and other non-table related query.

Syntax:
CREATE [MATERIALIZED] VIEW as (
    ...SQL query....
);


Code Example:
*/


-- Example 1:View: Joining multiple tables(3 tables)
CREATE VIEW TotalSalesView as (
    SELECT  c.customer_id, 
            CONCAT(c.first_name, ' ', c.last_name) as FullName, 
            o.product_id, 
            o.order_id, 
            o.item_ordered_count,
            p.name as ProductName, 
            p.unit_price as UnitPrice,
            CAST(o.item_ordered_count * p.unit_price AS NUMERIC) as TotalSalesPrice
    from customer c
    inner join orders o
    on c.customer_id=o.customer_id
    inner join product p
    on p.product_id=o.product_id
);

-- Querying a View
SELECT * FROM TotalSalesView;


--Example 2: Materialized View.  
CREATE MATERIALIZED VIEW TotalSalesMV as (
    SELECT 
        c.customer_id, 
        CONCAT(c.first_name, ' ', c.last_name) as FullName, 
        o.product_id, 
        o.order_id, 
        o.item_ordered_count,
        p.name as ProductName, 
        p.unit_price as UnitPrice,
        CAST(o.item_ordered_count * p.unit_price AS NUMERIC) as TotalSalesPrice
    from customer c
    inner join orders o
    on c.customer_id=o.customer_id
    inner join product p
    on p.product_id=o.product_id
);

SELECT * FROM TotalSalesMV;