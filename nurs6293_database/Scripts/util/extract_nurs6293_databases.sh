#! /bin/bash

echo "Extracting databases"
export PGPASSWORD='postgres'; pg_dumpall --clean --if-exists --host=localhost --port=5432 --username=postgres --file=dump.sql