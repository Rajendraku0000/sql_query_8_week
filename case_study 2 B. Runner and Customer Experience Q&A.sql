use 8_week;
show tables;

--  Question 1 How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
select * from runners;

select new_columns as week , count(new_columns) as sighup from (
select case
when weekofyear(registration_date) = 53 then 1
when weekofyear(registration_date) = 1 then 2
when weekofyear(registration_date) = 2 then 3
else "error"
end new_columns,registration_date from runners) new_table group by new_columns ;

 --  Question 2 What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
 select * from customer_orders;
 select * from runner_orders;
 select runner_id,avg(new_column) from (
select *,TIMESTAMPDIFF(minute,order_time,pickup_time) as new_column from customer_orders inner join runner_orders using(order_id)) as new_table
group by runner_id;



-- 3 Is there any relationship between the number of pizzas and how long the order takes to prepare?
select pizza_order,avg(time_avg) from  (
select order_id,count(pizza_id) as pizza_order,avg(new_column)  as time_avg from (
select *,TIMESTAMPDIFF(minute,order_time,pickup_time) as new_column 
from customer_orders inner join runner_orders using(order_id) )as new_table
group by order_id) as new_table2 
group by pizza_order;


--  4 What was the average distance travelled for each customer?

select customer_id,avg(distance) from runner_orders inner join customer_orders using(order_id)
where distance != 0
group by customer_id;


-- 5 What was the difference between the longest and shortest delivery times for all orders?

select * from runner_orders;

select max(duration)-min(duration) from runner_orders
where duration != 'null' ;


-- 6 What was the average speed for each runner for each delivery and do you notice any trend for these values?

select *,avg(distance) over(partition by runner_id) from (
select * from (
select *, ifnull(cancellation , 0 ) new_column from runner_orders ) new_table
where new_column != 'Restaurant Cancellation' and new_column != 'Customer Cancellation' ) new_table1 ;




-- 7 What is the successful delivery percentage for each runner?
select * from runner_orders;
select * from customer_orders;

SELECT runner_id, 
ROUND(100 * SUM(
    CASE WHEN distance = 0 THEN 0
    ELSE 1 END) / COUNT(*), 0) AS success_perc
FROM runner_orders
GROUP BY runner_id;