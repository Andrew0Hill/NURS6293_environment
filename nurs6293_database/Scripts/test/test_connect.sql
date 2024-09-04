drop database if exists nurs6293;
create role student_grp with nologin;
create role student with login password 'nurs6293' in role student_grp;
create database nurs6293 with owner student_grp;
grant CREATE on database nurs6293 to student_grp;

\connect nurs6293;
set role student_grp;


create schema if not exists test_schema;

drop table if exists test_schema.test_table;
create table test_schema.test_table (
    id integer NOT NULL,
    first_col character(10),
    second_col character(10)
);

insert into test_schema.test_table(id, first_col, second_col) values (111,'first','second');
insert into test_schema.test_table(id, first_col, second_col) values (222,'next','last');

select * from test_schema.test_table;

/*
drop table test_schema.test_table;
drop schema test_schema;
*/