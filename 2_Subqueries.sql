-- SubQueries
/*
Defination:
A subquery is a query nested within another query. The subquery can be nested inside a SELECT, INSERT, UPDATE, or DELETE statement, or inside another subquery.


Usage:
- Adding a new column to result expression of main query
- Creating a filter
- Creating a consolidated source
- Retrieving data from multiple tables


Syntax:
1. Syntax1:
Select [columns] from ([sub_query expression]) sub

2. Syntax2:
Select [columns] from abc where [column] in ([sub_query expression])

3. Syntax3:
Select [columns] from abc where [column] = ([sub_query min/max() expression])


Code Example:
*/


-- Example 1: Subquery in FROM statement - Let's get all the orders whose category is 'Fruit' and order more than 1

select sub.* from (
 select orders.*, category_name, name 
    from orders 
    inner join product 
    on orders.product_id=product.product_id
 where category_name='Fruit'
) sub
where sub.item_ordered_count > 1;




-- Example 2: Using the IN statement - let's filter all the orders where item is fruit(without joins)

select * from orders 
where product_id in (select product_id from product where category_name='Fruit');




-- Example 3: Using equal to (=) Operator - Select any one ordered item with maximum unit price 

select * from orders 
where product_id = (select product_id from product order by unit_price desc limit 1 );
