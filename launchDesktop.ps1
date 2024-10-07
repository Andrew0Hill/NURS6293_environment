# Script to launch the desktop from docker-compose.
$wait_interval = 2
$db_container_name = "nurs6293_database"

docker compose pull; if($?) {docker compose up -d}

Write-Host "Please keep this window open. Once database initialization is complete, a browser window will launch."
Write-Host "This operation may take a few minutes if you are launching the environment for the first time."

$wait_chars = @("|", "/", "-", "\")
$index = 0

$health_status = docker inspect --format "{{json .State.Health.Status }}" $db_container_name

while ($health_status -ne """healthy""" ) {
    $index = ($index + 1) % $wait_chars.length
    $pchar = $wait_chars[$index]
    Write-Host -NoNewLine "`r$pchar Waiting for database to finish initializing..."
    Start-Sleep -Seconds $wait_interval 
    $health_status = docker inspect --format "{{json .State.Health.Status }}" $db_container_name
}

Write-Host "`nDatabase intiialization complete, launching browser...."
Start-Process "http://localhost:3000"
