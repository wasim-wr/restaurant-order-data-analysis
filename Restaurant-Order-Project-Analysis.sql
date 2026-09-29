--Objective 1


--Q.1. View the menu_items table
		SELECT * FROM menu_items

--Q.2. Find the number of items on the menu

	select count(*) from menu_items
--Q.3. What is the list and most expensive items on the menu

		select max(price) as mx_items, min(price) mn_items
		from menu_items 
		--OR
		select *
		from menu_items
		order by price asc/ desc
--Q.4. How many Italian dishes are on the menu?

		select 
		count(category) as max_italian_dishes
		from menu_items
		where category = 'Italian'
--Q.5. What is the least and most expensive Italian dishes on the menu?

		select *
		from menu_items
		where category = 'Italian'
		order by price desc  --(most expensive)
		
		select *
		from menu_items
		where category = 'Italian'
		order by price asc  --(lest expensive)
--Q.6. How many dishes are in each category

	select category, count(menu_item_id) as num_dishes
	from menu_items
	group by category

--Q.7. What is average price of each category

		select category, avg(price) as avg_dish_price
		from menu_items
		group by category

--Objective 2

--Q.1. View the order_details table

	   select * from order_details;

--Q.2.What is the date range of the table

		select * 
		from order_details
		order by order_date
--OR
		select min(order_date) from order_details;
		select max(order_date) from order_details;

--Q.3. How many order were made within this order range 

		select count(distinct order_id) 
		from order_details 
--Q.4. How many items were ordered within this order range

		select count(order_id) --count(*) 
		from order_details
		
--Q.5. Which order had the most number of itmes

		select order_id, count(item_id) as num_items
		from order_details
		group by order_id
		order by num_items desc 
--Q.6. How many orders had more than 12 items

	select count(*) as total_order from
	(select order_id, count(item_id) as num_items
	from order_details
	group by order_id
	having  count(item_id) > 12) num_orders

--Objective 3: ANALYZE CUSTOMER BEHAVIOR 


--Q.1.Combine the menu_item and order details table into single table
	
	select *
	from order_details od
	left join menu_items mi 
					on od.item_id = mi.menu_item_id


--Q.2. What were the least and most ordered items? What category were they in?

		select item_name, category, count(order_details_id) as num_purchases 
		from order_details od
		left join menu_items mi 
		on od.item_id = mi.menu_item_id
		group by item_name, category
		order by num_purchases desc --most ordered
		--order by num_purchases  --list ordered

--Q.3. What were the top 5 orders that spent the most money?

		select order_id, sum(price) as total_spend
		from order_details od
		left join menu_items mi 
		on od.item_id = mi.menu_item_id
		group by order_id
		--having sum(price) is not null
		order by total_spend desc limit 5

--Note: highest spend order_id is 440

--Q.4. View the details of highest spend order. What insights can you the gather 
		
		From the results?
		select category, count(item_id) as num_items
		from order_details od
		left join menu_items mi 
		on od.item_id = mi.menu_item_id
		where order_id = 440
		group by category

--Q.5. View the details top 5 highest spend order. What insights can you the 
	  --gather From the results?
	
		select order_id, category, count(item_id) as num_items
		from order_details od
		left join menu_items mi 
		on od.item_id = mi.menu_item_id
		where order_id in (440,2075, 1957, 330, 2675)
		group by order_id, category
		order by num_items desc


 

