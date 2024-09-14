 -- Optimizing DB performance using Indexing
/*
Defination:
An index is a database object that helps to speed up the search and retrival of data from a table. By creating index on 
one or more columns the db engine can quickly locate the required rows and does not have to scan the entire table. 
An indexing internally uses algorithms such as Binary search, B-Tree, zig-zag algorithms, etc. to make optimization.


Usage:
- To optimize the performance of quering the database.

Indexing Best Practices:

Point 1: Selective Indexing
It's important to be selective when creating indexes. Focus on columns that are frequently used in WHERE clauses, JOIN
conditions, and ORDER BY clauses. Indexing columns that are not commonly used in quereis can lead to unnecessary overhead 
and limited performance benefits. 

#Point 2:  In creating Compositie Indexes
A composite index is an index that includes multiple columns. 
When creating composite indexes, consider the order of the columns in the index. 
The most selective column should be the first one in the index, followed by the second most selective, and so on. 
This ordering allows the database engine to efficiently filter rows using the index, leading to improved performance.

Here's an example of creating a composite index:

CREATE INDEX idx_customers_city_country
ON customers (city, country);

# Point 3: Index Maintenance
Regular index maintenance is crucial for maintaining optimal performance. 
Over time, as data is added, updated, or deleted, indexes can become fragmented, leading to reduced query performance. 
To address this issue, periodically rebuild or reorganize your indexes. 
In SQL Server, you can use the ALTER INDEX statement to perform index maintenance.

When index fragmentation becomes too high, indexes will be very inefficient. 
There is need to rebuild index.

-- Rebuild an index
SQL(MySQL)> ALTER INDEX idx_customers_city_country ON customers REBUILD;
POSTGRES> REINDEX INDEX index_name;

Syntax:
-- To create index
Syntax: CREATE INDEX index_name on table_name (column1, column2, ....);

-- To rebuild an Index
[In MySQL] > ALTER INDEX [index_name] ON [table_name] REBUILD;
[In POSTGRES] > REINDEX INDEX index_name;

-- Reorganize an index- it defragments the leaf level of clustered and nonclustered indexes on tables and views by physically
reordering the leaf-level pages to match the logical, left to right, order of the leaf nodes.

[In MySQL] > ALTER INDEX [index_name] ON [table_name] REORGANIZE;


When to avoid indexing:

1. Smaller tables 
2. Tables that have lot of batch updates or inserts
3. Columns that have a lot of null values.
4. Columns/Attributed that are changed(manipulated) frequently.
5. In attributes which are not used in query state or conditions.
(E.g. You have a column that you do not use for filter but have as an index attribute)

Code Example:
*/


-- Example 1: Create index
--Before Indexing: Execution Time: 85ms 
SELECT customer_id, count(product_id) from orders 
group by customer_id
order by customer_id asc;

-- Lets index:
CREATE INDEX idx_orders on orders(customer_id, product_id);

--After Indexing: Execution time: 47ms
SELECT customer_id, count(product_id) from orders 
group by customer_id
order by customer_id asc;


-- Reindexing the index
-- REINDEX INDEX idx_orders;

-- Drop index 
DROP INDEX idx_orders;