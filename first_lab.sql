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

create table CAR
(
    REG_NUM char(10),
    MODEL varchar(20),
    YEAR int(4),
    primary key (REG_NUM)
);

alter table CAR
modify YEAR int not null;

create table ACCIDENT
(
    REPORT_NUM int,
    ACCIDENT_DATE date not null,
    LOCATION varchar(30) not null,
    primary key (REPORT_NUM)
);

create table OWNS
(
    DRIVER_ID char(11),
	REG_NO char(10),
    primary key(DRIVER_ID,REG_NO),
    foreign key (DRIVER_ID) references PERSON(DRIVER_ID),
    foreign key (REG_NO) references CAR(REG_NUM)
);

create table PARTICIPATED
(
    DRIVER_ID char(10),
    REG_NUM char(10),
    REPORT_NUM int,
    DAMAGE_AMOUNT int,
    primary key (DRIVER_ID, REG_NUM, REPORT_NUM),
    foreign key (DRIVER_ID) references PERSON(DRIVER_ID),
    foreign key (REG_NUM) references CAR(REG_NUM),
    foreign key (REPORT_NUM) references ACCIDENT(REPORT_NUM)
);

insert into ACCIDENT
values();

insert into CAR
values();

insert into PERSON
values();