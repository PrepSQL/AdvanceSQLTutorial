 -- Joins
/*
Defination:
A join clause is used to combine rows from two or more tables. There are various types of joins
1. left join
2. right join
3. inner join
4. outer join(full outer join)
5. cross join
6. self join


Self join:
A type of join used to compare rows within the same table.

Cross join: 
A cross join is a type of join that returns the Cartesian product of rows from the tables in the join. 
In other words,it combines each row from the  first table with each row from the second table.


Usage:
- To combine data from multiple sources
- To filter data and get relevant data
- Dealing with hierarchical data using self join

Syntax:
SELECT [column(s)]
FROM table1
[join_type] join Table2
ON CONDITION

Code Example:
*/
-- Example 1: Let's check the player name along with their parent name using self join

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



-- Example 2: Cross join between customer and product

SELECT customer_id,
       CONCAT(first_name,' ', last_name) as FullName,
       product_id,
       name as ProductName,
       category_name
from customer
cross join product;


-- Example 3: Inner, left, right, outer joins between customer and orders

SELECT 
    customer.customer_id, 
    CONCAT(first_name, ' ', last_name) as FullName, 
    product_id,
    order_id,
    item_ordered_count
from customer
inner join orders
on customer.customer_id=orders.customer_id;
