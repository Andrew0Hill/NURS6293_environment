/* Simple test suite that creates a new DB, creates new table, inserts rows, deletes rows, drops table
*/

drop database if exists test_db;
create database test_db;
\c test_db;
set role student;

drop table if exists test_table;
create table test_table (
    id integer NOT NULL,
    first_col character(10),
    second_col character(10)
);

insert into test_table(id, first_col, second_col) values (111,'first','second');
insert into test_table(id, first_col, second_col) values (222,'next','last');

select * from test_table;

delete
from test_table
where id=111;

select * from test_table;

drop table test_table;
\c postgres;
drop database test_db;