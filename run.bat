set BUILD_START_DIR=%CD%
set BUILD_MODE=%1
set BUILD_DIR_NAME=qt_%BUILD_MODE%_mingw64
set BUILD_OUTPUT_DIR=%BUILD_START_DIR%\%BUILD_DIR_NAME%
set BUILD_FLAG=-%BUILD_MODE%

curl -L -o 7zr.exe https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/7zr.exe
curl -L -o cmake-3.27.4-windows-x86_64.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/cmake-3.27.4-windows-x86_64.zip
curl -L -o MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z
curl -L -o ninja-win.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/ninja-win.zip
curl -L -o openssl-mingw-bin.tar.gz https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/openssl-mingw-bin.tar.gz
curl -L -o qt-everywhere-src-6.5.2.tar.xz https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/qt-everywhere-src-6.5.2.tar.xz
curl -L -o strawberry-perl-5.32.1.1-64bit.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/strawberry-perl-5.32.1.1-64bit.zip
curl -L -o 7z2301-extra.7z https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/7z2301-extra.7z

MKDIR strawberry
MKDIR ninja

echo Extracting cmake
tar -xf cmake-3.27.4-windows-x86_64.zip
echo Extracting Mingw
7zr x MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z -y
echo Extracting ninja
tar -xf ninja-win.zip -C ninja
echo Extracting openssl
tar -xzf openssl-mingw-bin.tar.gz
echo Extracting perl
tar -xf strawberry-perl-5.32.1.1-64bit.zip -C strawberry
echo Extracting qt
MKDIR 7z
cd 7z
..\7zr x ..\7z2301-extra.7z
cd ..
7zr x qt-everywhere-src-6.5.2.tar.xz -so | 7z\7za x -aoa -si -ttar

echo Clearing archives
RMDIR /S /Q 7z
REM RMDIR /S /Q qt-everywhere-src-6.5.2\qtwebengine
DEL 7z2301-extra.7z
DEL cmake-3.27.4-windows-x86_64.zip
DEL MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z
DEL ninja-win.zip
DEL openssl-mingw-bin.tar.gz
DEL strawberry-perl-5.32.1.1-64bit.zip
DEL qt-everywhere-src-6.5.2.tar.xz
REM DEL qt-everywhere-src-6.5.2.tar

SET CMAKE_PREFIX_PATH=%CD%\ffmpeg-6.0-full_build-shared;%BUILD_OUTPUT_DIR%
SET OPENSSL_ROOT_DIR=%CD%\openssl-mingw-bin
SET LLVM_INSTALL_DIR=%CD%\libclang
SET PATH=%CD%\ninja;%CD%\mingw64\bin;%CD%\cmake-3.27.4-windows-x86_64\bin;%CD%\strawberry\perl\bin;%BUILD_OUTPUT_DIR%\bin;%CD%\qt-everywhere-src-6.5.2;%WINDIR%\system32;%WINDIR%

echo Starting build
set FULL_SOURCE_DIRECTORY=%CD%\qt-everywhere-src-6.5.2

IF NOT DEFINED CI_ANDROID_ABI (
call %BUILD_START_DIR%\scripts\build.bat
) ELSE (
call %BUILD_START_DIR%\scripts\build_android.bat
)

CD %BUILD_START_DIR%
tar -czf %BUILD_DIR_NAME%.tar.gz %BUILD_DIR_NAME%

REM call %BUILD_START_DIR%\scripts\build_docs.bat
