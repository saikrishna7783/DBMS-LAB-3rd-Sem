# Week 1
#--------------------------------------------------------------------------------------------

show databases;
create database if not exists 1BM21CS123_driving_insurance;
use 1BM21CS123_driving_insurance;
show tables;

create table PERSON
(
    DRIVER_ID char(10) primary key,
    NAME varchar(30) not null,
    ADDRESS varchar(50) not null
);
# (#, -- and multi-line one /*blahblah*/ : theses are comments) drop table if exists PERSON;
truncate table person;
desc PERSON;
select *
from PERSON;

create table CAR
(
    REG_NUM char(10),
    MODEL varchar(20),
    YEAR int(4),
    primary key (REG_NUM)
);
drop table car;
alter table CAR
modify YEAR int not null;

desc CAR;
select *
from CAR;

create table ACCIDENT
(
    REPORT_NUM int,
    ACCIDENT_DATE date not null,
    LOCATION varchar(30) not null,
    primary key (REPORT_NUM)
);
drop table accident;
desc ACCIDENT;
select *
from ACCIDENT;

create table OWNS
(
    DRIVER_ID char(11),
	REG_NO char(10),
    primary key(DRIVER_ID,REG_NO),
    foreign key (DRIVER_ID) references PERSON(DRIVER_ID),
    foreign key (REG_NO) references CAR(REG_NUM) ON DELETE CASCADE ON UPDATE CASCADE
);

drop table owns;
desc OWNS;
select *
from OWNS;

create table PARTICIPATED
(
    DRIVER_ID char(10),
    REG_NUM char(10),
    REPORT_NUM int,
    DAMAGE_AMOUNT int,
    primary key (DRIVER_ID, REG_NUM, REPORT_NUM),
    foreign key (DRIVER_ID) references PERSON(DRIVER_ID),
    foreign key (REG_NUM) references CAR(REG_NUM),
    foreign key (REPORT_NUM) references ACCIDENT(REPORT_NUM) ON DELETE CASCADE ON UPDATE CASCADE
);

drop table participated;
desc PARTICIPATED;
select *
from PARTICIPATED;

desc PERSON;
select *
from PERSON;

insert into ACCIDENT
values
(11,"2003-01-01","Mysore Road"),
(12,"2003-02-02","South End Circle"),
(13,"2003-01-21","Bull Temple Road"),
(14,"2008-02-17","Mysore Road"),
(15,"2004-03-05","Kanakapura Road");

insert into CAR
values
("KA052250","Indica",1990),
("KA031181","Lancer",1957),
("KA095477","Toyota",1998),
("KA053408","Honda",2008),
("KA041702","Audi",2005);

insert into PERSON
values
("A01","Richard","Srinivas Nagar"),
("A02","Pradeep","Rajajinagar"),
("A03","Smith","Ashok Nagar"),
("A04","Venu","NR Colony"),
("A05","John","Hanumanth Nagar");

insert into OWNS
values
("A01","KA052250"),
("A02","KA053408"),
("A03","KA031181"),
("A04","KA095477"),
("A05","KA041702");

truncate table owns;

insert into PARTICIPATED
values
("A01","KA052250",11,10000),
("A02","KA053408",12,50000),
("A03","KA095477",13,25000),
("A04","KA031181",14,3000),
("A05","KA041702",15,5000);

# Week 2
#--------------------------------------------------------------------------------------------

# Exemplar Queries
# -> Q1
select *
from car order by year asc;

# -> Q2
select count(report_num)
from car c, participated p
where p.reg_num = c.reg_num and c.model="Lancer";

# -> Q3
select count(distinct driver_id)
from participated p, accident a
where p.report_num=a.report_num and a.accident_date like "2008%";

# ->  To do queries
# 1)
select *
from participated order by damage_amount desc;

# 2)
select avg(damage_amount)
from participated;

# 3)
delete from participated where damage_amount < (select t.amt from(select avg(damage_amount) as amt from participated) t) ;
rollback

# 4)
select p.name
from person p, participated d
where p.driver_id = d.driver_id and d.damage_amount > (select avg(damage_amount) from participated) ;

# 5)
select max(damage_amount)
from participated;

# Onspot Queries
# 1)
select c.model
from accident a, car c
where c.reg_num="KA01" or c.reg_num="KA02" or c.reg_num="KA03" or c.reg_num="KA04" or c.reg_num="KA05";

select c.model
from car c, accident a, participated p
where a.report_num = p.report_num and c.reg_num = p.reg_num and a.location = "Bull Temple Road";
