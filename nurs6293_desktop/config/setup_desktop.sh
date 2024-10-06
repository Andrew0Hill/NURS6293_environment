#!/bin/bash
# This script sets up the user's desktop with some helpful links.

# All three *.desktop files must already exist within the docker container (at LAUNCHER_ROOT) for this script to work.
# Because we have the Desktop mounted as a shared volume, we need to run this script after launch to create the launchers.
LAUNCHER_ROOT="/usr/local/share/applications"
LAUNCHERS=("birt.desktop" "pgmodeler.desktop")

# First we create the desktop folder if it does not exist.
mkdir -p "/config/Desktop"

for LAUNCHER in "${LAUNCHERS[@]}"
do
    LAUNCHER_PATH="/config/Desktop/$LAUNCHER"
    if [[ ! -f $LAUNCHER_PATH ]]
    then
        cp "$LAUNCHER_ROOT/$LAUNCHER" $LAUNCHER_PATH && chmod +x $LAUNCHER_PATH
    fi
done

# Change ownership of Desktop and all files to abc user.
chown -hR abc:abc "/config/Desktop"
