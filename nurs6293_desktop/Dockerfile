# The build-arm64 stage builds the arm64 image.
FROM linuxserver/webtop:debian-mate@sha256:c074f90a3d2b09aabfb06a8d766c755a777dc2a20bf75d4d1a9d9e6895a43a15 AS build-arm64

# Move to the /program directory 
WORKDIR /programs

# Install BIRT (ARM64)
ARG BIRT_ARM64_BINARY="birt-report-designer-all-in-one-4.16.0-202406141054-linux.gtk.aarch64.tar.gz"
ADD "artifacts/${BIRT_ARM64_BINARY}" .
RUN mv eclipse/ birt/

# Install DBeaver (ARM64)
ARG DBEAVER_ARM64_BINARY="dbeaver-ce-latest-linux.gtk.aarch64-nojdk.tar.gz"
ADD "artifacts/${DBEAVER_ARM64_BINARY}" .

# Install pgModeler (AMD64)
ARG PGMODELER_ARM64_BINARY="pgmodeler_arm64.tar.gz"
ADD "artifacts/${PGMODELER_ARM64_BINARY}" /
#RUN cd /pgmodeler_src && make install && cd / && rm -rf pgmodeler_src

# The build-amd64 builds the AMD image.
FROM linuxserver/webtop:debian-mate@sha256:2aa4340147569caec3a3f797c8dd42d6a33332a4ea68dab37bf942912566b5bb AS build-amd64

# Move to the /program directory 
WORKDIR /programs

# Install BIRT (AMD64)
ARG BIRT_AMD64_BINARY="birt-report-designer-all-in-one-4.16.0-202406141054-linux.gtk.x86_64.tar.gz"
ADD "artifacts/${BIRT_AMD64_BINARY}" .
RUN mv eclipse/ birt/

# Install DBeaver (AMD64)
ARG DBEAVER_AMD64_BINARY="dbeaver-ce-latest-linux.gtk.x86_64-nojdk.tar.gz"
ADD "artifacts/${DBEAVER_AMD64_BINARY}" .

# Install pgModeler (AMD64)
ARG PGMODELER_AMD64_BINARY="pgmodeler_amd64.tar.gz"
ADD "artifacts/${PGMODELER_AMD64_BINARY}" /
#RUN cd /pgmodeler_src && make install && cd / && rm -rf pgmodeler_src

# At this stage, all architecture-specific configuration is done. 
# We can now perform a single set of steps for both architectures to complete the setup.
FROM build-${TARGETARCH} AS build-common

# Make this directory, which is required for openjdk-17-jre to install correctly.
RUN mkdir -p /usr/share/man/man1

# Install all dependencies needed for installed programs.
RUN apt update && apt install -y openjdk-17-jre \
                                 dconf-cli \
                                 qt6-base-dev \
                                 libpqxx-dev \
                                 libqt6svg6-dev \
                                 libxml2-dev \
                                 libxext-dev \
                                 libreoffice-writer \
                                 mate-utils

# Copy the JDBC Driver into the BIRT installation.
RUN mkdir -p "drivers/"
ARG JDBC_POSTGRES_JAR="postgresql-42.7.4.jar"
COPY "artifacts/${JDBC_POSTGRES_JAR}" "drivers/${JDBC_POSTGRES_JAR}"
# What a convenient location!
RUN cp "drivers/${JDBC_POSTGRES_JAR}" "/programs/birt/plugins/org.eclipse.birt.report.data.oda.jdbc_4.16.0.v202406141054/drivers/${JDBC_POSTGRES_JAR}"

# Configure desktop entries for each program.
# These entries allow the applications to show up in the app menu.
# COPY config/birt.desktop /usr/local/share/applications/birt.desktop
# COPY config/dbeaver.desktop /usr/local/share/applications/dbeaver.desktop
# COPY config/pgmodeler.desktop /usr/local/share/applications/pgmodeler.desktop
COPY config/desktop/*.desktop /usr/local/share/applications/
COPY config/desktop/mimeapps.list /usr/local/share/applications/

# Copy the BIRT config files
RUN mkdir -p "config_files/desktop"

# Eclipse config file (for BIRT default workspace)
ARG ECLIPSE_PREFS="birt/org.eclipse.ui.ide.prefs"
COPY "config/${ECLIPSE_PREFS}" "config_files/${ECLIPSE_PREFS}"

# BIRT workspace
ARG BIRT_WORKSPACE_TAR="birt/workspace.tar.gz"
COPY "config/${BIRT_WORKSPACE_TAR}" "config_files/${BIRT_WORKSPACE_TAR}" 

# pgModeler config files can be copied in all together.
ADD "config/pgmodeler" "config_files/pgmodeler"

# Change to script directory.
WORKDIR /scripts

# Make the custom start-script directory
# See: https://www.linuxserver.io/blog/2019-09-14-customizing-our-containers#custom-scripts
RUN mkdir -p /custom-cont-init.d

# Add custom launcher scripts and add to startup scripts in /custom-cont-init.d.
COPY config/setup_desktop.sh ./setup_desktop.sh
RUN chmod +x setup_desktop.sh && ln -s /scripts/setup_desktop.sh /custom-cont-init.d/setup_desktop.sh

COPY config/setup_birt.sh ./setup_birt.sh
RUN chmod +x setup_birt.sh && ln -s /scripts/setup_birt.sh /custom-cont-init.d/setup_birt.sh

COPY config/setup_pgmodeler.sh ./setup_pgmodeler.sh
RUN chmod +x setup_pgmodeler.sh && ln -s /scripts/setup_pgmodeler.sh /custom-cont-init.d/setup_pgmodeler.sh

# Move workdir back to root.
WORKDIR /