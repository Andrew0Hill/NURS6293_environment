#!/bin/bash
# This script runs a simple healthcheck on the database, to check if it has finished configuration.
NROWS_EXPECTED=1760

NROWS=$(psql -Atq -U postgres -d synthea -c "SELECT COUNT(1) FROM synthea.public.provider")

if [[ $NROWS != $NROWS_EXPECTED ]]
then
    exit 1
fi