create database olist_ecommerce;
use olist_ecommerce;
#The e-commerce company wants to see the first 10 orders recorded in its database.
select * from olist_orders limit 10 ;
#The company wants to know which orders have been delivered.
select * from olist_orders 
where order_status = 'delivered';
#The company wants to see the 10 most recently purchased orders.
select * from olist_orders 
order by order_purchase_timestamp desc limit 10;
#The company wants to know how many orders are recorded in the table.
select count(order_id) from olist_orders;
#The company wants to know all the different order statuses in the dataset, without repeating any status
select distinct order_status from olist_orders;
#The company wants to know how many orders belong to each order status.
select order_status,count(order_id) as total_orders 
from olist_orders group by order_status;
#The company wants to see only the order statuses that have more than 100 orders.
select order_status,count(order_id) as total_orders
from olist_orders 
group by order_status 
having count(order_id) > 100;
#The company wants to review all orders placed during 2018.
select * from olist_orders
where order_purchase_timestamp 
between '2018-01-01' and '2019-01-01';
#The company wants to inspect canceled orders.
select order_id, customer_id,order_status from olist_orders
where order_status = 'canceled';
#The company wants to know how many orders have been delivered.
select count(order_status) as total_delivered_orders
from olist_orders 
where order_status = 'delivered';
#The company wants a summary showing the number of orders for each available status.
select order_status , count(order_id) as total_orders
from olist_orders
group by order_status;
#The company wants to see which order status has the highest number of orders.
select order_status, count(order_id) as total_orders
from olist_orders
group by order_status
order by total_orders desc;
#The company wants to identify the 10 oldest orders in the dataset.
select * from olist_orders 
order by order_purchase_timestamp asc limit 10;
#The company wants to understand how many orders were placed in each year.
select year(order_purchase_timestamp) as order_year,
count(order_id) as total_orders
from olist_orders
group by year(order_purchase_timestamp)
order by order_year asc;
#The company wants to review the five most recently purchased orders.
select order_id, order_purchase_timestamp from olist_orders 
order by order_purchase_timestamp desc limit 5;
#Show each order with the customer's ID and city.
select o.order_id,o.customer_id,c.customer_city
from olist_orders as o 
inner join olist_customers as c
on o.customer_id = c.customer_id;
#The company wants to identify orders whose customer_id does not have a matching record in the olist_customers table.
select o.order_id,o.customer_id from olist_orders as o 
left join olist_customers as c
on o.customer_id = c.customer_id
where c.customer_id is null;
#The company wants to know how much revenue each product category generates.
select p.product_category_name, sum(oi.price) as total_sales
from olist_order_items as oi 
inner join olist_products as p
on oi.product_id = p.product_id
group by p.product_category_name
order by total_sales desc;
#The company wants to identify its five highest-spending customers.
select o.customer_id,sum(oi.price) as total_spent
from olist_orders as o
inner join olist_order_items as oi
on o.order_id = oi.order_id
group by o.customer_id
order by total_spent desc limit 5;
#Find how many orders were placed each month.
select date_format(order_purchase_timestamp, '%Y-%m') as order_month,
count(order_id) as total_orders from olist_orders
group by date_format(order_purchase_timestamp, '%Y-%m')
order by order_month asc;