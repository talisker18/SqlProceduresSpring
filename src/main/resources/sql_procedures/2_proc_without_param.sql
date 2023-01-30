------------------ task ------------------

select * from products;
--product_code, product_name, price, quantity_remaining, quantity_sold
select * from sales;
--order_id, order_date, product_code, quantity_ordered, sale_price

--for every iPhone 13 Pro max sale, this proc should be triggered and modify the database tables accordingly



-------postgresql-------
create or replace procedure pr_buy_products ()
language plpgsql
as $$
declare
	v_product_code varchar(20);
	v_price float;
begin
	select product_code, price 
	into v_product_code, v_price
	from products 
	where product_name = 'iPhone 13 Pro max';
	
	insert into sales (order_date, product_code, quantity_ordered, sale_price)
	values(current_date, v_product_code, 1, (v_price*1));
	
	--reduce quantity_remaining and increase quantity_sold
	update products
	set quantity_remaining = (quantity_remaining - 1), 
		quantity_sold = (quantity_sold + 1)
	where product_code = v_product_code;
	
	raise notice 'Product iPhone 13 Pro max sold';
	
end;
$$


-- how to run proc
call pr_buy_products();


-------oracle-------
create or replace procedure pr_buy_products -- () not needed if no params
as
--declare not needed
	v_product_code varchar(20);
	v_price float;
begin
	select product_code, price 
	into v_product_code, v_price
	from products 
	where product_name = 'iPhone 13 Pro max';
	
	insert into sales (order_date, product_code, quantity_ordered, sale_price)
	values(current_date, v_product_code, 1, (v_price*1));
	
	--reduce quantity_remaining and increase quantity_sold
	update products
	set quantity_remaining = (quantity_remaining - 1), 
		quantity_sold = (quantity_sold + 1)
	where product_code = v_product_code;
	
	dbms_putput.put_line('Product iPhone 13 Pro max sold'); --to see this open new dbms output under 'Views'
	
end;


-- how to run proc
exec pr_buy_products;


-------microsoft sql server-------
create or alter procedure pr_buy_products -- () not needed if no params
as
	declare @v_product_code varchar(20),
	@v_price float;
	
begin
	select @v_product_code = product_code, @v_price = price 
	from products 
	where product_name = 'iPhone 13 Pro max';
	
	insert into sales (order_date, product_code, quantity_ordered, sale_price)
	values(cast(getdate() as date), @v_product_code, 1, (@v_price*1));
	
	--reduce quantity_remaining and increase quantity_sold
	update products
	set quantity_remaining = (quantity_remaining - 1), 
		quantity_sold = (quantity_sold + 1)
	where product_code = @v_product_code;
	
	print('Product iPhone 13 Pro max sold'); 
	
end;


-- how to run proc
exec pr_buy_products;



-------mysql-------

drop procedure if exists pr_buy_products;

DELIMITER $$

create procedure pr_buy_products()
-- as not needed
begin
	declare v_product_code varchar(20);
	declare v_price float;
	
	select product_code, price 
	into v_product_code, v_price
	from products 
	where product_name = 'iPhone 13 Pro max';
	
	insert into sales (order_date, product_code, quantity_ordered, sale_price)
	values(current_date, v_product_code, 1, (v_price*1));
	
	--reduce quantity_remaining and increase quantity_sold
	update products
	set quantity_remaining = (quantity_remaining - 1), 
		quantity_sold = (quantity_sold + 1)
	where product_code = v_product_code;
	
	select ('Product iPhone 13 Pro max sold'); 
	
end $$


-- how to run proc
call pr_buy_products();