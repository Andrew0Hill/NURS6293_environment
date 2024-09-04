FROM postgres:15-bookworm

# SQL and Shell scripts in this directory are executed on DB init.
WORKDIR /docker-entrypoint-initdb.d

# Copy over the data dump. This file will now be executed after the default database is initialized.
COPY ./Scripts/nurs6293_createdb.sql.gz .
