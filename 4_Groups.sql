 -- Aggregation and Groupings
/*
Defination:
Group by: A group by clause is use to group same rows values into summary rows. 

Aggregation: Aggregation is the task of collecting a set of values to return a single value which is done usually with 
the help of aggregate function such as SUM, COUNT, AVG, etc.

Usage:
- Group data and perform operation on them
- Filtering data by each unique value (when grouping it groups by unique combination(/s) of value(/s))
- Aggregate can be used to get intersting single information about the data(or simply to aggregate values).

Syntax:
SELECT [column_name(s)]
FROM [table_name]
[WHERE condition]
GROUP BY [column_name(s)]
[HAVING condition(s)]
[ORDER BY [column_name(s)]]


Code Example:
*/


-- Example 1: let's just count total items sold for different product
select 
    count(item_ordered_count) as total_sales_number, 
    product_id
from orders
group by product_id;


-- Example 2: lets calculate total revenue per product.
select 
    orders.product_id, 
    sum(orders.item_ordered_count) as total_items_sold, 
    sum(orders.item_ordered_count * unit_price) as total_revenue_per_product
from orders
inner join product
on orders.product_id=product.product_id
group by orders.product_id
order by orders.product_id


-- Example 3: checking if there are duplicate rows(/items) or not. (Has a customer bought the same item?)
select 
    customer_id, 
    product_id, 
    count(*) as duplicate_count 
from orders
group by customer_id, product_id, item_ordered_count
having count(*)>1;