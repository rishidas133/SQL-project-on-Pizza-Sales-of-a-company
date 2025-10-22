-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select orders.order_date, sum(orders_details.quantity) as Total
from orders join orders_details
on orders.order_id=orders_details.order_id
group by orders.order_date order by Total desc
limit 10;