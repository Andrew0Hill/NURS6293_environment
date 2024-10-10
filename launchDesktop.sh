#!/bin/bash
# Script to launch the desktop from docker-compose.

# Halt on error
set -e

# Interval between health checks
WAIT_INTERVAL=2

# Name of the database container.
DB_CONTAINER_NAME="nurs6293_database"

# Get the path to the script directory.
CUR_DIR=$(dirname -- "$0")
CUR_DIR_PATH=$(realpath "$CUR_DIR")

# Move into the correct directory if we are not there already.
PWD=$(pwd)
 echo "Current working directory is '$PWD'."
if [[ "$PWD" != "$CUR_DIR_PATH" ]]
then
   echo "Moving to '$CUR_DIR_PATH' to execute script."
    cd "$CUR_DIR_PATH"
fi

# Pull most recent docker image and bring up docker compose.
docker compose pull && docker compose up -d 

# Print status messages.
echo "Please keep this window open. Once database initialization is complete, a browser window will launch."
echo "This operation may take a few minutes if you are launching the environment for the first time."

# Characters to print to indicate we are waiting.
WAIT_CHARS=("|" "/" "-" "\\")
N=${#WAIT_CHARS[@]}
INDEX=0

# Iterate and print a wait message until DB container is healthy.
while [ $(docker inspect --format "{{json .State.Health.Status }}" $DB_CONTAINER_NAME) != '"healthy"' ]
do
    INDEX=$((($INDEX+1) % $N))
    PCHAR="${WAIT_CHARS[$INDEX]}"
    printf "\r$PCHAR Waiting for database to finish initializing..." && sleep $WAIT_INTERVAL
done

# Print a final status message.
printf "\nDatabase intiialization complete, launching browser...\n"

# Depending if we are running on OSX or Unix, select the command to open browser.
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

# Open the browser to the desktop.
$OPEN_CMD "http://localhost:3000"
