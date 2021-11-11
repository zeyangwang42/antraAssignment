USE AdventureWorks2019
go

-- 1. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter.
Select p.ProductID,p.Name,p.Color,p.ListPrice
From Production.Product p

--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are 0 for the column ListPrice
Select p.ProductID,p.Name,p.Color,p.ListPrice
From Production.Product p
where ListPrice=0

--3. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are rows that are NULL for the Color column.
Select p.ProductID,p.Name,p.Color,p.ListPrice
From Production.Product p
where Color is null

--4. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
Select p.ProductID,p.Name,p.Color,p.ListPrice
From Production.Product p
where not Color is null

--5. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
Select p.ProductID,p.Name,p.Color,p.ListPrice
From Production.Product p
where not Color is null and ListPrice>0
--6. Generate a report that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
Select p.Name,p.Color
From Production.Product p
where not Color is null

-- 7. Write a query that generates the following result set from Production.Product:
SELECT top 6 concat('NAME: ', concat( concat(p.Name,' -- COLOR: '),p.Color)) as 'Name And Color'
FROM Production.Product p
where not color is null

-- 8 Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
Select p.ProductID,p.Name
From Production.Product p
where ProductID between 400 and 500

-- 9. Write a query to retrieve the to the columns ProductID, Name and color from the Production.Product table restricted to the colors black and blue
Select p.ProductID,p.Name,p.Color
From Production.Product p
where Color='black' or Color='blue'

-- 10. Write a query to generate a report on products that begins with the letter S.
Select p.Name
From Production.Product p
where p.Name LIKE 'S%'
--11. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column.
Select top 6 P.Name,P.ListPrice
From Production.Product p
where p.Name LIKE 'S%'
ORDER BY Name
--12. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
Select top 5 P.Name,P.ListPrice
From Production.Product p
where p.Name LIKE 'S%' or p.name LIKE 'A%'
ORDER BY Name
-- 13. Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
Select P.Name,P.ListPrice
From Production.Product p
where p.Name LIKE 'SPO%' and not p.name like 'SPOK%'
ORDER BY Name
--14. Write a query that retrieves unique colors from the table Production.Product. Order the results in descending manner
Select DISTINCT P.color
From Production.Product p
WHERE COLOR IS NOT NULL
ORDER BY COLOR DESC
-- 15. Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
Select DISTINCT P.color, P.ProductSubcategoryID
From Production.Product p
WHERE COLOR IS NOT NULL  AND ProductSubcategoryID IS NOT NULL
-- 16. Something is ¡°wrong¡± with the WHERE clause in the following query. We do not want any Red or Black products from any SubCategory except those with the value of 1 in column ProductSubCategoryID, unless they cost between 1000 and 2000.
SELECT ProductSubCategoryID
, LEFT([Name],35) AS [Name]
, Color, ListPrice
FROM Production.Product
WHERE 
ProductSubCategoryID = 1 or
Color Not IN ('Red','Black')
OR ListPrice BETWEEN 1000 AND 2000
ORDER BY ProductID
-- 17. Write the query in the editor and execute it. Take a look at the result set and then adjust the query so it delivers the following result set.
Select p.ProductSubcategoryID,p.Name,p.Color,p.ListPrice
From Production.Product p
WHERE ProductSubcategoryID IS NOT NULL and COLOR IS NOT NULL  and ProductSubcategoryID<=14 and ((ListPrice>1431 AND ProductSubcategoryID = 14 AND ProductID<837) or ( ProductSubcategoryID = 12 ) or ( ProductSubcategoryID = 2 and ListPrice=1700.99 ) or ( ProductSubcategoryID = 1 and ListPrice <540 and color = 'Black' ))
order by ProductSubcategoryID desc
-- 