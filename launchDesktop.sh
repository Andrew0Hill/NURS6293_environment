#!/bin/bash
# Script to launch the desktop from docker-compose.

# Interval between health checks
WAIT_INTERVAL=2
# Name of the database container.
DB_CONTAINER_NAME="nurs6293_database"

docker compose pull && docker compose up -d 

echo "Please keep this window open. Once database initialization is complete, a browser window will launch."
echo "This operation may take a few minutes if you are launching the environment for the first time."

WAIT_CHARS=("|" "/" "-" "\\")
N=${#WAIT_CHARS[@]}
INDEX=0

while [ $(docker inspect --format "{{json .State.Health.Status }}" $DB_CONTAINER_NAME) != '"healthy"' ]
do
    INDEX=$((($INDEX+1) % $N))
    PCHAR="${WAIT_CHARS[$INDEX]}"
    printf "\r$PCHAR Waiting for database to finish initializing..." && sleep $WAIT_INTERVAL
done

printf "\nDatabase intiialization complete, launching browser...\n"

case $(uname -s) in
    # Use open on MacOS
    Darwin)
        OPEN_CMD="open"
        ;;
    # For other Linux platforms, try xdg-open
    *)
        OPEN_CMD="xdg-open"
        ;;
esac

$OPEN_CMD "http://localhost:3000"
