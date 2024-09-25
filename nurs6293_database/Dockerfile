# Pull separate native images for both architectures.
# We have no architecture specific steps (like we did for the nurs6293_desktop), but we still
# want the database image to be native on the user's machine.
FROM postgres:15-bookworm@sha256:e9055d728ef0202154e2051fbc51349785f4ea13fd619b258e172691d09baf7b AS postgres-arm64
FROM postgres:15-bookworm@sha256:e051a411ec59ba883535de47f950dcf3621c9c2d794020c1c59576ab3f7a21dd AS postgres-amd64

# Pull from whichever architecture we are building this image for.
FROM postgres-${TARGETARCH} AS build-common

# SQL and Shell scripts in this directory are executed on DB init.
WORKDIR /docker-entrypoint-initdb.d

# Copy over the data dump. This file will now be executed after the default database is initialized.
COPY ./Scripts/nurs6293_createdb.sql.gz .
