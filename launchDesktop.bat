@echo off
REM Script to launch the desktop from docker-compose.

docker compose up -d

set wait_interval=5

echo "Please wait for %wait_interval% seconds..."

timeout /t %wait_interval% /nobreak

start "" http://localhost:3000
