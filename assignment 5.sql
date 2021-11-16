create database homework
use homework
go
--1.	Write an sql statement that will display the name of each customer and the sum of order totals placed by that customer during the year 2002
-- Create table customer(cust_id int,  iname varchar (50)) create table order(order_id int,cust_id int,amount money,order_date smalldatetime)
Create table customer(cust_id int,  iname varchar (50))
create table orders (order_id int,cust_id int,amount money,order_date smalldatetime)

select cust_id,iname, sum(amount) as amountOrderIn2002 from 
(select c.cust_id,c.iname,o.amount from customer c  join orders o on o.cust_id =c.cust_id 
where datepart(YEAR,order_date) = 2002) dt group by cust_id,iname
 
-- 2.  The following table is used to store information about company¡¯s personnel:
--Create table person (id int, firstname varchar(100), lastname varchar(100)) write a query that returns all employees whose last names  start with ¡°A¡±.
Create table person (id int, firstname varchar(100), lastname varchar(100))

select p.id,p.firstname,p.lastname from person p where lastname like 'A%'
drop table person
--3.  The information about company¡¯s personnel is stored in the following table:
--Create table person(person_id int primary key, manager_id int null, name varchar(100)not null) The filed managed_id contains the person_id of the employee¡¯s manager.
--Please write a query that would return the names of all top managers(an employee who does not have  a manger, and the number of people that report directly to this manager.
Create table person(person_id int primary key, manager_id int null, name varchar(100)not null)
Select person_id,name,manager_id from person where manager_id is null
union all
Select p.person_id,p.name,p.manager_id from person p where manager_id in (select p1.person_id from person p1 where p1.manager_id is null)


--4.  List all events that can cause a trigger to be executed.
-- INSERT, UPDATE, DELETE, CREATE, ALTER, or DROP 

--5. Generate a destination schema in 3rd Normal Form.  Include all necessary fact, join, and dictionary tables, and all Primary and Foreign Key relationships.  The following assumptions can be made:
--a. Each Company can have one or more Divisions.

--b. Each record in the Company table represents a unique combination 

--c. Physical locations are associated with Divisions.

--d. Some Company Divisions are collocated at the same physical of Company Name and Division Name.

--e. Contacts can be associated with one or more divisions and the address, but are differentiated by suite/mail drop records.status of each association should be separately maintained and audited.
Create table Company(companyname varchar(20) primary key)

Create table locations (locationaddress varchar(20) primary key)

Create table Divisions(DivisionsId varchar(20) primary key, 
companyId varchar(20) foreign key references Company(companyname),
Physical_locations varchar(20) foreign key references locations(locationaddress))
Create table Contacts (mail varchar(20) primary key,name varchar(20), divisions varchar(20) foreign key references Divisions(DivisionsId))