create database bank_database;
use bank_database;

create table branch(
branch_name varchar(30) primary key,
branch_city varchar(40),
assets real
);

create table bank_account(
acc_no int,
branch_name varchar(40),
balance real,
primary key(acc_no,branch_name),
foreign key(branch_name) references branch(branch_name)

);

create table depositer(
customer_name varchar(30),
acc_no int,
primary key(customer_name,acc_no),
foreign key(acc_no) references bank_account(acc_no),
foreign key(customer_name) references bank_customer(customer_name)

);

create table bank_customer(
customer_name varchar(30) primary key,
customer_city varchar(40),
customer_street varchar(50)
);

create table loan(
branch_name varchar(30),
loan_number int primary key,
amount real,
foreign key(branch_name) references branch(branch_name)

);

insert into branch
values('HDFC_Chamrajpet','Bengaluru',50000),('HDFC_AnandRaoCircle','Bengaluru',10000),('HDFC_ShivajiRoad','Mumbai',20000),('HDFC_ParliamentRoad','Delhi',10000),('HDFC_Jantarmantar','Delhi',20000);

insert into bank_account
values(1,'HDFC_Chamrajpet',2000),(2,'HDFC_AnandRaoCircle',5000),(3,'HDFC_ShivajiRoad',6000),(4,'HDFC_ParliamentRoad',9000),(5,'HDFC_Jantarmantar',8000),(6,'HDFC_ShivajiRoad',4000),(8,'HDFC_AnandRaoCircle',4000),(9,'HDFC_ParliamentRoad',3000),(10,'HDFC_AnandRaoCircle',5000),(11,'HDFC_Jantarmantar',2000);

insert into bank_customer
values('Avinash','Bull_Temple_Road','Bangalore'),('Dinesh','Bannergatta_Road','Bangalore'),('Mohan','NationalCollege_Road','Bangalore'),('Nikil','Akbar_Road','Delhi'),('Ravi','Prithviraj_Road','Delhi');

insert into depositer
values('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),('Avinash',8),('Nikil',9),('Dinesh',10),('Nikil',11);

insert into loan
values('HDFC_Chamrajpet',1,1000),('HDFC_AnandRaoCircle',2,2000),('HDFC_ShivajiRoad',3,3000),('HDFC_ParliamentRoad',4,4000),('HDFC_Jantarmantar',5,5000);
