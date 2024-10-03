#!/bin/bash
# This script will copy over some config files for PGModeler to:
#   1. Configure appearance (e.g switch to light mode)
#   2. Configure database connections (Postgres connection already set up)

PGMODELER_CONFIG_PATH="/config/.config/pgmodeler-1.0"

PGMODELER_CONFIG_FILES=("appearance.conf" "connections.conf")

# Make the directories if they don't exist
mkdir -p "$PGMODELER_CONFIG_PATH"

# For each of the pgModeler config files, check if the file exists at the destination path,
# and copy the file if it doesn't already exist.
for CONF_FILE in "${PGMODELER_CONFIG_FILES[@]}"
do
    CONF_FILE_PATH="$PGMODELER_CONFIG_PATH/$CONF_FILE"
    if [[ ! -f $CONF_FILE_PATH ]]
    then
        echo "Copying '$CONF_FILE'..."
        cp "/programs/config_files/pgmodeler/$CONF_FILE" "$CONF_FILE_PATH"
    fi
done