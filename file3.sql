-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, sum(orders_details.quantity*pizzas.price) as Revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by Revenue desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category,round(sum(orders_details.quantity*pizzas.price),2)/
(select round(sum(orders_details.quantity*pizzas.price),2) from
orders_details
join pizzas on pizzas.pizza_id=orders_details.pizza_id)*100 as Percentage
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.category;

-- Analyze the cumulative revenue generated over time.
select order_date, sum(Revenue)
over(order by order_date) as cum_revenue
from
(select orders.order_date, sum(orders_details.quantity*pizzas.price) as Revenue
from orders_details join pizzas
on orders_details.pizza_id=pizzas.pizza_id
join orders on orders.order_id=orders_details.order_id
group by orders.order_date) as Sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name,category, Revenue from
(select category, name, Revenue,
rank()over(partition by category order by Revenue desc) as rn from
(select pizza_types.category, pizza_types.name, sum((orders_details.quantity)*pizzas.price) as Revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where rn<=3;