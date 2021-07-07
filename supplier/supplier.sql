create database supplier; use supplier; create table suppliers(
sid int primary key, sname varchar(30),
address varchar(30) );
create table parts(
pid int primary key,
pname varchar(30),
color varchar(30) );
create table catalog ( sid int ,
pid int , cost real,
constraint c_sid foreign key(sid) references suppliers(sid) , constraint c_pid foreign key(pid) references parts(pid)
);
insert into suppliers values(1,'acme widget','Bangalore') ; insert into suppliers values(2,'natural','Chenai') ; insert
into suppliers values(3,'ss','Hyderabad') ; insert into
suppliers values(4,'Godrej','Kolkata') ; insert into
suppliers values(5,'Nestle','delhi') ; insert into parts values(1,'paint','red') ; insert into parts values(2,'paint','green') ; insert into parts values(3,'tiles','white') ; insert into parts values(4,'tires','white'); insert into parts values(5,'plates','red');
insert into parts values(5,'tiles','white');
insert into catalog values(1,1,150); insert into catalog values(1,2,250); insert into


select s.sname from suppliers s where s.sid in (select c.sid from catalog c where c.cost=(select max(cost) from catalog ca where ca.pid=c.pid));
select ca.pid from catalog ca where ca.sid=(select s.sid from suppliers s where s.sname ='Acme Widget') having (select count(c.pid) from catalog c where c.pid=ca.pid)=1;
select distinct c.sid from catalog c where c.cost > ( select avg (c1.cost) from catalog c1 where c1.pid = c.pid );
select distinct c.sid from catalog c;
select distinct c.sid from catalog c where not exists ( select * from parts p where p.pid = c.pid and p.color = ‘red’ );