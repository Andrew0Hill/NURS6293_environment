#!/bin/bash
# This script attempts to configure some defaults for BIRT, including 
#   1. A default BIRT workspace directory.
#   2. Default connection profiles for each database.

# Path to the Eclipse/BIRT workspace.
WORKSPACE_PATH="/config/Desktop/host_shared"
WORKSPACE_TAR="birt_workspace.tar.gz"
# Path to where Eclipse stores settings (used for setting default workspace path.)
ECLIPSE_BASE_PATH="/config/.eclipse"
ECLIPSE_SETTINGS_PATH="$ECLIPSE_BASE_PATH/org.eclipse.platform_4.32.0_961481574_linux_gtk_$(uname -m)/configuration/.settings"

# Make the directories if they don't exist
mkdir -p "$WORKSPACE_PATH"
mkdir -p "$ECLIPSE_SETTINGS_PATH"

# If the config file doesn't exist, copy it.
ECLIPSE_PREFS_DEST_PATH="$ECLIPSE_SETTINGS_PATH/org.eclipse.ui.ide.prefs"
cp --no-clobber /programs/config_files/birt/org.eclipse.ui.ide.prefs "$ECLIPSE_PREFS_DEST_PATH"

# if [[ ! -f "$ECLIPSE_PREFS_DEST_PATH" ]]
# then
#     echo "Copying Eclipse configuration file..."
#     # Copy in the preferences file.
#     cp /programs/config_files/birt/org.eclipse.ui.ide.prefs "$ECLIPSE_PREFS_DEST_PATH"
# fi

# If workspace directory doesn't exist, copy it in.
if [[ ! -d "$WORKSPACE_PATH/birt_workspace" ]]
then
    echo "Creating workspace directory"
    cp "/programs/config_files/birt/$WORKSPACE_TAR" "$WORKSPACE_PATH/$WORKSPACE_TAR" && cd "$WORKSPACE_PATH" && tar -xzf "$WORKSPACE_TAR" && rm "$WORKSPACE_TAR"
fi
# CONNECTION_PROFILES_DEST_PATH="$WORKSPACE_PATH/nurs6293_connection_profiles.cps"
# if [[ ! -f "$CONNECTION_PROFILES_DEST_PATH" ]]
# then
#     echo "Copying default connection profiles..."
#     cp /programs/config_files/nurs6293_connection_profiles.cps "$WORKSPACE_PATH/"
# fi

# Copy the custom templates into the birt program directory.
BIRT_TEMPLATE_DIR="/programs/birt/plugins/org.eclipse.birt.resources_4.16.0.v202406141054/templates"
CUSTOM_TEMPLATE_DIR="/programs/config_files/birt/resources/templates"

# List of templates we should copy.
CUSTOM_TEMPLATE_PATHS=($(find "$CUSTOM_TEMPLATE_DIR" -name "*.rpttemplate"))

# Copy each custom template in to replate the original BIRT template.
# Never overwrite these files.
for CUSTOM_TEMPLATE_PATH in "${CUSTOM_TEMPLATE_PATHS[@]}"
do
    CUSTOM_TEMPLATE_NAME=$(basename "$CUSTOM_TEMPLATE_PATH")
    cp --no-clobber "$CUSTOM_TEMPLATE_PATH" "${BIRT_TEMPLATE_DIR}/${CUSTOM_TEMPLATE_NAME}"
done

# Modify directory ownership for both directories.
chown -hR abc:abc $WORKSPACE_PATH
chown -hR abc:abc $ECLIPSE_BASE_PATH
