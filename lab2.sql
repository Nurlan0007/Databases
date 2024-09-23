create database lab2;
create table countries (
    country_id serial primary key,
    country_name varchar(255),
    region_id int,
    population int
);

insert into countries( country_name, region_id, population)
values ('USA',1,331100232);

insert into countries (country_name)
values ('Canada');

insert into countries(country_name, region_id, population)
values ('Mexico', null, 12315454);

insert into countries(country_name, region_id, population)
values ('Germany', 2, 83213313),
       ('France', 2,5435353),
       ('Japan', 3, 23940111);

alter table countries
alter column country_name set default 'Kazakhstan';

insert into countries(country_name, region_id, population)
values (4,18343455);

insert into countries default values;

create table countries_new(like countries including all);

insert into countries_new select * from countries;

update countries
set region_id = 1
where  region_id is null;

select country_name, population * 1.1 as "New Population"
from countries;

delete from countries
where population < 100000;

delete from countries_new
where  country_id in (select country_id from countries)
returning *;
delete from countries
returning *;