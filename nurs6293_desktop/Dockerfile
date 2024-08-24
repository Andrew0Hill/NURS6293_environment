FROM linuxserver/webtop:debian-xfce AS build-common

# Move to the /program directory 
WORKDIR /programs

# Make this directory, which is required for openjdk-17-jre to install correctly.
RUN mkdir -p /usr/share/man/man1

# Install all dependencies needed for installed programs.
RUN apt update && apt install -y openjdk-17-jre \
                                 git \
                                 qt6-base-dev \
                                 libpqxx-dev \
                                 libqt6svg6-dev \
                                 build-essential \
                                 libxml2-dev \
                                 libxext-dev 

# For BIRT and DBeaver, we download architecture specific binaries for amd64 or arm64 architecture.
FROM build-common AS build-arm64

# Install BIRT (ARM64)
ARG BIRT_ARM64_BINARY="birt-report-designer-all-in-one-4.16.0-202406141054-linux.gtk.aarch64.tar.gz"
ADD "artifacts/${BIRT_ARM64_BINARY}" .
RUN mv eclipse/ birt/

# Install DBeaver (ARM64)
ARG DBEAVER_ARM64_BINARY="dbeaver-ce-latest-linux.gtk.aarch64-nojdk.tar.gz"
ADD "artifacts/${DBEAVER_ARM64_BINARY}" .

FROM build-common AS build-amd64

# Install BIRT (AMD64)
ARG BIRT_AMD64_BINARY="birt-report-designer-all-in-one-4.16.0-202406141054-linux.gtk.x86_64.tar.gz"
ADD "artifacts/${BIRT_AMD64_BINARY}" .
RUN mv eclipse/ birt/

# Install DBeaver (AMD64)
ARG DBEAVER_AMD64_BINARY="dbeaver-ce-latest-linux.gtk.x86_64-nojdk.tar.gz"
ADD "artifacts/${DBEAVER_AMD64_BINARY}" .

FROM build-${TARGETARCH} AS build-full

# Install pgModeler from source. Since we are not using a binary, we don't need separate commands for ARM64 vs AMD64.
ADD artifacts/pgmodeler ./pgmodeler
ADD build_pgmodeler.sh ./pgmodeler/build_pgmodeler.sh
RUN cd ./pgmodeler && \
    chmod +x ./build_pgmodeler.sh && \
    ./build_pgmodeler.sh && \
    rm ./build_pgmodeler.sh

# Configure desktop entries for each program.
# These entries allow the applications to show up in the app menu.
ADD config/birt.desktop /usr/local/share/applications/birt.desktop
ADD config/dbeaver.desktop /usr/local/share/applications/dbeaver.desktop
ADD config/pgmodeler.desktop /usr/local/share/applications/pgmodeler.desktop

# Run the script which creates the application launchers on the desktop.
ADD config/create_launchers.sh ./create_launchers.sh
RUN chmod +x create_launchers.sh && \
    ./create_launchers.sh
