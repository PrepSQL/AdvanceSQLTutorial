 -- Window Functions
/*
Defination:
A window function is a function which uses values from one or more rows to return a value for each row. 
This contrasts with aggregate function, which returns a single value for multiple rows.
Windows function have OVER() clause; any function without an OVER() clause is not a window function, rather an aggregate or 
single-row function.

Some Common Windows Functions:
1. SUM() OVER() - Computing running total.
2. AVG() OVER() - Computing a moving average.
3. RANK() OVER () - Rank items within the ordered partition or group. If rows are assigned the same rank it will skip count for next rank.
4. DENSE_RANK() ORVER() - gives consecutive ranking for ordered partition. It does not skip ranking. If 3 item has rank 2, 4th item will start from 3.
5. ROW_NUMBER() OVER() - No. of given rows
6. NTILE() OVER() - breaks a table into a specificed number of approximately equal groups or buckets.
7. LEAD() OVER() or LAG() OVER() - Accesses values ahead of the row or before the rows. How many item to LEAD/LAG is specified in LEAD/LAG() clause


Usage:
- Aggregate values
- Finding patterns in dataset with Lead and Lag
- Table statistics 

Syntax:
SELECT [column(s)]
SUM()/AVG()/... OVER(..partition by [columns] order by [columns])
FROM TableName

Code Example:
*/


-- Example 1: SUM() and Avg()
-- SUM() OVER()
SELECT product_id, name, unit_price,
SUM(unit_price) OVER() as TotalUnitPrice
FROM product;

-- AVG() ORVER()
SELECT product_id, name, unit_price,
AVG(unit_price) OVER() as AveragePrice
FROM product;

-- Example 2: RANK() OVER()
select 
    product_id, 
    name, 
    unit_price, 
    category_name,
    RANK() OVER(partition by category_name order by unit_price) as RankItem
FROM product
order by category_name;


--Example 3: NTILE()
SELECT 
    (NTILE (4) OVER ()) AS grouped_item,
    category_name,
    product_id, 
    name
FROM product;

-- Example 4: LAG(), LEAD()
SELECT
    LAG(first_name, 1) OVER(ORDER BY first_name) "prev fname",
    first_name, 
    LEAD(first_name, 1) OVER(ORDER BY first_name) "next fname"
FROM customer
ORDER BY first_name;
