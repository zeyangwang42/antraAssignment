use Northwind
go
select * from region

--1. Lock tables Region, Territories, EmployeeTerritories and Employees. Insert following
--information into the database. In case of an error, no changes should be made to DB.

set transaction isolation level serializable

--a. A new region called ¡°Middle Earth¡±;
begin tran
insert into Region values (5,'Middle Earth')

commit



--b. A new territory called ¡°Gondor¡±, belongs to region ¡°Middle Earth¡±;
begin tran
insert into Territories values (0,'Gondor',5)
commit

--c. A new employee ¡°Aragorn King¡± who's territory is ¡°Gondor¡±.

begin tran
insert into Employees(LastName,FirstName) values ('King','Aragorn')
insert into EmployeeTerritories(EmployeeID,TerritoryID) values (SCOPE_IDENTITY(),0)
commit


--2. Change territory ¡°Gondor¡± to ¡°Arnor¡±.

begin tran
UPDATE Territories SET TerritoryDescription = 'Arnor' where TerritoryDescription = 'Gondor'
commit




--3. Delete Region ¡°Middle Earth¡±. (tip: remove referenced data first) (Caution: do not forget
--WHERE or you will delete everything.) In case of an error, no changes should be made to
--DB. Unlock the tables mentioned in question 1.
begin tran
delete from EmployeeTerritories where TerritoryID in (select TerritoryID from Territories where RegionID in (select RegionID from Region where RegionDescription = 'Middle Earth'))
delete from Employees where EmployeeID =14
delete from Territories where RegionID in (select RegionID from Region where RegionDescription = 'Middle Earth')
delete from Region where RegionDescription='Middle Earth'
commit


--4. Create a view named ¡°view_product_order_[your_last_name]¡±, list all products and total
--ordered quantity for that product.

set transaction isolation level READ COMMITTED

create view  view_product_order_wang as 
select p.ProductID,sum(Quantity) as orderedQuantity from Products p inner join [Order Details] o on p.ProductID = o.ProductID
group by p.ProductID

--5. Create a stored procedure ¡°sp_product_order_quantity_[your_last_name]¡± that accept
--product id as an input and total quantities of order as output parameter.

create procedure sp_product_order_quantity_Wang (@ProductID int, @Quantities  int output ) 
as
begin
	select @Quantities = v.orderedQuantity from view_product_order_wang v where v.ProductID =@ProductID
end

--6. Create a stored procedure ¡°sp_product_order_city_[your_last_name]¡± that accept
--product name as an input and top 5 cities that ordered most that product combined
--with the total quantity of that product ordered from that city as output.


create procedure sp_product_order_city_wang (@ProductName varchar(20) ) 
as
begin
	select top 5 dt.ShipCity, dt.Quantity from (select p.ProductName,o.ShipCity,sum(d.Quantity) as Quantity from Orders o 
	inner join [Order Details] d on o.OrderID=d.OrderID 
	inner join  Products p on p.ProductID =d.ProductID 
	group by p.ProductName,o.ShipCity) dt
	where dt.ProductName = @ProductName
	order by dt.Quantity desc
end


--7. Lock tables Region, Territories, EmployeeTerritories and Employees. Create a stored
--procedure ¡°sp_move_employees_[your_last_name]¡± that automatically find all
--employees in territory ¡°Tory¡±; if more than 0 found, insert a new territory ¡°Stevens
--Point¡± of region ¡°North¡± to the database, and then move those employees to ¡°Stevens
--Point¡±.


create procedure sp_move_employees_wang 
as
begin

	declare @number AS INT
	select @number = dt.employNumber from (
	select t.TerritoryDescription, count(et.EmployeeID) as employNumber from Territories t inner join EmployeeTerritories et on t.TerritoryID=et.TerritoryID 
	group by t.TerritoryDescription) dt
	where dt.TerritoryDescription = 'Tory'

	if not @number = 0
	insert into Territories values(0,'Stevens Point',3)

	begin tran

	update EmployeeTerritories set TerritoryID=0 where TerritoryID in (select t.TerritoryID from Territories t where t.TerritoryDescription = 'Tory') 


	commit

end

