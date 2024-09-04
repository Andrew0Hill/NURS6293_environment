#!/bin/bash
# This script builds the nurs6293_desktop Docker image.

# Relative directory to download artifacts.
ARTIFACT_DIR="artifacts"

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

# Pull artifacts if not done already.
./pull_artifacts.sh $ARTIFACT_DIR

# Check if we have a multi-platform builder already created.
# Not sure why we can't build multi-arch with default builder (used to work no problem), but this step is now required.
# See: https://unix.stackexchange.com/questions/748633/error-multiple-platforms-feature-is-currently-not-supported-for-docker-driver

docker buildx ls | grep -q arm64-amd64-builder
if [[ $? == 1 ]]
then
    docker buildx create --use --platform=linux/arm64,linux/amd64 --name=arm64-amd64-builder
    docker buildx inpsect --bootstrap
fi

# Build image.
cd $CUR_DIR_PATH && docker buildx build --push --platform=linux/arm64,linux/amd64 --tag andrew2hill/nurs6293_desktop .
