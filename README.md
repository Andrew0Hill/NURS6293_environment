# NURS 6293 Docker Environment
This repository is a Docker-based desktop environment used for NURS 6293.

# Running the environment

## Running via launch scripts
The easiest way to launch the environment is to locate the `launchDesktop.*` scripts in the root of this repository, and run the script appropriate for your operating system.

These scripts are a wrapper around `docker compose` which will start the containers and open a browser window to `localhost:3000` after launch.

| OS         | Script                        |
|------------|-------------------------------|
| Windows    | `./launchDesktop.lnk`         |
| MacOS      | `./launchDesktop.command`[^1] | 
| Unix/Linux | `./launchDesktop.sh`          |

[^1]: MacOS can also utilize the `./launchDesktop.sh` script, but `./launchDesktop.command` provides the ability to launch by double-clicking. 



## Running via `docker compose`
1. Ensure you have Docker Desktop installed on your computer.
2. Run `docker compose pull && docker compose up` from the root directory of this repository. 
2. Navigate to `localhost:3000` in your web browser.
3. To connect to the Postgres container, use hostname `postgres:5432` from within the desktop container. 


# Building the environment

This repository contains subdirectories for the components of the nurs6293_environment:

1. `nurs6293_database/` - Contains the configuration for the Postgres database container.
2. `nurs6293_desktop/` - Contains the configuration for the XFCE Desktop container. 

To build either image, `cd` into either `nurs6293_database` or `nurs6293_desktop` subdirectory.

## Single-architecture build

To build for a single architecture, you can use the `./build_image.sh` script available in each directory. 

When running the script, use the `--dev` option to build a single image which is compatible with your local machine's architecture, like:

```
cd nurs6293_desktop
sudo ./build_image.sh --dev
```


> [!WARNING]
> To build the `nurs6293_desktop` image, you may need to pull dependent binaries/artifacts which the Dockerfile will expect to find. 
> You can reference the `build_image.sh` scripts in each directory for the steps that should be taken to pull these dependencies.

## Multi-architecture build

To build images for multiple architectures, use the `./build_image.sh` script with the `--prod` option, like:

```
cd nurs6293_desktop
sudo ./build_image.sh --prod
```

> [!WARNING]
> Running `./build_image.sh --prod` will attempt to push to DockerHub, and will likely fail unless you have permissions for the DockerHub repositories.
> If you are building an image for local use or testing, you should perform a [single-architecture build](#single-architecture-build) for your current architecture.




