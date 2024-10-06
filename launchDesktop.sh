#!/bin/bash
# Script to launch the desktop from docker-compose.
WAIT_INTERVAL=5

docker compose pull && \
docker compose up -d && \
echo "Please wait for $WAIT_INTERVAL seconds..." && \
sleep $WAIT_INTERVAL && \
open http://localhost:3000
