show databases;
create database if not exists 1bm21cs123_airlines;
use 1bm21cs123_airlines;

create table flights(
flno int primary key,
_from varchar(40),
to_ varchar(40),
distance int,
departs time,
arrives time,
price int);

insert into flights
values(1,'Bengaluru','New Delhi',500,'6:00','9:00',5000),
(2,'Bengaluru','Chennai',300,'7:00','8:30',3000),
(3,'Trivandrum','New Delhi',800,'8:00','11:30',6000),
(4,'Bengaluru','Frankfurt',10000,'6:00','23:30',50000),
(5,'Kolkata','New Delhi',2400,'11:00','3:30',9000),
(6,'Bengaluru','Frankfurt',8000,'9:00','23:00',40000);

create table aircraft(
aid int primary key,
aname varchar(40),
cruising_range int
);

insert into aircraft
values(1,'Airbus',2000),
(2,'Boeing',700),
(3,'JetAirways',550),
(4,'Indigo',5000),
(5,'Boeing',4500),
(6,'Airbus',2200);

create table employees(
eid int primary key,
ename varchar(40),
salary int
);

insert into employees
values(101,'Avinash',50000),
(102,'Lokesh',60000),
(103,'Rakesh',70000),
(104,'Santhosh',82000),
(105,'Tilak',5000);

create table certified(
eid int,
aid int,
primary key(eid,aid),
foreign key(eid) references employees(eid) on delete cascade on update cascade,
foreign key(aid) references aircraft(aid) on delete cascade on update cascade
);
drop table certified;
insert into certified
values(101,2),
(101,4),
(101,5),
(101,6),
(102,1),
(102,3),
(102,5),
(103,2),
(103,3),
(103,5),
(103,6),
(104,6),
(104,1),
(104,3),
(105,3);

#actualsense
#todo1
select a.aname
from aircraft a
where not exists(select c.eid
                 from certified c,employees e
				         where c.aid=a.aid and c.eid=e.eid and e.salary < 80000);
#
#todo1
select a.aname
from aircraft a,employees e,certified c
where a.aid=c.aid and c.eid=e.eid and e.salary>80000;

#todo2
select c.eid, max(a.cruising_range)
from aircraft a,certified c
where a.aid = c.aid
group by c.eid
having count(c.aid) >= 3;

#todo3
select ename
from employees
where salary < (select min(price)
                from flights
                where _from = "Bengaluru" and to_ = "Frankfurt"
                group by _from, to_);

#todo4
select a.aid,a.aname,avg(e.salary)
from aircraft a,employees e,certified c
where a.aid=c.aid and c.eid=e.eid and a.cruising_range>1000
group by a.aid;

#todo5
select distinct  e.ename
from aircraft a,employees e,certified c
where a.aid=c.aid and c.eid=e.eid and a.aname="Boeing";

#todo6
select aid
from aircraft
where cruising_range >= (select distance
                         from flights
                         where _from = "Bengaluru" and to_ = "New Delhi");
