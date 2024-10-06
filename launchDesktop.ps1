# Script to launch the desktop from docker-compose.
$wait_interval = 5
$db_container_name = "nurs6293_database"

docker compose pull; if($?) {docker compose up -d}

$health_status = docker inspect --format "{{json .State.Health.Status }}" $db_container_name

while ($health_status -ne """healthy""" ) {
    Write-Output "Waiting for database to finish initializing..."
    Start-Sleep -Seconds $wait_interval 
    $health_status = docker inspect --format "{{json .State.Health.Status }}" $db_container_name
}

Write-Output "Database intiialization complete, launching browser...."
Start-Process "http://localhost:3000"
