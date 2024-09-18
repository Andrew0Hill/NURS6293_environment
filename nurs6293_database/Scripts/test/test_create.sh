#! /bin/bash

# export PGPASSWORD='changeme'; psql -h localhost -U postgres -d postgres  -f ./test_create.sql
export PGPASSWORD='nurs6293'; psql -h localhost -U student -d postgres  -f ./test_create.sql
