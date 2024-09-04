#! /bin/bash


echo "Extracting SQL...."
rm -f nurs6293_createdb.sql
tar -xzf nurs6293_createdb.sql.tar.gz

export PGPASSWORD='postgres'; psql -h localhost -U postgres -d postgres  -f ./nurs6293_createdb.sql

# Creates a test schema and table in nurs6293 database with role student_grp
# export PGPASSWORD='nurs6293'; psql -h localhost -U student  -d nurs6293  -f ./nurs6293_createdb3_testdb.sql
