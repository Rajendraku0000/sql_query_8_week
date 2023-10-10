use 8_week;
show tables;

/* question 1 :> How many pizzas were ordered? */

select * from customer_orders;
select count(*) from customer_orders;



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
select * from customer_orders;

select pizza_id,pizza_name,count(pizza_name) total_count_pizza_delivered from customer_orders inner join pizza_names using(pizza_id)
group by pizza_id,pizza_name;


SELECT   p.pizza_name,   COUNT(c.pizza_id) AS delivered_pizza_count
FROM customer_orders AS c JOIN runner_orders AS r   ON c.order_id = r.order_id
JOIN pizza_names AS p  ON c.pizza_id = p.pizza_id
WHERE r.distance != 0
GROUP BY p.pizza_name;


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


-- 7 For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select * from customer_orders;

select customer_id,count(distinct order_id) from customer_orders
where order_id in (select order_id from customer_orders
where exclusions not in ('','null'))
or order_id in (select order_id from customer_orders
where extras not in ('','null'))
group by customer_id;

SELECT c.customer_id,
  SUM(
    CASE WHEN c.exclusions <> ' ' OR c.extras <> ' ' THEN 1
    ELSE 0
    END) AS at_least_1_change,
  SUM(
    CASE WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1 
    ELSE 0
    END) AS no_change
FROM customer_orders AS c JOIN runner_orders AS r   ON c.order_id = r.order_id
WHERE r.distance != 0 GROUP BY c.customer_id
ORDER BY c.customer_id;





-- 8 How many pizzas were delivered that had both exclusions and extras?
select count(*) total_pizza_delivered from customer_orders
where exclusions is not null and exclusions not like "null" and exclusions not like '' and extras not like '';




-- Question 9 What was the total volume of pizzas ordered for each hour of the day?
select * from customer_orders;

select hour(order_time),count(order_id) from customer_orders
group by hour(order_time)
order by  hour(order_time);



-- 10 What was the volume of orders for each day of the week?
select dayofweek(order_time) day_of_week,count(order_id) as counts from customer_orders
group by dayofweek(order_time);