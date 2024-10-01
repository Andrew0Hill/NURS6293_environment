#! /bin/bash

# From https://serverfault.com/questions/857339/backing-up-restoring-postgres-using-pg-dumpall-split-gzip-set-on-error
# In Docker, PG executes initdb before executing scripts placed in /docker-entrypoint-initdb.d, which creates the postgres user
# The pg_dumpall command assumes a completely empty PG server without an existing postgres user
# The alternative is to use pg_dump for each database of the 13 databases individually plus running roles.sql first because pg_dump doesn't capture roles.
#
# Step 1: Do "standard" pg_dumpall into dump.sql
# Step 2: Remove lines that DROP/CREATE postgres superuser account since it already exists


echo "Deleting existing dump.sql (if present)"
rm -f dump.sql
echo "Extracting databases into dump.sql"
export PGPASSWORD='postgres'; pg_dumpall --clean --if-exists --host=postgres --port=5432 --username=postgres --file=dump.sql

if [ -f ./dump.sql ]; then
    echo "Deleting existing nurs6293_createdb.sql.gz (if present)"
    rm -f nurs6293_createdb.sql.gz
    echo "Removing CREATE/ALTER postgres role; creating new nurs6293_createdb.sql.gz"
    cat dump.sql | sed '/^DROP ROLE.*postgres/d;/^CREATE ROLE.*postgres/d;/^ALTER ROLE postgres*/d' | gzip > nurs6293_createdb.sql.gz
else
    echo 'dump.sql does not exist in current directory. Existing extract file (if present) not deleted'
fi