--8. Create a trigger that when there are more than 100 employees in territory ¡°Stevens
--Point¡±, move them back to Troy. (After test your code,) remove the trigger. Move those
--employees back to ¡°Troy¡±, if any. Unlock the tables.

Create trigger morethan100 on dbo.EmployeeTerritories
for INSERT
as
declare @number as int
declare @TerritoryID1 as int
declare @TerritoryID2 as int
select @TerritoryID1 = TerritoryID from Territories where TerritoryDescription='Stevens Point'
select @number=count(EmployeeID) from EmployeeTerritories where TerritoryID = 0
if @number>=100
select @TerritoryID2 = TerritoryID from Territories where TerritoryDescription = 'Troy'
begin tran
update EmployeeTerritories set TerritoryID = @number where TerritoryID = @TerritoryID1
commit
drop trigger morethan100

go

--9. Create 2 new tables ¡°people_your_last_name¡± ¡°city_your_last_name¡±. City table has
--two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has three records: {id:1,
--Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody
--Nelson, City:2}. Remove city of Seattle. If there was anyone from Seattle, put them into a
--new city ¡°Madison¡±. Create a view ¡°Packers_your_name¡± lists all people from Green Bay.
--If any error occurred, no changes should be made to DB. (after test) Drop both tables
--and view.
create table city_wang(id int primary key identity(1,1),City varchar(20))
create table people_wang (id int primary key identity(1,1), Name varchar(20), City int foreign key references city_wang(Id) )
insert into city_wang values('Seattle')
insert into city_wang values('Green Bay')
insert into people_wang values('Aaron Rodger',2)
insert into people_wang values('Russell Wilson',1)
insert into people_wang values('Jody Nelson',2)

begin tran
update city_wang set City = 'Madison' where City='Seattle'
commit
select * from city_wang
select * from people_wang
Create view Packers_Wang_Zeyang as select Name from people_wang where City in (select id from city_wang where City='Green Bay')

select * from Packers_Wang_Zeyang

drop table people_wang
drop table city_wang
--10. Create a stored procedure ¡°sp_birthday_employees_[you_last_name]¡± that creates a
--new table ¡°birthday_employees_your_last_name¡± and fill it with all employees that
--have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not
--be affected.

create procedure sp_birthday_employees_Wang
as
begin

create table birthday_employees_Wang (Employeesid varchar(20),FirstName varchar(20), LastName varchar(20),birthdate datetime)
 insert into birthday_employees_Wang select EmployeeID,FirstName,LastName,BirthDate from Employees e where DATEPART(MONTH,e.BirthDate) = 02

end


exec sp_birthday_employees_Wang
select * from birthday_employees_Wang

drop table birthday_employees_Wang
--11. Create a stored procedure named ¡°sp_your_last_name_1¡± that returns all cites that
--have at least 2 customers who have bought no or only one kind of product. Create a
--stored procedure named ¡°sp_your_last_name_2¡± that returns the same but using a
--different approach. (sub-query and no-sub-query).
select * from Customers
select * from Orders
select * from [Order Details]
create procedure sp_your_Wang_1
as
begin
select dt1.ShipCity, count(dt1.CustomerID) as customerNumber from (select dt.ShipCity,dt.CustomerID,count(dt.ProductID) as typeBought 
from (select distinct ShipCity,o.CustomerID,d.ProductID  from Orders o full join [Order Details] d on o.OrderID = d.OrderID) dt 
group by dt.ShipCity,dt.CustomerID
having count(dt.ProductID)>1) dt1
group by dt1.ShipCity
having count(dt1.CustomerID)>1
end

create procedure sp_your_Wang_2
as
begin

create table record(ShipCity varchar(20),CustomerID varchar(20), countvalue int )
insert into record
select distinct o.ShipCity, o.CustomerID,COUNT(d.ProductID) from orders  o full join [Order Details] d on o.OrderID=d.OrderID group by o.ShipCity, o.CustomerID having COUNT(d.ProductID)>1
select ShipCity, count(CustomerID) from record group by ShipCity having count(CustomerID)>1

drop table record
end





--12. How do you make sure two tables have the same data?

-- union two table, if the size of the result = table1 and table2, they have same data










select * from EmployeeTerritories