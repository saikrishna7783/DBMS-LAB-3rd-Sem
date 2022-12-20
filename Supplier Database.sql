show databases;
create database if not exists 1bm21cs123_supplier;
use 1bm21cs123_supplier;
show tables;

create table supplier(
sid int,
sname varchar(20),
city varchar(20),
primary key (sid)
);
select * from supplier;
insert into supplier
values(10001,'Acme Widget','Bangalore'),
(10002,'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),
(10004,'Reliance','Delhi');

create table parts(
pid int,
pname varchar(20),
color varchar(20),
primary key (pid)
);
select * from parts;
insert into parts
values(20001,'Book','Red'),
(20002,'Pen','Red'),
(20003,'Pencil','Green'),
(20004,'Mobile','Green'),
(20005,'Charger','Black');

create table catalog(
sid int,
pid int,
cost int,
primary key (sid,pid),
foreign key (sid) references supplier(sid)
on delete cascade on update cascade,
foreign key (pid) references parts(pid)
on delete cascade on update cascade
);
select * from catalog;
insert into catalog
values(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

#todo3
select distinct p.pname
from parts p,catalog c
where sid is not null;

#todo7
select s.sid
from supplier s, catalog c
where s.sid = c.sid and c.cost > (select avg(c1.cost)
                                  from catalog c1
                                  where c1.pid = c.pid
                                  group by c1.pid);
