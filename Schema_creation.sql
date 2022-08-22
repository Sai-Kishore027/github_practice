use pizza_deliver_database;
create table customer_orders(
sno int,
primary key ( sno),
order_id INT,
customer_id INT ,
pizza_id INT ,
exclusions VARCHAR(10) ,
extras VARCHAR(10) ,
order_date TIMESTAMP);
create table pizza_names(
pizza_id int,
pizza_name varchar(20)
);
create table pizza_receipes(
pizza_id int,
toppings varchar(20)
);
create table pizza_toppings(
topping_id int,
primary key(topping_id),
topping_name varchar(20)
);
create table runner_orders(
order_id INT,
primary key(order_id),
runner_id INT NOT NULL,
pickup_time VARCHAR(19) ,
distance VARCHAR(10) ,
duration VARCHAR(10) ,
cancellation VARCHAR(23));
create table runners(
runner_id INT NOT NULL,
primary key ( runner_id),
registration_date date
);

Alter table customer_orders add primary key(customer_id);
ALTER TABLE customer_orders
ADD FOREIGN KEY (order_id) REFERENCES runner_orders(order_id);
ALTER TABLE customer_orders
ADD FOREIGN KEY (pizza_id) REFERENCES pizza_names(pizza_id);
ALTER TABLE customer_orders
ADD FOREIGN KEY (pizza_id) REFERENCES pizza_receipes(pizza_id);
ALTER TABLE runner_orderscustomer_orders
ADD FOREIGN KEY (runner_id) REFERENCES runners(runner_id);
Alter table pizza_names add primary key(pizza_id);
Alter table pizza_receipes add primary key(pizza_id);
