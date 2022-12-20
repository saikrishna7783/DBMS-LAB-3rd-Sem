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

#todo4
select distinct s.sname
from supplier s, catalog c
where s.sid = c.sid and (select distinct count(c1.pid) from catalog c1 where c1.sid = s.sid group by c1.sid) = (select distinct count(*) from parts);

#todo5
select s.sname
from supplier s
where (select count(*) from catalog c1, supplier s1, parts p1 where c1.pid = p1.pid and c1.sid = s1.sid and color = "Red" and c1.sid = s.sid group by color) = (select count(*) from parts where color="Red" group by color);

#todo6
select p.pname
from parts p, catalog c
where p.pid = c.pid and c.sid = (select sid from supplier where sname ="Acme Widget") and not exists(select * from catalog c1 where c1.pid = c.pid and c1.sid != c.sid);

#todo7
select s.sid
from supplier s, catalog c
where s.sid = c.sid and c.cost > (select avg(c1.cost)
                                  from catalog c1
                                  where c1.pid = c.pid
                                  group by c1.pid);

#todo8
select s.sname, c.pid
from supplier s, catalog c
where s.sid = c.sid and c.cost = (select max(c1.cost)
                                  from catalog c1
                                  where c1.pid = c.pid
                                  group by c1.pid);
