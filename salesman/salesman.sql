
create database salesmen;
use salesmen;
CREATE TABLE Salesman( salesman_id int NOT null, salesman_name varchar(20) NOT null, city varchar(20) NOT null, commission int NOT null,
PRIMARY KEY(salesman_id)
);
CREATE TABLE Customer( customer_id int NOT null, customer_name varchar(20) NOT null, city varchar(20) NOT null,
grade int NOT null,
salesman_id int,
PRIMARY KEY(customer_id),
FOREIGN KEY(salesman_id) REFERENCES Salesman(salesman_id) ON DELETE SET null );
CREATE TABLE Orders(
order_id int NOT null,
purchase_amt int NOT null,
order_date date NOT null,
customer_id int NOT null,
salesman_id int,
PRIMARY KEY(order_id),
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY(salesman_id) REFERENCES Salesman(salesman_id) ON DELETE SET null );
insert into Salesman(salesman_id,salesman_name,city,commission) values (1000,'Pranav','Bangalore',25),
(2000,'Ravi','Bangalore',20),
(3000,'Kumar','Mysore',15),
(4000,'Nihal','Delhi',30), (5000,'Harsh','Hyderabad',15);
insert into Customer(customer_id,customer_name,city,grade,salesman_id) values (10,'Preeth','Bangalore',100,1000), (11,'Vivek','Mangalore',300,1000),
(12,'shankar','Chennai',400,2000),
(13,'Chaitra','Bangalore',200,2000),
(14,'Arya','Bangalore',400,3000);
insert into Orders(order_id,purchase_amt,order_date,customer_id,salesman_id) values (50,5000,'2017-05-04',10,1000),
(51,450,'2017-01-20',10,2000),
(52,1000,'2017-02-24',13,2000),
(53,3500,'2017-04-13',14,3000), (54,550,'2017-03-09',12,2000);
Queries:
Write SQL queries to :
1. Count the customers with grades above Bangalore’s average.
2. Find the name and numbers of all salesmen who had more than one customer.
3. List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)
4. Create a view that finds the salesman who has the customer with the highest order of a day. 5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.
select count(customer_name) from Customer where grade > (select avg(grade) from Customer where city = "Bangalore");
select distinct c.salesman_id,s.salesman_name from Customer c,Salesman s where c.salesman_id = s.salesman_id
and 1 < (select count(customer_id) from Customer where salesman_id = c.salesman_id);
select s.salesman_name,c.customer_name from Salesman s,Customer c where s.salesman_id = c.salesman_id and c.city = s.city
union
select s.salesman_name,'No Match' from Salesman s,Customer c where s.salesman_id = c.salesman_id and c.city != s.city;
create view salesman_view as select o.order_date,salesman_id,sum(o.purchase_amt) from Orders o group by order_date having sum(purchase_amt) = (select max(sum(purchase_amt)) from Customer where order_date = o.order_date and salesman_id = o.salesman_id);
delete from Salesman where salesman_id = 1000; select * from Salesman;
select * from Orders;