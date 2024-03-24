#!/bin/sh

export FULL_SOURCE_DIRECTORY=/work/qt-everywhere-src-6.5.2
export BUILD_OUTPUT_DIR=/work/qt_release_lnx

function basic_build() {
    echo Preparing: $1
    cd $FULL_SOURCE_DIRECTORY/$1
    mkdir out && cd out
    qt-configure-module ..
    cmake --build . --parallel
    cmake --install .
    cd $FULL_SOURCE_DIRECTORY
    rm -rf $1/out
}

echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8\nnameserver 8.8.4.4\n" > /etc/resolv.conf
mkdir $BUILD_OUTPUT_DIR
apk update
apk add alpine-sdk cmake perl ninja-build ninja-is-really-ninja \
  openssl-dev ffmpeg-dev clang14-libclang glib-dev libx11-dev \
  libxfixes-dev libxi-dev libxext-dev libice-dev libsm-dev \
  libxrender-dev libxcb-dev xcb-util-renderutil-dev xcb-util-wm-dev \
  xcb-util-keysyms-dev xcb-util-image-dev libxkbcommon-dev \
  flite-dev gstreamer-dev mesa-dev at-spi2-core-dev glib-dev vulkan-headers

cd $FULL_SOURCE_DIRECTORY
cd qtbase
mkdir out && cd out
../configure --help
../configure -qt-zlib -qt-libjpeg -qt-libpng \
    -qt-freetype -qt-pcre -qt-harfbuzz -openssl-runtime \
    -DQT_FEATURE_opengles2=ON -prefix %BUILD_OUTPUT_DIR% -release \
    -opensource -nomake examples -nomake tests -no-sql-psql\
    -bundled-xcb-xinput

for module in qtimageformats qtlanguageserver qtshadertools qtsvg \
  qtdeclarative qtquicktimeline qtquick3d qtmultimedia qt3d qt5compat \
  qtactiveqt qtcharts qtcoap qtconnectivity qtdatavis3d qtwebsockets \
  qthttpserver qttools qtserialport qtpositioning qtwebchannel qtdoc \
  qtgrpc qtlocation qtlottie qtmqtt qtnetworkauth qtopcua qtquick3dphysics \
  qtquickeffectmaker qtremoteobjects qtscxml qtsensors qtserialbus qtspeech \
  qttranslations qtvirtualkeyboard qtwayland qtwebview; do
  
    basic_build $module
done

cd /tmp
tar -czf qt_release_lnx.tar.gz alpine
