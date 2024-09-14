-- CTE (Common Table Expression)

/*

Defination:
A Common Table Expression(CTE) in SQL is a temporary result set that can be referenced within a SQL statements such as 
SELECT, INSERT, UPDATE or DELETE. A CTE expression start using a WITH clause.

A recursive CTE is a query that continuously references a previous result until it returns an empty result. 
It's best used as a convenient way to extract information from hierarchical data.


Usage:
- Simplify complex query / Better structure query
- Avoid duplicate subqueries
- Create recursive query
- Improve readability of SQL statement


Syntax:
1. Simple CTE syntax

WITH expression_name [ ( column_name [,...n] ) ] 
AS 
( CTE_query_definition )


2. For multiple CTE expression with single WITH statement

WITH expression_name_1 AS
(CTE query definition 1)

[, expression_name_X AS
   (CTE query definition X)
 , etc ]

Code Example:

*/



-- Recursive CTE : Example - SUM of [1, 2, 3 .... 99, 100] recursively

WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t;




-- Non-Recursive CTE
WITH top_sales as (
	SELECT product_id, sum(item_ordered_count) as total_count from orders
	group by product_id
)

Select name, category_name, total_count, 
round(cast(unit_price * total_count as numeric), 2) as total_amount 
from product
inner join top_sales
on product.product_id=top_sales.product_id
order by total_amount desc;