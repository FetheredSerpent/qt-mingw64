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
call ..\configure.bat -qt-zlib -qt-libjpeg -qt-libpng ^
    -qt-freetype -qt-pcre -qt-harfbuzz -openssl-runtime ^
    -opengl dynamic -prefix %BUILD_OUTPUT_DIR% -release ^
    -opensource -nomake examples -nomake tests -no-sql-psql
cmake --build . --parallel
cmake --install .
CD %FULL_SOURCE_DIRECTORY%
RMDIR /S /Q qtbase\out

call %HELPER_PATH% qtimageformats qtlanguageserver ^
    qtshadertools qtsvg qtdeclarative qtquicktimeline ^
    qtquick3d

echo Preparing: qtmultimedia
CD %BUILD_START_DIR%
curl -L -o ffmpeg-6.0-full_build-shared.7z https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/ffmpeg-6.0-full_build-shared.7z
echo Extracting ffmpeg
7zr x ffmpeg-6.0-full_build-shared.7z
DEL ffmpeg-6.0-full_build-shared.7z
CD %FULL_SOURCE_DIRECTORY%\qtmultimedia
MKDIR out && CD out
call qt-configure-module.bat ..
cmake --build . --parallel
cmake --install .
CD %FULL_SOURCE_DIRECTORY%
RMDIR /S /Q qtmultimedia\out
RMDIR /S /Q %BUILD_START_DIR%\ffmpeg-6.0-full_build-shared

call %HELPER_PATH% qt3d qt5compat qtactiveqt ^
    qtcharts qtcoap qtconnectivity qtdatavis3d ^
    qtwebsockets qthttpserver

echo Preparing: qttools
CD %BUILD_START_DIR%
curl -L -o libclang-release_140-based-windows-mingw_64.7z https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/libclang-release_140-based-windows-mingw_64.7z
echo Extracting libclang
7zr x libclang-release_140-based-windows-mingw_64.7z -y
DEL libclang-release_140-based-windows-mingw_64.7z
CD %FULL_SOURCE_DIRECTORY%\qttools
MKDIR out && CD out
call qt-configure-module.bat ..
cmake --build . --parallel
cmake --install .
CD %FULL_SOURCE_DIRECTORY%
RMDIR /S /Q qttools\out
RMDIR /S /Q %BUILD_START_DIR%\libclang

call %HELPER_PATH% qtserialport qtpositioning qtwebchannel

echo Not preparing: qtwebengine
echo Reason: Chromium build not supported using Mingw

call %HELPER_PATH% qtdoc qtgrpc qtlocation qtlottie ^
    qtmqtt qtnetworkauth qtopcua qtquick3dphysics ^
    qtquickeffectmaker qtremoteobjects qtscxml ^
    qtsensors qtserialbus qtspeech qttranslations ^
    qtvirtualkeyboard qtwayland qtwebview
