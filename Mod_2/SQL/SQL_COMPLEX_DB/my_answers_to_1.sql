select distinct city from sales.customers where state = 'CA';

select count(*), city  from sales.customers  where state = 'CA' group by city;

-- 2. Return the cities in California which has more than 10 customers.
select count(*), city  from sales.customers  where state = 'CA' group by city having count(*) > 10 ;

-- 3. Use the GROUP BY clause to return distinct cities together with state and zip code
-- from the sales.customers table.
select city, state, zip_code from sales.customers group by city, state, zip_code;

-- 4. Rewrite this query with the DISTINCT keyword.
select distinct( city), state, zip_code from sales.customers;

-- 5. Return the products whose list price is greater than 300 and model is 2018.
select * from production.products where list_price > 300 and model_year='2018';

-- 6. Return the products whose list prices are between 1,899 and 1,999.99.
select * from production.products where list_price >= 1899 and list_price <= 1999.99;

-- 7. Use the IN operator to find products whose list price is 299.99 or 466.99 or 489.99. 
-- Order by price descending.
select * from production.products where list_price in (299.99, 466.99, 489.99) order by list_price desc;

-- 8. Return the average list price in the products table of product names that include the word 'Cruiser'.
select product_name, avg(list_price) from production.products where product_name like '%Cruiser%' 
group by product_name;

-- 9. Return the customer_id, first_name, last_name, and phone number of sales.customers table
--  where phone is not null, order by last name descending.
select customer_id, first_name, last_name, phone from sales.customers where phone is not null order 
by last_name desc;

--  10. Use the cast function to explicitly filter orders from the orders table
--  where requiredDate is greater than 2017-01-01 and 2017-01-31.
SELECT * FROM sales.orders
wHERE required_date BETWEEN  CAST('2017-01-01' AS DATETIME)
                        AND CAST('2017-01-31' AS DATETIME);
                        
-- 11. Return the order number, order status and total sales from the orders and orderdetails tables.
-- select orders.order_id, orders.order_status, sum  from sales.orders;

select  oi.order_id, o.order_status, sum(list_price * quantity)
from sales.order_items oi INNER JOIN
  sales.orders o ON
  oi.order_id = o.order_id group by oi.order_id, o.order_status;
  
-- 12. Return the list of customers that placed no phone numbers.
select * from sales.customers where phone is null;

-- 13. Return the customer first name, last name, email,
--  phone and the number of the orders that customers with no phone number have made.

SELECT 
  c.first_name,  c.last_name, c.email, c.phone, count(o.order_id)
FROM sales.customers c
INNER JOIN sales.orders o
ON c.customer_id = o.customer_id
WHERE c.phone is null
group by c.first_name,  c.last_name, c.email, c.phone












