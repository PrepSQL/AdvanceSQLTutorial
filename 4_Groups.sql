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


-- Example 2: lets calculate the total cost and get sum and average sales cost of an item
select  product_id, 
        sum(total_cost) as total_sales, 
        sum(item_ordered_count) as total_item_sold,  
        sum(total_cost)/sum(item_ordered_count) as average_cost 
        from  (
            select orders.item_ordered_count, orders.product_id, 
            orders.item_ordered_count * unit_price as total_cost from orders
            inner join product
            on orders.product_id=product.product_id
        ) sub
group by sub.product_id


-- Example 3: checking if there are duplicate rows(/items) or not. (Has a customer bought the same item?)
select 
    customer_id, 
    product_id, 
    count(*) as duplicate_count 
from orders
group by customer_id, product_id, item_ordered_count
having count(*)>1;