#!/bin/bash
# This script builds the nurs6293_desktop Docker image.

IMAGE_DIR="nurs6293_desktop"
ARTIFACT_DIR="$IMAGE_DIR/artifacts"

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
cd $IMAGE_DIR && docker buildx build --load --platform=linux/arm64,linux/amd64 --tag nurs6293_desktop .
