#!/bin/bash
# Script to launch the desktop from docker-compose.
WAIT_INTERVAL=5

docker compose up -d && echo "Please wait for $WAIT_INTERVAL seconds..." && open http://localhost:3000
