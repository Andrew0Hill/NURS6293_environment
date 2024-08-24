#!/bin/bash
# This script downloads and builds pgModeler from source. 
# In order for the script to work, all pgModeler dependencies should already
# be installed (e.g QMake, libpq/libpq-xx, libxml2, etc.)

# This script is nearly verbatim copied from the installation instructions
# provided at: https://pgmodeler.io/support/installation

# Compile and install the program to the default prefix (/usr/local)
INSTALL_PREFIX="/usr/local"

# Configure with Qmake
/usr/lib/qt6/bin/qmake -r CONFIG +=release \
                          PREFIX=$INSTALL_PREFIX \
                          BINDIR=$INSTALL_PREFIX \
                          PRIVATEBINDIR=$INSTALL_PREFIX \
                          PRIVATELIBDIR=$INSTALL_PREFIX/lib \
                          pgmodeler.pro

# Make and install 
make -j $(nproc --ignore=1) && make install
