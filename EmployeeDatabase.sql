show databases;
create database if not exists 1bm21cs123_employee;
use 1bm21cs123_employee;
show tables;

create table dept(
deptno int,
dname varchar(20),
dloc varchar(10),
primary key (deptno)
);

insert into dept
values(1,'Logistics','Bengaluru'),
(2,'Statistics','Mysuru'),
(3,'Marketing','Hyderabad'),
(4,'Design','Bengaluru'),
(5,'Management','Mysuru'),
(6,'Finance','Bombay');

select * from dept;

create table project(
pno int,
ploc varchar(20),
pname varchar(20),
primary key (pno)
);

insert into project
values(01,'Hyderabad','Project_Zero'),
(02,'Mysuru','Project_Alpha'),
(03,'Hyderabad','Project_Bozo'),
(04,'Bengaluru','Project_Waaris'),
(05,'Bombay','Project_Onslaught'),
(06,'Mysuru','Project_DivideBY');

select * from project;

create table incentives(
empno int,
incentive_date date,
incentive_amount int,
primary key (empno,incentive_date),
foreign key (empno) references employee(empno)
on delete cascade on update cascade
);

drop table incentives;

insert into incentives
values(101,'2022-10-01',5000),
(106,'2022-11-02',7000),
(102,'2022-05-03',5000),
(105,'2022-07-05',5000),
(110,'2022-08-07',9000);

select * from incentives;

create table employee(
empno int,
ename varchar(20),
mgr_no int,
hiredate date,
sal int,
deptno int,
primary key (empno),
foreign key (deptno) references dept (deptno)
on delete cascade on update cascade
);

insert into employee
values(101,'Avinash',2310,'2021-10-09',56000,1),
(102,'Dinesh',2317,'2021-03-07',96000,1),
(103,'Balaji',2510,'2021-10-08',66000,1),
(104,'Sovesh',9310,'2021-02-09',42000,2),
(105,'Sordelu',3310,'2021-03-04',76000,2),
(106,'Hasbulla',5561,'2022-01-05',47900,3),
(107,'Tacitus Kilgore',7810,'2021-11-19',420000,4),
(108,'Govardhan Prasad',4231,'2021-02-13',327100,5),
(109,'Champika',1324,'2021-07-14',87600,5),
(110,'Robin',6780,'2021-12-31',123000,5);

select * from employee;

create table assigned_to(
empno int,
pno int,
job_role varchar(20),
primary key(empno,pno),
foreign key(empno) references employee(empno)
on delete cascade on update cascade,
foreign key(pno) references project(pno)
on delete cascade on update cascade
);

insert into assigned_to
values(101,01,'Developer'),
(103,04,'Tester'),
(102,05,'Manager'),
(105,03,'Supervisor'),
(107,02,'Team Leader'),
(106,06,'Executive Manager');


select * from assigned_to;

#q3
select a.empno
from assigned_to a, project p
where a.pno = p.pno and p.ploc in ('Hyderabad','Mysuru','Bengaluru');

#q4
select e.empno
from employee e
where e.empno not in (select empno
from incentives);

#q5
select e.ename, e.empno, d.dname, a.job_role, d.dloc, p.ploc
from dept d, employee e, assigned_to a, project p
where e.empno = a.empno and a.pno = p.pno and e.deptno = d.deptno and d.dloc = p.ploc;
