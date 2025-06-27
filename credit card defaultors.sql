create database credit_card;
use credit_card;

create table clients (
client_id int primary key,
age int,
gender varchar(10),
income float,
city varchar(50),
educational_level varchar (100)
);

insert into clients
values
(1, 28,"male",45000,"delhi","postgraduate"),
(2,26,"female",60000,"mumbai","postgraduate"),
(3,22,"female",70000,"banglore","undergraduate"),
(4,35,"male",55000,"gurgaon","postgraduate"),
(5,44,"female",40000,"delhi","graduate"),
(6,48,"male",45000,"lucknow","graduate"),
(7,50,"male",90000,"banglore","postgradaute"),
(8,39,"female",67000,"gurgaon","graduate"),
(9,33,"male",43000,"mumbai","graduate"),
(10,27,"female",56000,"delhi","postgraduate");

create table payment (
payment_id int primary key,
client_id int,
payment_date date,
amount_paid float,
minimum_due float,
foreign key (client_id) references clients(client_id)
);

insert into payment
values
(1001,1,"2025-01-15", 10000,2700),
(1002,2,"2025-03-01",10800,7400),
(1003,3,"2025-01-17",23000,7600),
(1004,4,"2025-04-30",1000,5100),
(1005,5,"2025-02-20",0,6000),
(1006,6,"2025-03-15",10000,4900),
(1007,7,"2025-05-18",33400,900),
(1008,8,"2025-06-08",29300,1300),
(1009,9,"2025-03-18",0,6200),
(1010,10,"2025-06-21",17700,400);

create table defaults (
client_id int,
default_date date,
default_flag boolean,
foreign key (client_id) references clients(client_id)
);

insert into defaults
values
(1,"2025-02-15",1),
(2,"2025-03-29",1),
(3,null,0),
(4,"2025-05-30",1),
(5,"2025-04-20",1),
(6,"2025-03-15",1),
(7,null,0),
(8,null,0),
(9,"2025-05-18",1),
(10,null,0);

select client_id,
sum(case when amount_paid >= minimum_due then 1 else 0 end) as on_time_payment
from payment
group by client_id;

select c.client_id, c.age,c.city 
from clients as c
join defaults as d on c.client_id = d.client_id
where d.default_flag =1;

select 
case 
when income < 50000 then "low income"
when income between 51000 and 61000 then "medium income"
else "high income"
end as income_group,
count(*) as total_clients,
sum( case when d.default_flag =1 then 1 else 0 end ) as deafultors
from clients as c 
join defaults as d on c.client_id =d.client_id
group by income_group;
