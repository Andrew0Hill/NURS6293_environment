# NURS 6293 Docker Environment
This repository is a Docker-based desktop environment used for NURS 6293.

# Running the environment

## Running via launch script
The easiest way to launch the environment is to locate the `launchDesktop.*` scripts in the root of this repository, and run the script appropriate for your operating system (`.sh` for Unix/MacOS and `.bat` for Windows)

These scripts are a wrapper around `docker compose` which will start the containers and open a browser window to `localhost:3000` after launch.

## Running via `docker compose`
1. Ensure you have Docker Desktop installed on your computer then run `docker compose up` from the root directory of this repository. 
2. Navigate to `localhost:3000` in your web browser.
3. To connect to the Postgres container, use hostname `postgres:5432`.


# Building the environment

This repository contains subdirectories for the components of the nurs6293_environment:

1. `nurs6293_database/` - Contains the configuration for the Postgres database container.
2. `nurs6293_desktop/` - Contains the configuration for the XFCE Desktop container. 

To build either image, `cd` into either `nurs6293_database` or `nurs6293_desktop` subdirectory.

## Single-architecture build

To build for a single architecture, you could use a command like:
```
docker build -t nurs6293_desktop .
```
from the `nurs6293_desktop/` subdirectory to build the image locally. 

> [!WARNING]
> Depending on the image, you may need to pull dependent binaries/artifacts which the Dockerfile will expect to find. 
> You can reference the `build_image.sh` scripts in each directory for the steps that should be taken to pull these dependencies.

## Multi-architecture build

Building multi-arch images on a single machine will require some extra configuration, and the use of `docker buildx`. You can reference the `build_image.sh` script in each directory for guidance on performing a multi-architecture build.

> [!WARNING]
> Running the `build_image.sh` scripts locally will likely fail at the last step, since you do not have push permission to the appropriate DockerHub repository. Using the `--load` option will also not work for multi-architecture builds. 
> If you are building an image for local use or testing, you should perform a [single-architecture build](#single-architecture-build) for your current architecture.




