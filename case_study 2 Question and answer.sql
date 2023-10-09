use 8_week;
show tables;

/* question 1 :> How many pizzas were ordered? */

select * from customer_orders;
select count(distinct(order_id)) from customer_orders;


-- Question 2 How many unique customer orders were made?

select * from customer_orders;

select count(distinct(customer_id)) from customer_orders;


-- Question 3 How many successful orders were delivered by each runner?

show tables;
select * from customer_orders;
select * from runner_orders;


select  runner_id,count(runner_id) from runner_orders 
where cancellation != 'Restaurant Cancellation' and cancellation != 'Customer Cancellation'
group by runner_id;


-- Question 4 How many of each type of pizza was delivered

select pizza_id,pizza_name,count(pizza_name) total_count_pizza_delivered from customer_orders inner join pizza_names using(pizza_id)
group by pizza_id,pizza_name;


-- Question 5 How many Vegetarian and Meatlovers were ordered by each customer?
show tables;
select * from customer_orders;
select * from pizza_names;
select * from runner_orders;

select customer_id,pizza_name ,count(customer_id),count(pizza_name) from customer_orders inner join pizza_names using(pizza_id) 
group by customer_id,pizza_name
order by customer_id;

-- Question 6 What was the maximum number of pizzas delivered in a single order ? 
show tables;
select * from customer_orders;

select order_id,count(order_id) as new from customer_orders 
group by order_id
order by new desc limit 1;






