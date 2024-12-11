#!/bin/bash
# This script sets up the user's desktop with some helpful links.

# All three *.desktop files must already exist within the docker container (at LAUNCHER_ROOT) for this script to work.
# Because we have the Desktop mounted as a shared volume, we need to run this script after launch to create the launchers.
LAUNCHER_ROOT="/usr/local/share/applications"
LAUNCHERS=("birt.desktop" "pgmodeler.desktop" "libreoffice-writer.desktop" "mate-terminal.desktop" "mate-screenshot.desktop" "chromium.desktop")

# First we create the desktop folder if it does not exist.
mkdir -p "/config/Desktop"

# Copy the desktop entries.
for LAUNCHER in "${LAUNCHERS[@]}"
do
    LAUNCHER_PATH="/config/Desktop/$LAUNCHER"
    if [[ ! -f $LAUNCHER_PATH ]]
    then
        cp "$LAUNCHER_ROOT/$LAUNCHER" $LAUNCHER_PATH && chmod +x $LAUNCHER_PATH
    fi
done

# Create the data models folder.
DATA_MODELS_DIR="/config/Desktop/data_models"
mkdir -p "$DATA_MODELS_DIR"
# List of models to copy.
DATA_MODELS=("Bariatric Surgery.dbm")

for DATA_MODEL in "${DATA_MODELS[@]}"
do
    MODEL_PATH="$DATA_MODELS_DIR/$DATA_MODEL"
    if [[ ! -f "$MODEL_PATH" ]]
    then
        cp "/programs/data_models/$DATA_MODEL" "$MODEL_PATH"
    fi
done
# Make the data_models directory read-only
chmod -R 555 "$DATA_MODELS_DIR"

# Make the autostart folder if it doesn't exist
mkdir -p "/config/.config/autostart" 

# Copy the desktop entry which sets the background into the autostart folder.
if [[ ! -f "/config/.config/autostart/set_background.desktop" ]]
then
    cp "$LAUNCHER_ROOT/set_background.desktop" "/config/.config/autostart/" && \
    chown -hR abc:abc "/config/.config/autostart"
fi

# Set up the bookmarks for the Caja file manager.
mkdir -p "/config/.config/gtk-3.0" 
if [[ ! -f "/config/.config/gtk-3.0/bookmarks" ]]
then
    echo "file:///config/Desktop/data_models" >> "/config/.config/gtk-3.0/bookmarks"
    echo "file:///config/Desktop/host_shared" >> "/config/.config/gtk-3.0/bookmarks"
    chown -hR abc:abc "/config/.config/gtk-3.0"
fi

# if [[ ! -f "/config/.config/mimeapps.list" ]]
# then
#     cp "$LAUNCHER_ROOT/mimeapps.list" "/config/.config/" && \
#     chown abc:abc /config/.config/mimeapps.list
# fi

# Change ownership of Desktop and all files to abc user.
chown -hR abc:abc "/config/Desktop"
