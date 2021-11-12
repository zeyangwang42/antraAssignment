use NorthWind
go


--1. List all cities that have both Employees and Customers.
select c.City
from Customers c
where c.City in (select City
from Employees)

/*
2. List all cities that have Customers but no Employee.
a. Use sub-query
*/
select c.City
from Customers c
where c.City not in (select City
from Employees)
--b. Do not use sub-query
select c.City
from Customers c
left join Employees e on c.City = e.City
where EmployeeID is null

--3. List all products and their total order quantities throughout all orders
select p.ProductID, sum(d.Quantity) "total"
from Products p
join [Order Details] d on p.ProductID=d.ProductID
group by p.ProductID

--4. List all Customer Cities and total products ordered by that city.
select c.City, sum(d.Quantity) total
from Customers c
join Orders o on c.City=o.ShipCity
join [Order Details] d on o.OrderID=d.OrderID
group by c.City

/*5. List all Customer Cities that have at least two customers.
a. Use union
*/

create Table #cityAndCustomerID (City  varchar(20),CustomerID varchar(20))

INSERT INTO #cityAndCustomerID (City, CustomerID)
select c.City City,c.CustomerID CustomerID 
from Customers c
union 
select o.ShipCity City,o.CustomerID CustomerID 
from Orders o

select distinct* from #cityAndCustomerID order by City

select distinct City, count(City) total from #cityAndCustomerID
group by City
having count(City)>=2
order by City


drop table  #cityAndCustomerID
--b. Use sub-query and no union
select dt.City, count(dt.City)
from(select  distinct o.CustomerID cus1, o.ShipCity City1,c.City City2, c.CustomerID cus2, (case
when o.CustomerID is not null
then o.ShipCity
else c.City
end ) as City
from Orders o
full join Customers c on c.CustomerID=o.CustomerID and c.City=o.ShipCity) dt
group by dt.City
having count(dt.City)>=2
order by dt.City


--select  distinct o.CustomerID cus1, o.ShipCity City1,c.City City2, c.CustomerID cus2, (case
--when o.CustomerID is not null
--then o.ShipCity
--else c.City
--end ) as City
--from Orders o
--full join Customers c on c.CustomerID=o.CustomerID and c.City=o.ShipCity
--order by City

--6. List all Customer Cities that have ordered at least two different kinds of products.
select distinct ShipCity as City
from (select  ShipCity,ProductID,RANK() over(partition by ShipCity order by ProductID) as ordernumber from (select distinct ShipCity,ProductID from Orders o join [Order Details] d on o.OrderID=d.OrderID) dt
) dt
where dt.ordernumber>=2

--7. List all Customers who have ordered products, but have the ¡®ship city¡¯ on the order different from their own customer cities.

select cus1, cus2
from(select  distinct o.CustomerID cus1, o.ShipCity City1,c.City City2, c.CustomerID cus2, (case
when  o.ShipCity=c.City
then 'yes'
else 'no'
end ) as diffCity
from Orders o
full join Customers c on c.CustomerID=o.CustomerID and c.City=o.ShipCity) dt
where diffCity='no'

--8. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
select ProductID, sum(UnitPrice*Quantity)/sum(Quantity) averagePrice from Orders o join [Order Details] d on o.OrderID = d.OrderID
where d.ProductID in (select ProductID from (select top 5 ProductID, sum(Quantity) as total from [Order Details] group by ProductID order by total desc) dt)
group by  ProductID

select * from
(select shipcITY,ProductID,sum(Quantity) total, ROW_NUMBER() OVER (PARTITION BY PRODUCTID ORDER BY sum(Quantity) desc) AS rank1
from Orders o join [Order Details] d on o.OrderID = d.OrderID
where d.ProductID in (select ProductID from (select top 5 ProductID, sum(Quantity) as total from [Order Details] group by ProductID order by total desc) dt)
group by  ProductID,ShipCity) dt1
where rank1=1

--9. List all cities that have never ordered something but we have employees there.
--a. Use sub-query

Select City from Employees e where e.City not in (select ShipCity from Orders)

--b. Do not use sub-query
Select City from Employees e 
full join Orders o on o.ShipCity=e.City 
where ShipCity is null

--10. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join sub-query)
Select top 5 City, count(1) from Orders o join Employees e on o.EmployeeID=e.EmployeeID group by City

select top 1 ShipCity,sum(Quantity) quantity from orders o join [Order Details] d on o.OrderID=d.OrderID
group by ShipCity 
order by quantity desc

--11. How do you remove the duplicates record of a table?
select distinct * from [Order Details] 

--12. Sample table to be used for solutions below- Employee ( empid integer, mgrid integer, deptid integer, salary integer) Dept (deptid integer, deptname text)
create table #Employee ( empid integer, mgrid integer, deptid integer, salary integer) 
create table #Dept (deptid integer, deptname text)


with cteEmpHierarchy
as
(
Select empid, mgrid,1 "lvl" from #Employee where mgrid is null
union all
select e.empid,e.mgrid, ct.lvl+1  from #Employee e inner join cteEmpHierarchy ct
on e.mgrid=ct.empid
)
select * from cteEmpHierarchy a where a.lvl in (select max(lvl) from cteEmpHierarchy)

/*13. Find departments that have maximum number of employees. (solution should consider
scenario having more than 1 departments that have maximum number of employees). Result
should only have - deptname, count of employees sorted by deptname.*/
select dt.deptname, dt.EmNumber
from (Select cast(d.deptname as varchar(100)) deptname, d.deptid, count(empid) EmNumber
from #Employee e join #Dept d on e.deptid=d.deptid  group by d.deptid, cast(d.deptname as varchar(100))) dt
where dt.EmNumber in (select max(dt1.EmNumber)
from (Select cast(d.deptname as varchar(100)) deptname, d.deptid, count(empid) EmNumber 
from #Employee e join #Dept d on e.deptid=d.deptid  
group by d.deptid, cast(d.deptname as varchar(100))) dt1)


/*14. Find top 3 employees (salary based) in every department. Result should have deptname,
empid, salary sorted by deptname and then employee with high to low salary.*/
select dt.deptname,dt.salary from
(select cast(d.deptname as varchar(100)) deptname, salary, Row_number() 
over(partition by cast(d.deptname as varchar(100)) order by Salary) as rankNumber
from #Employee e join #Dept d on e.deptid=d.deptid  ) dt
where rankNumber<=3
order by dt.deptname, dt.salary desc

/*Q15 is Find the top 3 products from every city The top 3 product from a total quantity measurement.*/
select *
from
(select ShipCity,ProductID ,sum(Quantity) quantity, ROW_NUMBER() over(partition by ShipCity order by sum(Quantity) desc) as ranknumber from Orders o join [Order Details] d on d.OrderID=o.OrderID 
group by ShipCity,ProductID) dt
where dt.ranknumber<=3

--Q16. Create the table above
create table #citydistance (City varchar(1), Distance int)

insert into #citydistance (City, Distance)
VALUES ('A', 80),('B', 150),('C', 180),('D', 220)

select dt.City,dt.Distance
from (select (a.City+'-'+b.City) as City,(b.Distance-a.Distance) as Distance from #citydistance a cross join #citydistance b 
where not a.City =b.City) dt
where dt.Distance>=0



drop table #citydistance 
