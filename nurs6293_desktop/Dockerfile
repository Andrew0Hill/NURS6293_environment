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

# Copy the JDBC Driver into the BIRT installation.
RUN mkdir -p "drivers/"
ARG JDBC_POSTGRES_JAR="postgresql-42.7.4.jar"
ADD "artifacts/${JDBC_POSTGRES_JAR}" "drivers/${JDBC_POSTGRES_JAR}"
# What a convenient location!
RUN cp "drivers/${JDBC_POSTGRES_JAR}" "/programs/birt/plugins/org.eclipse.birt.report.data.oda.jdbc_4.16.0.v202406141054/drivers/${JDBC_POSTGRES_JAR}"

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

# Copy the BIRT config files
RUN mkdir -p "config_files/"

# Eclipse config file (for default workspace)
ARG ECLIPSE_PREFS="org.eclipse.ui.ide.prefs"
ADD "config/${ECLIPSE_PREFS}" "config_files/${ECLIPSE_PREFS}"

# BIRT connection profiles
ARG BIRT_CONNECTION_PROFILES="nurs6293_connection_profiles.cps"
ADD "config/${BIRT_CONNECTION_PROFILES}" "config_files/${BIRT_CONNECTION_PROFILES}"

# Change to script directory.
WORKDIR /scripts

# Make the custom start-script directory
# See: https://www.linuxserver.io/blog/2019-09-14-customizing-our-containers#custom-scripts
RUN mkdir -p /custom-cont-init.d

# Add custom launcher scripts and add to startup scripts in /custom-cont-init.d.
ADD config/setup_desktop.sh ./setup_desktop.sh
RUN chmod +x setup_desktop.sh && ln -s /scripts/setup_desktop.sh /custom-cont-init.d/setup_desktop.sh

ADD config/setup_birt.sh ./setup_birt.sh
RUN chmod +x setup_birt.sh && ln -s /scripts/setup_birt.sh /custom-cont-init.d/setup_birt.sh

# Move workdir back to root.
WORKDIR /