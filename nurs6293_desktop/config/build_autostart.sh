#!/bin/bash
# This script creates an entry in ~/.config/autostart for create_launchers.sh

AUTOSTART_FILE="/config/.config/autostart/create_launchers.desktop"

if [[ ! -f  $AUTOSTART_FILE ]]
then
    echo "[Desktop Entry]" >> $AUTOSTART_FILE
    echo "Name=create_launchers" >> $AUTOSTART_FILE
    echo "Type=Application" >> $AUTOSTART_FILE
    echo "Exec=/programs/create_launchers.sh" >> $AUTOSTART_FILE
    echo "Terminal=false" >> $AUTOSTART_FILE
    echo "StartupNotify=false" >> $AUTOSTART_FILE
fi
   
