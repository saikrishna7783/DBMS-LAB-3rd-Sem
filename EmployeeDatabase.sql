create table dept(
deptno int,
dname varchar(20),
dloc varchar(10),
primary key (deptno)
);

create table project(
pno int,
ploc varchar(20),
pname varchar(20),
primary key (pno)
);

create table incentives(
empno int,
incentive_date date,
incentive_amount int,
primary key (empno,incentive_date)
);

create table employee(
empno int,
ename varchar(20),
mgr_no int,
hiredate date,
sal int,
deptno int,
primary key (empno),
foreign key (deptno) references dept (dno)
on delete cascade on update cascade
);

create table assigned-to(
empno int,
pno int,
job_role varchar(20),
primary key(empno,pno),
foreign key(empno) references employee(empno),
foreign key(pno) references project(pno)
on delete cascade on update cacade
);

insert into employee
values()

#q3
select a.empno
from assigned-to a, project p
where a.pno = p.pno and p.loc in ('Hyderabad','Mysuru','Bengaluru');

#q4
select e.empno
from employee e
where e.empno not in (select empno
from incentives);

#q5
select e.ename, e.empno, d.dname, a.job_role, d.dloc, p.ploc
from dept d, employee e, assigned-to a, project p
where e.empno = a.empno and a.pno = p.pno and e.deptno = d.deptno and d.dloc = p.ploc;
