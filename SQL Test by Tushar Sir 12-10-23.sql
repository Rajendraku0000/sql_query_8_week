 /* Q1 How many movies a user has worked
    Actor and film_actor table
    - Number of movies should me more than 3  */
    
use sakila;
select * from actor;
select * from film_list;
select * from film_actor;
    
select actor_id,count(actor_id) from film_actor inner join film_list on film_actor.film_id= film_list.FID 
group by actor_id
having count(actor_id) > 3 ;
    
    

/* Q2 Get all the information of user with the maximum and minium salary
    (id , name, email, salary) */
    use sakila;
    /*drop table emp;
    create table emp(id int,name varchar(20),email varchar(20),salary int);
    
    select * from emp;
    
    insert into emp values(1,'rajendra','raj@gmail.com',50000);
    insert into emp values(2,'govind','gov@gmail.com',55000);
    insert into emp values(3,'navi','navi@gmail.com',60000);
    insert into emp values(4,'subham','subham@gmail.com',65000);
    insert into emp values(5,'akshay','akshay@gmail.com',70000);
    insert into emp values(6,'ramgopal','ram@gmail.com',75000);
    insert into emp values(7,'vikas','vikas@gmail.com',80000);
    insert into emp values(8,'nishchal','nish@gmail.com',85000);  */
    
    
    select * from emp
    where salary = (select max(salary) from emp )
    or salary = (select min(salary) from emp);

select * from emp ;


/* Q3 Calculating the total population where the total population should be more
than 1000  and there should be more than 2 city in each code  */
use world;
show tables;
select * from city;


select CountryCode,count(ID) as total_city_in_country, sum(Population) as total_population_each_country from city 
group by CountryCode
having  count(id) > 2 and sum(Population)>1000;



/* Q4 Finding all the countrycode where
the number of city in each country should be greater than all and equal to  the
city present in each country code ('NLD','AFG','ARE','BGD') ( use country table ) */

select countrycode,count(countrycode) from city 
group by CountryCode
having count(countryCode) >all (select count(CountryCode) as new_columns from city
								where CountryCode = 'AFG' or CountryCode = 'NLD' or CountryCode = 'ARE' or CountryCode = 'BGD' 
group by CountryCode)  ;


/* 5 Create a table with  id, name, salary, dept
insert all the data for all the column value

- Get the id, salary and the salary_percent of every employee where salary_percent should be percentage with employee_id 2; */

use sakila;
drop table emp_record;
create table emp_record(id int, name varchar(20),salary int,dept varchar(20));
insert into emp_record values(1,'rajendra',10000,'hr');
insert into emp_record values(2,'subham',20000,'marketing');
insert into emp_record values(3,'navi',30000,'data');
insert into emp_record values(4,'akshay',40000,'web');
insert into emp_record values(5,'govind',50000,'new');
select * from emp_record;

select id,name,salary,concat(round((salary/(select salary from emp_record where id = 2)*100),1), " %") from emp_record;



/* 6  use salaries table
find out the the max, sum, avg salary for each person in every month  from the from_date column
that should have the to_date year to be before 1999 */

use employees;

select * ,
year(to_date) as year ,
TIMESTAMPDIFF(MONTH, from_date,to_date) as total_month ,
(salary / TIMESTAMPDIFF(MONTH, from_date,to_date)) as par_month,
avg(salary) over(partition by emp_no ) as average  from salaries
where year(to_date) < 1999 
;

select * from salaries;