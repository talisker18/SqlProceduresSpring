--postgresql

create or replace procedure pr_name (p_name varchar, p_age int)
language plpgsql --only needed with postgre
as $$
declare
	var1 int
	var2 varchar
begin
	procedure body...
end;
$$

--oracle
create or replace procedure pr_name (p_name varchar, p_age int)
as
--declare not needed
	var1 int
	var2 varchar
begin
	procedure body...
end;

--microsoft sql server
create or alter procedure pr_name (@p_name varchar, @p_age int)
as
	declare @var1 int,
			@var2 varchar;
begin
	procedure body...
end;

--mysql
DELIMITER $$ --from create to end, treat it as 1 statement

create or replace procedure pr_name (p_name varchar, p_age int)
as
declare var1 int, declare var2 varchar
	var2 varchar
begin
	procedure body...
end $$
