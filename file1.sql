SELECT * FROM pizza_project;

create table orders(
order_id int primary key,
order_date date not null,
order_time time not null
);

create table orders_details(
order_details_id int primary key,
order_id int not null,
pizza_id text not null,
quantity smallint
);

--  Retrieve the total number of orders placed.
select count(order_id) as Total_orders from orders;
 
--  Calculate the total revenue generated from pizza sales.
select
round(sum(orders_details.quantity*pizzas.price),2) as Total_sales
from orders_details join pizzas
on orders_details.pizza_id=pizzas.pizza_id;

-- Identify the highest-priced pizza.
select * from pizzas
order by price desc
limit 1;

-- Identify the most common pizza quantity ordered.
select quantity, count(order_details_id)
from orders_details group by quantity;

-- Identify the most common pizza size ordered.
select pizzas.size, count(orders_details.order_details_id) as T_Count
from pizzas join orders_details
on pizzas.pizza_id=orders_details.pizza_id
group by pizzas.size order by T_Count desc;

-- --List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,sum(orders_details.quantity) as Total_quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by Total_quantity desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,sum(orders_details.quantity) as Total_quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by Total_quantity desc;

-- Determine the distribution of orders by hour of the day.
select hour(order_time), count(order_id) as Total from orders  
 group by hour(order_time) order by Total desc;
 




