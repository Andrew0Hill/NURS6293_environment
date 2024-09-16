#!/bin/bash
# This script pulls binaries used to build the NURS 6293 image.

# Directory where binaries should be stored.
OUTPUT_DIR="${1:-artifacts}"

pull_url() {
    local URL="$1"
    local OUTPUT_PATH="$2"

    if [[ ! -f $OUTPUT_PATH ]]
    then
        echo "Downloading '$OUTPUT_PATH'..."
        curl -L -o "$OUTPUT_PATH" "$URL"

    else
        echo "Skipping '$OUTPUT_PATH', file already exists..."
    fi
}

# Make the directory if not exists.
mkdir -p "$OUTPUT_DIR"
echo "Binaries will be downloaded to '$OUTPUT_DIR'..."

# JDBC Postgres Driver (v4.27.4)
JDBC_POSTGRES_BASE_URL="https://jdbc.postgresql.org/download"
JDBC_POSTGRES_JAR="postgresql-42.7.4.jar"
pull_url "$JDBC_POSTGRES_BASE_URL/$JDBC_POSTGRES_JAR" "$OUTPUT_DIR/$JDBC_POSTGRES_JAR"

# Eclipse BIRT Download (v4.16.0)
BIRT_BASE_URL="https://mirror.umd.edu/eclipse/birt/updates/release/4.16.0/downloads"
BIRT_ARM64_BINARY="birt-report-designer-all-in-one-4.16.0-202406141054-linux.gtk.aarch64.tar.gz"
BIRT_AMD64_BINARY="birt-report-designer-all-in-one-4.16.0-202406141054-linux.gtk.x86_64.tar.gz"

pull_url "$BIRT_BASE_URL/$BIRT_ARM64_BINARY" "$OUTPUT_DIR/$BIRT_ARM64_BINARY"
pull_url "$BIRT_BASE_URL/$BIRT_AMD64_BINARY" "$OUTPUT_DIR/$BIRT_AMD64_BINARY"

echo "Downloaded BIRT binaries..."

# DBeaver Download 
DBEAVER_BASE_URL="https://dbeaver.io/files"
DBEAVER_ARM64_BINARY="dbeaver-ce-latest-linux.gtk.aarch64-nojdk.tar.gz" 
DBEAVER_AMD64_BINARY="dbeaver-ce-latest-linux.gtk.x86_64-nojdk.tar.gz"

pull_url "$DBEAVER_BASE_URL/$DBEAVER_ARM64_BINARY" "$OUTPUT_DIR/$DBEAVER_ARM64_BINARY"
pull_url "$DBEAVER_BASE_URL/$DBEAVER_AMD64_BINARY" "$OUTPUT_DIR/$DBEAVER_AMD64_BINARY"

echo "Downloaded DBeaver binaries..."

# pgModeler Download

# Clone the repository.
PGMODELER_PATH="$OUTPUT_DIR/pgmodeler"
if [[ ! -d $PGMODELER_PATH ]]
then    
    git clone https://github.com/pgmodeler/pgmodeler.git $PGMODELER_PATH

    echo "Cloned pgModeler repository..."
else
    echo "Skipped cloning '$PGMODELER_PATH', directory already exists..."
fi
# Make sure we've checked out the correct version.
cd "${OUTPUT_DIR}/pgmodeler" && git checkout v1.1.4

# Done.
echo "All steps complete."