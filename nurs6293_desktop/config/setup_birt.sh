#!/bin/bash
# This script attempts to configure some defaults for BIRT, including 
#   1. A default BIRT workspace directory.
#   2. Default connection profiles for each database.

# Path to the Eclipse/BIRT workspace.
WORKSPACE_PATH="/config/Desktop/workspace"
# Path to where Eclipse stores settings (used for setting default workspace path.)
ECLIPSE_SETTINGS_PATH="/config/.eclipse/org.eclipse.platform_4.32.0_961481574_linux_gtk_aarch64/configuration/.settings"

# Make the directories if they don't exist
mkdir -p "$WORKSPACE_PATH"
mkdir -p "$ECLIPSE_SETTINGS_PATH"

# If the config file doesn't exist, copy it.
ECLIPSE_PREFS_DEST_PATH="$ECLIPSE_SETTINGS_PATH/org.eclipse.ui.ide.prefs"
if [[ ! -f "$ECLIPSE_PREFS_DEST_PATH" ]]
then
    echo "Copying Eclipse configuration file..."
    cp /programs/config_files/org.eclipse.ui.ide.prefs "$ECLIPSE_PREFS_DEST_PATH"
fi

# If connection profile store doesn't exist, copy it in.
CONNECTION_PROFILES_DEST_PATH="$WORKSPACE_PATH/nurs6293_connection_profiles.cps"
if [[ ! -f "$CONNECTION_PROFILES_DEST_PATH" ]]
then
    echo "Copying default connection profiles..."
    cp /programs/config_files/nurs6293_connection_profiles.cps "$WORKSPACE_PATH/"
fi
