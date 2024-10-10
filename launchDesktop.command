#!/bin/bash

# Halt on error
set -e

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

# Launch the script, which should be in our current working directory.
./launchDesktop.sh
