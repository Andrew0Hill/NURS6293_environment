#!/bin/bash
# This script will copy over some config files for LibreOffice to:
#   1. Stop quote replacement in LibreOffice Writer.

# Path where config files should be copied to.
LIBREOFFICE_CONFIG_PATH="/config/.config/libreoffice/4/user"

# Finds all files in the libreoffice config directory.
LIBREOFFICE_CONFIG_FILES=($(find /programs/config_files/libreoffice -type f))

# For each of the LibreOffice config files, check if the file exists at the 
# destination path, and copy the file if it doesn't already exist.
for CONF_FILE_SRC_PATH in "${LIBREOFFICE_CONFIG_FILES[@]}"
do
    # Get the base name of this file.
    CONF_FILE_BASENAME=$(basename "$CONF_FILE_SRC_PATH")

    # Create the destination file path.
    CONF_FILE_DEST_PATH="$LIBREOFFICE_CONFIG_PATH/$CONF_FILE_BASENAME"

    # If file doesn't exist at the destination, copy it over.
    if [[ ! -f $CONF_FILE_DEST_PATH ]]
    then
        # Make the directory for this file if it doesn't exist.
        CONF_FILE_DEST_DIR=$(dirname $CONF_FILE_DEST_PATH)
        mkdir -p "$CONF_FILE_DEST_DIR"

        # Copy the file from src to destination.
        echo "Copying '$CONF_FILE_SRC_PATH'..."
        cp "$CONF_FILE_SRC_PATH" "$CONF_FILE_DEST_PATH"
    fi
done

# Make abc user the owner of the config directory.
chown -hR abc:abc /config/.config/libreoffice
