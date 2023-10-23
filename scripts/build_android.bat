SET ANDROID_BASE=%BUILD_START_DIR%\android_tools
SET ANDROID_NDK_ROOT=%ANDROID_BASE%\android-ndk-r25b
SET ANDROID_SDK_ROOT=%ANDROID_BASE%\SDK
SET QT_HOST=%ANDROID_BASE%\qt_release_mingw64
SET MINGW_ROOT=%BUILD_START_DIR%\mingw64\bin

RMDIR /S /Q %ANDROID_BASE%
MKDIR %ANDROID_BASE%
CD %ANDROID_BASE%

MKDIR %ANDROID_SDK_ROOT%
MKDIR %ANDROID_SDK_ROOT%\platforms
MKDIR %ANDROID_SDK_ROOT%\build-tools

curl -L -o platform-tools_r33.0.0-windows.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/platform-tools_r33.0.0-windows.zip
tar -xf platform-tools_r33.0.0-windows.zip
DEL platform-tools_r33.0.0-windows.zip
MOVE platform-tools %ANDROID_SDK_ROOT%

curl -L -o build-tools_r33-windows.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/build-tools_r33-windows.zip
tar -xf build-tools_r33-windows.zip
DEL build-tools_r33-windows.zip
MOVE android-13 %ANDROID_SDK_ROOT%\build-tools\33.0.0

curl -L -o platform-33-ext3_r03.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/platform-33-ext3_r03.zip
tar -xf platform-33-ext3_r03.zip
DEL platform-33-ext3_r03.zip
MOVE android-13 %ANDROID_SDK_ROOT%\platforms\android-33

curl -L -o qt_release_mingw64.tar.gz https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/qt_release_mingw64.tar.gz
tar -xzf qt_release_mingw64.tar.gz
DEL qt_release_mingw64.tar.gz

curl -L -o android-ndk-r25b-windows.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/android-ndk-r25b-windows.zip
tar -xf android-ndk-r25b-windows.zip
DEL android-ndk-r25b-windows.zip

RMDIR /S /Q %BUILD_START_DIR%\openssl-mingw-bin

echo Modules to build: qtbase, qtimageformats, ^
    qtlanguageserver, qtshadertools, qtsvg, ^
    qtdeclarative, qtquicktimeline, qtquick3d, ^
    qtmultimedia, qt3d, qt5compat, qtactiveqt, ^
    qtcharts, qtcoap, qtconnectivity, qtdatavis3d, ^
    qtwebsockets, qthttpserver, qttools, qtserialport, ^
    qtpositioning, qtwebchannel, qtwebengine, qtdoc, ^
    qtgrpc, qtlocation, qtlottie, qtmqtt, qtnetworkauth, ^
    qtopcua, qtquick3dphysics, qtquickeffectmaker, ^
    qtremoteobjects, qtscxml, qtsensors, qtserialbus, ^
    qtspeech, qttranslations, qtvirtualkeyboard, ^
    qtwayland, qtwebview

set HELPER_PATH=%BUILD_START_DIR%\scripts\build_default.bat

echo Preparing: qtbase
CD %FULL_SOURCE_DIRECTORY%\qtbase
MKDIR out && CD out
call ..\configure.bat -platform android-clang ^
    -android-ndk %ANDROID_NDK_ROOT% -android-sdk %ANDROID_SDK_ROOT% ^
    -qt-host-path %QT_HOST% -android-abis %CI_ANDROID_ABI% -qt-zlib -qt-libjpeg ^
    -qt-libpng -qt-freetype -qt-pcre -qt-harfbuzz ^
    -prefix %BUILD_OUTPUT_DIR% -release ^
    -opensource -nomake examples -nomake tests
cmake --build . --parallel
cmake --install .
CD %FULL_SOURCE_DIRECTORY%
RMDIR /S /Q qtbase\out

call %HELPER_PATH% qtimageformats qtlanguageserver ^
    qtshadertools qtsvg qtdeclarative qtquicktimeline ^
    qtquick3d

echo Preparing: qtmultimedia
CD %BUILD_START_DIR%
CD %FULL_SOURCE_DIRECTORY%\qtmultimedia
MKDIR out && CD out
call qt-configure-module.bat ..
cmake --build . --parallel
cmake --install .
CD %FULL_SOURCE_DIRECTORY%
RMDIR /S /Q qtmultimedia\out

call %HELPER_PATH% qt3d qt5compat qtactiveqt ^
    qtcharts qtcoap qtconnectivity qtdatavis3d ^
    qtwebsockets qthttpserver

echo Preparing: qttools
CD %BUILD_START_DIR%
CD %FULL_SOURCE_DIRECTORY%\qttools
MKDIR out && CD out
call qt-configure-module.bat ..
cmake --build . --parallel
cmake --install .
CD %FULL_SOURCE_DIRECTORY%
RMDIR /S /Q qttools\out

call %HELPER_PATH% qtserialport qtpositioning qtwebchannel

echo Not preparing: qtwebengine
echo Reason: Chromium build not supported using Mingw

call %HELPER_PATH% qtdoc qtgrpc qtlocation qtlottie ^
    qtmqtt qtnetworkauth qtopcua qtquick3dphysics ^
    qtquickeffectmaker qtremoteobjects qtscxml ^
    qtsensors qtserialbus qtspeech qttranslations ^
    qtvirtualkeyboard qtwayland qtwebview
