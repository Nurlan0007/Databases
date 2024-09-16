create database lab1;
create table users(
    id serial,
    firstname varchar(50),
    lastname varchar(50),
    primary key (id)
);
alter table users
add column isadmin int;
alter table users
alter isadmin boolean;
alter table users
alter isadmin set default false;

create table tasks(
    id serial,
    name varchar(50),
    user_id int,
    primary key (id),
);
drop table tasks;
drop database lab1;


