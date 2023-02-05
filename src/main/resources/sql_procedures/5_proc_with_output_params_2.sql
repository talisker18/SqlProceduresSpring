

-------microsoft sql server-------
create or alter procedure spGetEmployeeCountByGender (IN @gender varchar(20), OUT @EmployeeCount int)

as
	
begin
	select @EmployeeCount = count(id) from tblEmployee where gender = @gender;
end;

-- how to run proc
DECLARE @EmployeeTotal int

exec spGetEmployeeCountByGender 'male', @EmployeeTotal OUT
print @EmployeeTotal

-- or without ordering the params
exec spGetEmployeeCountByGender @EmployeeCount = @EmployeeTotal OUT, @gender = 'male'
print @EmployeeTotal
