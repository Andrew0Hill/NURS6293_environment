#!/bin/bash
# Script to launch the desktop from docker-compose.

# Interval between health checks
WAIT_INTERVAL=5
# Name of the database container.
DB_CONTAINER_NAME="nurs6293_database"

docker compose pull && docker compose up -d 

while [ $(docker inspect --format "{{json .State.Health.Status }}" $DB_CONTAINER_NAME) != '"healthy"' ]
do
    echo "Waiting for database to finish initializing..." && sleep $WAIT_INTERVAL
done

echo "Database intiialization complete, launching browser...."
open http://localhost:3000
