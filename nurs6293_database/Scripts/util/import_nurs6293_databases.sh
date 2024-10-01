#! /bin/bash

echo "Extracting SQL...."
rm -f nurs6293_createdb.sql
tar -xzf nurs6293_createdb.sql.gz

echo "Populating Postgres with NURS6293 data
export PGPASSWORD='postgres'; psql -h localhost -U postgres -d postgres  -f ./nurs6293_createdb.sql
