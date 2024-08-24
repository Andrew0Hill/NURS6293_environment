# NURS 6293 Docker Environment
This repository is a Docker-based desktop environment used for NURS 6293.

## Running the environment
1. Ensure you have Docker Desktop installed on your computer then run `docker-compose up` from the root directory of this repository. 
2. Navigate to `localhost:3000` in your web browser.
3. To connect to the Postgres container, use hostname `db:5432`.

## Building the environment

To build the docker image from scratch, execute `./build_image.sh` from the terminal. This script will attempt to download all program dependencies and build both the `arm64` and `amd64` versions of the image.



