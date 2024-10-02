#!/bin/bash
# This script downloads and builds pgModeler from source. 
# In order for the script to work, all pgModeler dependencies should already
# be installed (e.g QMake, libpq/libpq-xx, libxml2, etc.)

# This script is nearly verbatim copied from the installation instructions
# provided at: https://pgmodeler.io/support/installation

# Compile and install the program to the default prefix (/usr/local)
INSTALL_PREFIX="/usr/local"
QT_ROOT="/usr/lib/qt6"

# Configure with Qmake
"$QT_ROOT/bin/qmake" -r "CONFIG+=release" \
                        "PREFIX=$INSTALL_PREFIX" \
                        "BINDIR=$INSTALL_PREFIX" \
                        "PRIVATEBINDIR=$INSTALL_PREFIX" \
                        "PRIVATELIBDIR=$INSTALL_PREFIX/lib" \
                        pgmodeler.pro

# Make and install 
make -j $(nproc) && make install

# Copy dependencies
mkdir $INSTALL_PREFIX/lib/qtplugins
mkdir $INSTALL_PREFIX/lib/qtplugins/imageformats
mkdir $INSTALL_PREFIX/lib/qtplugins/printsupport
mkdir $INSTALL_PREFIX/lib/qtplugins/platforms
echo -e "[Paths]\nPrefix=.\nPlugins=lib/qtplugins\nLibraries=lib" > $INSTALL_PREFIX/qt.conf
cd "$QT_ROOT/lib"
cp libQt6DBus.so.6 libQt6PrintSupport.so.6 libQt6Widgets.so.6 libQt6Network.so.6 libQt6Gui.so.6 \
   libQt6Core.so.6 libQt5XcbQpa.so.6 libQt6Svg.so.6 libicui18n.so.* libicuuc.so.* libicudata.so.* $INSTALL_PREFIX/lib
cd "$QT_ROOT/plugins"
cp -r imageformats/libqgif.so imageformats/libqico.so imageformats/libqjpeg.so \
      imageformats/libqsvg.so $INSTALL_PREFIX/lib/qtplugins/imageformats
cp -r printsupport/libcupsprintersupport.so $INSTALL_PREFIX/lib/qtplugins/printsupport
cp -r platforms/libqxcb.so platforms/libqoffscreen.so $INSTALL_PREFIX/lib/qtplugins/platforms
mkdir $INSTALL_PREFIX/lib/qtplugins/tls
cp -r platforms/tls/* $INSTALL_PREFIX/lib/qtplugins/tls

echo "pgModeler build complete."