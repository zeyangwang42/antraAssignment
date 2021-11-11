use AdventureWorks2019
go

-- 1. How many products can you find in the Production.Product table?
select  count(ProductID)
from Production.Product
/*  2. Write a query that retrieves the number of products in the Production.Product table that
are included in a subcategory. The rows that have NULL in column ProductSubcategoryID
are considered to not be a part of any subcategory.
*/

select  ProductSubcategoryID, count(ProductSubcategoryID) numberOfProduct
from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID

/*
3. How many Products reside in each SubCategory? Write a query to display the results
with the following titles.
ProductSubcategoryID CountedProducts
-------------------- ---------------
*/

select  ProductSubcategoryID, count(ProductSubcategoryID) CountedProducts
from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID
/*
4. How many products that do not have a product subcategory.
*/
select   count(ProductID)
from Production.Product
where ProductSubcategoryID is null

/*5. Write a query to list the summary of products quantity in the
Production.ProductInventory table.*/
select ProductID,sum(Quantity) summeryOfQuantity
from Production.ProductInventory
group by  ProductID


/*6. Write a query to list the summary of products in the Production.ProductInventory table
and LocationID set to 40 and limit the result to include just summarized quantities less
than 100.
ProductID TheSum*/
select ProductID,sum(Quantity) TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having  sum(Quantity)<100 
/*7. Write a query to list the summary of products with the shelf information in the
Production.ProductInventory table and LocationID set to 40 and limit the result to
include just summarized quantities less than 100*/
select Shelf,ProductID, sum(Quantity) TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID,Shelf
having  sum(Quantity)<100 
/*8. Write the query to list the average quantity for products where column LocationID has
the value of 10 from the table Production.ProductInventory table.*/
select  AVG(Quantity)
from Production.ProductInventory
where LocationID=10

/*9. Write query to see the average quantity of products by shelf from the table
Production.ProductInventory
ProductID Shelf TheAvg
----------- ---------- -----------*/
select  ProductID,Shelf,AVG(Quantity) TheAvg
from Production.ProductInventory
group by Shelf,ProductID

/*10. Write query to see the average quantity of products by shelf excluding rows that has
the value of N/A in the column Shelf from the table Production.ProductInventory
ProductID Shelf TheAvg
----------- ---------- -----------
*/
select  ProductID,Shelf,AVG(Quantity) TheAvg
from Production.ProductInventory
where not Shelf = 'N/A' 
group by Shelf,ProductID

/*11. List the members (rows) and average list price in the Production.Product table. This
should be grouped independently over the Color and the Class column. Exclude the rows
where Color or Class are null.
Color Class TheCount AvgPrice
-------------- - ----- ----------- ---------------------*/
select  Color,Class, count(1) TheCount, AVG(ListPrice) AvgPrice
from Production.Product
where Color is not null and Class is not null
group by Color,Class
/*12. Write a query that lists the country and province names from person. CountryRegion
and person. StateProvince tables. Join them and produce a result set similar to the
following.
Country Province
--------- ----------------------*/
select c.Name Country,s.Name Province
from Person.CountryRegion c 
INNER join Person.StateProvince s on c.CountryRegionCode =s.CountryRegionCode

/*13. Write a query that lists the country and province names from person. CountryRegion
and person. StateProvince tables and list the countries filter them by Germany and
Canada. Join them and produce a result set similar to the following.
Country Province
--------- ----------------------*/
select c.Name Country,s.Name Province
from Person.CountryRegion c 
INNER join Person.StateProvince s on c.CountryRegionCode =s.CountryRegionCode
where c.Name = 'Canada'or c.Name = 'Germany'

USE NorthWind
GO
-- 14. List all Products that has been sold at least once in last 25 years.
SELECT d.ProductID as productid, p.ProductName as ProjectName, o.OrderDate as orderdate
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
INNER join Products p on d.ProductID = p.ProductID
where OrderDate>='19961110 10:58:58' 

--15. List top 5 locations (Zip Code) where the products sold most.

SELECT top 5 ShipPostalCode as zip, sum(Quantity) as totalSaled
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
where ShipPostalCode is not null
group by ShipPostalCode
order by totalSaled desc

-- 16. List top 5 locations (Zip Code) where the products sold most in last 20 years.
SELECT top 5 ShipPostalCode as zip, sum(Quantity) as totalSaled
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
where OrderDate>='20011110 10:58:58' and ShipPostalCode is not null
group by ShipPostalCode
order by totalSaled desc

--17. List all city names and number of customers in that city.
SELECT o.ShipCity, sum(d.Quantity) as NumberSaled
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
where  ShipCity is not null
group by o.ShipCity
order by NumberSaled desc


--19. List the names of customers who placed orders after 1/1/98 with order date.
SELECT o.ShipName,o.OrderDate
FROM Orders o
where OrderDate>='19980101 00:00:00.000' 

--20. List the names of all customers with most recent order dates
SELECT distinct ShipName, OrderDate
FROM Orders o
order by OrderDate desc

--21. Display the names of all customers along with the count of products they bought
SELECT distinct ShipName as Name, sum(d.Quantity) as BoughtNumber
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
group by shipName


--22. Display the customer ids who bought more than 100 Products with count of products
SELECT distinct ShipName as Name, sum(d.Quantity) as BoughtNumber
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
group by shipName
having sum(d.Quantity) >100

/*23. List all of the possible ways that suppliers can ship their products. Display the results as
below
Supplier Company Name Shipping Company Name
--------------------------------- ----------------------------------*/

SELECT sup.CompanyName 'Supplier Company Name',shi.CompanyName 'Shipping Company Name'
FROM Suppliers sup, Shippers shi

--24. Display the products order each day. Show Order date and Product Name.

SELECT o.OrderDate as 'Order date',p.ProductName as 'Product Name'
FROM Orders o
INNER join [Order Details] d on o.OrderID=d.OrderID
INNER join Products p on d.ProductID = p.ProductID

--25. Displays pairs of employees who have the same job title.

SELECT e1.LastName, e1.FirstName ,e2.LastName, e2.FirstName,e1.Title
FROM Employees e1
 join Employees e2 on e1.Title=e2.Title
 where not (e1.FirstName=e2.FirstName and e1.LastName = e2.LastName)

 -- 26. Display all the Managers who have more than 2 employees reporting to them.
 select LastName,FirstName,ReportsTo
 from Employees
 where ReportsTo>2

 /*27. Display the customers and suppliers by city. The results should have the following
columns
City
Name
Contact Name,
Type (Customer or Supplier)*/

 select City,CompanyName,ContactName, 'suppliers' 'Type (Customer or Supplier)'
 from Suppliers s 
 union
 select City,CompanyName,ContactName,'customers' 'Type (Customer or Supplier)'
 from Customers c

/*28.Have two tables T1 and T2
F1.T1 F2.T2
1 2
2 3
3 4
Please write a query to inner join these two tables and write down the result of this query.*/

create table T1 (
F1 INT)
create table T2(
F2 INT)
INSERT INTO T1(F1)
VALUES
(1),(2),(3)
INSERT INTO T2(F2)
VALUES
(2),(3),(4)


SELECT F1, F2
FROM T1
INNER JOIN T2 ON F1=F2

--29. Based on above two table, Please write a query to left outer join these two tables and write down the result of this query

SELECT F1, F2
FROM T1
LEFT OUTER JOIN T2 ON F1=F2
/*
RESULT
F1 F2
1  NULL
2  2
3  3


*/