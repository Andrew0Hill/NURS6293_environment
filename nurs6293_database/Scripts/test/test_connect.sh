#! /bin/bash

export PGPASSWORD='changeme'; psql -h localhost -U postgres -d postgres  -f ./test_connect.sql
