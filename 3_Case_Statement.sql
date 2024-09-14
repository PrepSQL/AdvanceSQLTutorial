 -- CASE Statement
/*
Defination:
A CASE statement is the SQL way of handling if/then logic. A case startment starts with CASE clause and end with END clause
and has one or more WHEN ... THEN... STATEMENT and an optional ELSE statement.


Usage:
- To handle the if/then logic
- To transform data (using CASE)

Syntax:
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;

Code Example:
*/


-- Example 1: Let's categorize product with price, 
            -- price <= $1 as 'Low Price'
            -- price > 1 and price <=3 'Average price' and
            -- price > 3 'High price'


SELECT (CASE 
		WHEN unit_price <= 1 THEN 'Low Price'
		WHEN unit_price > 1 and unit_price <= 3 THEN 'Average Price' 
		WHEN unit_price >3 THEN 'High Price'
		end) as price_category,
		product_id, 
		unit_price
from product;



-- We can also use CASE in combination of grouop by clause - 
-- Lets use cte, case and group by to summarize the values
WITH cte as (SELECT (CASE 
		WHEN unit_price <= 1 THEN 'Low Price'
		WHEN unit_price > 1 and unit_price <= 3 THEN 'Average Price' 
		WHEN unit_price >3 THEN 'High Price'
		end) as price_category,
		product_id, 
		unit_price
from product)

-- go further by grouping these items. 
select 
    price_category, 
    count(orders.item_ordered_count) as item_count 
from orders
inner join cte
on cte.product_id=orders.product_id
group by price_category;

