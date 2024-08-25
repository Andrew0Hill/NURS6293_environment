#!/bin/bash
# Script to launch the desktop from docker-compose.

docker-compose up -d

open http://localhost:3000
