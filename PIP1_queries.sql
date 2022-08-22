Select count(*) from customer_orders;

select count(distinct customer_id) from customer_orders;

Select count(*) from runner_orders where cancellation not in ("Customer Can","Restaurant Ca") or cancellation = null;
Select * from runner_orders where cancellation not in ("Customer Can","Restaurant Ca");
Select count(*) from runner_orders where cancellation != "Customer Can";
select * from runner_orders;

select pizza_name,count(pizza_name) from customer_orders c join pizza_names p on c.pizza_id=p.pizza_id group by pizza_name;
select customer_id,pizza_name,count(pizza_name) from customer_orders c join pizza_names p on c.pizza_id=p.pizza_id group by customer_id,pizza_name;
select runner_orders.order_id, count(customer_orders.pizza_id) as Singledel
from runner_orders
inner join customer_orders
on customer_orders.order_id = runner_orders.order_id
where runner_orders.distance is not null
group by runner_orders.order_id
order by singledel desc
limit 1;



select customer_orders.customer_id, 
sum(if((exclusions is not null and exclusions  !=0) or (extras is not null and extras !=0),1,0))
as changesmade,
sum(if((exclusions is null or exclusions =0) and (extras is null or extras =0),1,0))
as Nochanges
from customer_orders 
inner join runner_orders 
on runner_orders.order_id = customer_orders.order_id
where runner_orders.distance != 0
group by customer_orders.customer_id;

select customer_orders.customer_id, 
sum(if((exclusions is not null and exclusions  !=0) and (extras is not null and extras !=0),1,0))
as bothtype
from customer_orders 
inner join runner_orders 
on runner_orders.order_id = customer_orders.order_id
where runner_orders.distance != 0
group by customer_orders.customer_id;

select extract(hour from order_date) as hourdata, count(order_id) as total
from customer_orders
group by hourdata
order by hourdata;

select extract(day from order_date) as eachdaydata, count(order_id) as total
from customer_orders
group by eachdaydata
order by eachdaydata;

-- current status
run_id|rule_id|rule_status |time_created
1     |1000   | OPEN       |20220201T08:11:12
2     |1000   | CLOSED     |20220131T08:11:12
3     |1001   | CLOSED     |20220131T08:11:12

Select Distinct(rule_status) * from table current_status
where rule_status = opened or rule_status = closed;

select runner_id,round(avg(timestampdiff(minute,order_date, pickup_time)),1) as AvgTime
from runner_orders
inner join customer_orders
on customer_orders.order_id = runner_orders.order_id
where distance != 0
group by runner_id
order by AvgTime desc;

select c.customer_id, round(avg(r.distance),1) as AvgDistance
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
where r.distance != 0
group by c.customer_id;

select c.order_id, count(c.order_id) as PizzaCount, round((timestampdiff(minute, order_date, pickup_time))) as Avgtime
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
where distance != 0 
group by c.order_id;


select c.order_id, order_time, pickup_time, timestampdiff(minute, order_time,pickup_time) as TimeDiff1
from customer_orders1 as c
inner join runner_orders1 as r
on c.order_id = r.order_id
where distance != 0;


select c.order_id, order_date, pickup_time, timestampdiff(minute, order_date,pickup_time) as TimeDif
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
where distance != 0;

-- avg distance
select c.customer_id, round(avg(r.distance),1) as AvgDistance
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
where r.distance != 0;

select c.order_id, order_date, pickup_time, timestampdiff(minute, order_date,pickup_time) as TimeDiff1
from customer_orders as c
inner join runner_orders as r
on c.order_id = r.order_id
where distance != 0
order by TimeDiff1
 desc limit 1;

select runner_id, order_id, round(distance *60/duration,1) as speedKMH
from runner_orders
where distance != 0;

select runner_id, sum(if (distance != 0 ,1 , 0) ) as percsucc, count(order_id) as TotalOrders
from runner_orders;

-- What was the average distance traveled for each customer?

select c.customer_id ,round(avg(r.distance),1)
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.distance != 0;






create table pizza_recipes1 
(
 pizza_id int,
    toppings int);
insert into pizza_recipes1
(pizza_id, toppings) 
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,8),
(1,10),
(2,4),
(2,6),
(2,7),
(2,9),
(2,11),
(2,12);

-- 18
select pizza_names.pizza_name,pizza_recipes1.pizza_id, pizza_toppings.topping_name
from pizza_recipes1
inner join pizza_toppings
on pizza_recipes1.toppings = pizza_toppings.topping_id
inner join pizza_names
on pizza_names.pizza_id = pizza_recipes1.pizza_id
order by pizza_name, pizza_recipes1.pizza_id;

-- 19
-- 20
-- 21
select customer_orders.order_id, customer_orders.pizza_id, pizza_names.pizza_name, customer_orders.exclusions, customer_orders.extras, 
case
when customer_orders.pizza_id = 1 and (exclusions is null or exclusions=0) and (extras is null or extras=0) then 'Meat Lovers'
when customer_orders.pizza_id = 2 and (exclusions is null or exclusions=0) and (extras is null or extras=0) then 'Veg Lovers'
when customer_orders.pizza_id = 2 and (exclusions =4 ) and (extras is null or extras=0) then 'Veg Lovers - Exclude Cheese'
when customer_orders.pizza_id = 1 and (exclusions =4 ) and (extras is null or extras=0) then 'Meat Lovers - Exclude Cheese'
when customer_orders.pizza_id=1 and (exclusions like '%3%' or exclusions =3) and (extras is null or extras=0) then 'Meat Lovers - Exclude Beef'
when customer_orders.pizza_id =1 and (exclusions is null or exclusions=0) and (extras like '%1%' or extras =1) then 'Meat Lovers - Extra Bacon'
when customer_orders.pizza_id=1 and (exclusions like '1, 4' ) and (extras like '6, 9') then 'Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers'
when customer_orders.pizza_id=1 and (exclusions like '2, 6' ) and (extras like '1, 4') then 'Meat Lovers - Exclude BBQ Sauce,Mushroom - Extra Bacon, Cheese'
when customer_orders.pizza_id=1 and (exclusions =4) and (extras like '1, 5') then 'Meat Lovers - Exclude Cheese - Extra Bacon, Chicken'
end as GENOrderItem
from customer_orders
inner join pizza_names
on pizza_names.pizza_id = customer_orders.pizza_id;


--  24
select sum(case 
when c.pizza_id = 1 then 12
else 10
end) as Total
from runner_orders as r
inner join customer_orders as c
on c.order_id = r.order_id
where r.distance is not null;

select customer_orders.customer_id, customer_orders.order_id, runner_orders.runner_id, runner_delivery_rating.runner_rating, customer_orders.order_date,
runner_orders.pickup_time, timestampdiff(minute, order_date, pickup_time) as TimelyPickup, runner_orders.duration, round(avg(runner_orders.distance*60/runner_orders.duration),1) as AvgSpeed, count(customer_orders.pizza_id) as PizzaCou
from customer_orders
inner join runner_orders
on customer_orders.order_id = runner_orders.order_id
inner join runner_delivery_rating
on runner_delivery_rating.runner_id = customer_orders.order_id
group by customer_orders.customer_id, customer_orders.order_id, runner_orders.runner_id, runner_delivery_rating.runner_rating, customer_orders.order_date,
runner_orders.pickup_time, TimelyPickup, runner_orders.duration
order by customer_id;

set @pizzaamounttotalcalucalated = 114;
select @pizzaamounttotalcalucalated - (sum(distance))*0.3 as Finalamount
from runner_orders;
