#! /bin/bash

export PGPASSWORD='changeme'; psql -h localhost -U postgres -d postgres  -f ./wipe_all.sql

