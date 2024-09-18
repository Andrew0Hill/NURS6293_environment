CREATE ROLE student_grp with NOLOGIN CREATEDB NOINHERIT;
CREATE ROLE student PASSWORD 'nurs6293' NOSUPERUSER LOGIN INHERIT in role student_grp;
ALTER ROLE student CREATEDB;


\connect emr50k;
revoke all on all tables in schema public from student_grp;
alter default privileges in schema public revoke all on tables from student_grp;
alter default privileges in schema public grant select on tables to student_grp;
alter default privileges in schema public grant all on sequences to student_grp;
grant usage on schema public to student_grp;
grant select on all tables in schema public to student_grp;
grant usage on all sequences in schema public to student_grp;
ALTER ROLE student CREATEDB;

\connect emr100;
revoke all on all tables in schema public from student_grp;
alter default privileges in schema public revoke all on tables from student_grp;
alter default privileges in schema public grant select on tables to student_grp;
alter default privileges in schema public grant all on sequences to student_grp;
grant usage on schema public to student_grp;
grant select on all tables in schema public to student_grp;
grant usage on all sequences in schema public to student_grp;
ALTER ROLE student CREATEDB;

\connect install;
revoke all on all tables in schema public from student_grp;
alter default privileges in schema public revoke all on tables from student_grp;
alter default privileges in schema public grant select on tables to student_grp;
alter default privileges in schema public grant all on sequences to student_grp;
grant usage on schema public to student_grp;
grant select on all tables in schema public to student_grp;
grant usage on all sequences in schema public to student_grp;
ALTER ROLE student CREATEDB;

\connect synthea;
revoke all on all tables in schema public from student_grp;
alter default privileges in schema public revoke all on tables from student_grp;
alter default privileges in schema public grant select on tables to student_grp;
alter default privileges in schema public grant all on sequences to student_grp;
grant usage on schema public to student_grp;
grant select on all tables in schema public to student_grp;
grant usage on all sequences in schema public to student_grp;
ALTER ROLE student CREATEDB;
