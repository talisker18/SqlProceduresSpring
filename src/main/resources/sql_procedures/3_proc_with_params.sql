------------------ task ------------------

select * from products;
--product_code, product_name, price, quantity_remaining, quantity_sold
select * from sales;
--order_id, order_date, product_code, quantity_ordered, sale_price

--for every given product and the quantity:
	--1) check if product is available based on the required quantity
	--2) if availabe: modify the database tables accordingly


-------postgresql-------
create or replace procedure pr_buy_products (IN p_product_name varchar, IN p_quantity int) --or use OUT
language plpgsql
as $$
declare
	v_product_code varchar(20);
	v_price float;
	v_count int;
begin
	select count(*)
	into v_count
	from products
	where product_name = p_product_name
	and quantity_remaining >= p_quantity;
	
	if v_count > 0 then 
		select product_code, price 
		into v_product_code, v_price
		from products 
		where product_name = p_product_name;
		
		insert into sales (order_date, product_code, quantity_ordered, sale_price)
		values(current_date, v_product_code, p_quantity, (v_price*p_quantity));
		
		--reduce quantity_remaining and increase quantity_sold
		update products
		set quantity_remaining = (quantity_remaining - p_quantity), 
			quantity_sold = (quantity_sold + p_quantity)
		where product_code = v_product_code;
		
		raise notice 'Product iPhone 13 Pro max sold';
	else
		raise notice 'Insufficient quantity';
	end if;
end;
$$


-- how to run proc
call pr_buy_products('iPaid Air',1);



-------oracle-------
create or replace procedure pr_buy_products(IN p_product_name varchar, IN p_quantity int) --or use OUT
as
--declare not needed
	v_product_code varchar(20);
	v_price float;
	v_count int;
begin
	select count(*)
	into v_count
	from products
	where product_name = p_product_name
	and quantity_remaining >= p_quantity;
	
	if v_count > 0 then
		select product_code, price 
		into v_product_code, v_price
		from products 
		where product_name = p_product_name;
		
		insert into sales (order_date, product_code, quantity_ordered, sale_price)
		values(current_date, v_product_code, p_quantity, (v_price*p_quantity));
		
		--reduce quantity_remaining and increase quantity_sold
		update products
		set quantity_remaining = (quantity_remaining - p_quantity), 
			quantity_sold = (quantity_sold + p_quantity)
		where product_code = v_product_code;
		
		dbms_putput.put_line('Product iPhone 13 Pro max sold'); --to see this open new dbms output under 'Views'
	else
		dbms_putput.put_line('Insufficient quantity');
	end if;
	
end;


-- how to run proc
exec pr_buy_products('iPhone 13 Pro max',5);


-------microsoft sql server-------
create or alter procedure pr_buy_products(IN @p_product_name varchar(max), IN @p_quantity int) --in microsoft sql server we have to specifiy how much chars in varchar
as
	declare @v_product_code varchar(20),
	@v_price float,
	@v_count int;
	
begin
	select @v_count = count(*)
	from products
	where product_name = @p_product_name
	and quantity_remaining >= @p_quantity;
	
	if @v_count > 0
	begin
		select @v_product_code = product_code, @v_price = price 
		from products 
		where product_name = @p_product_name;
		
		insert into sales (order_date, product_code, quantity_ordered, sale_price)
		values(cast(getdate() as date), @v_product_code, @p_quantity, (@v_price*@p_quantity));
		
		--reduce quantity_remaining and increase quantity_sold
		update products
		set quantity_remaining = (quantity_remaining - @p_quantity), 
			quantity_sold = (quantity_sold + @p_quantity)
		where product_code = @v_product_code;
		
		print('Product iPhone 13 Pro max sold');
	end 
	else
		print('Insufficient quantity');
end;


-- how to run proc
exec pr_buy_products 'iPhone 13 Pro max',3; --no () needed


-------mysql-------

drop procedure if exists pr_buy_products;

DELIMITER $$

create procedure pr_buy_products(IN p_product_name varchar(40), IN p_quantity int) --as in MS sql server, define num of chars in varchar
-- as not needed
begin
	declare v_product_code varchar(20);
	declare v_price float;
	declare v_count int;
	
	select count(*)
	into v_count
	from products
	where product_name = p_product_name
	and quantity_remaining >= p_quantity;
	
	if v_count > 0 then
		select product_code, price 
		into v_product_code, v_price
		from products 
		where product_name = p_product_name;
		
		insert into sales (order_date, product_code, quantity_ordered, sale_price)
		values(cast(now()) as date, v_product_code, p_quantity, (v_price*p_quantity));
		
		--reduce quantity_remaining and increase quantity_sold
		update products
		set quantity_remaining = (quantity_remaining - p_quantity), 
			quantity_sold = (quantity_sold + p_quantity)
		where product_code = v_product_code;
		
		select ('Product iPhone 13 Pro max sold'); 
	else
		select ('Insufficient');
	end
	
end $$


-- how to run proc
call pr_buy_products('iPhone 13 Pro max',6);