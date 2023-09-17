curl -L -o 7zr.exe https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/7zr.exe
curl -L -o cmake-3.27.4-windows-x86_64.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/cmake-3.27.4-windows-x86_64.zip
curl -L -o libclang-release_140-based-windows-mingw_64.7z https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/libclang-release_140-based-windows-mingw_64.7z
curl -L -o MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z
curl -L -o ninja-win.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/ninja-win.zip
curl -L -o openssl-mingw-bin.tar.gz https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/openssl-mingw-bin.tar.gz
curl -L -o qt-everywhere-src-6.5.2.tar.xz https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/qt-everywhere-src-6.5.2.tar.xz
curl -L -o strawberry-perl-5.32.1.1-64bit.zip https://github.com/FetheredSerpent/qt-mingw64/releases/download/dependencies/strawberry-perl-5.32.1.1-64bit.zip

MKDIR strawberry
MKDIR ninja

tar -xf cmake-3.27.4-windows-x86_64.zip
7zr x libclang-release_140-based-windows-mingw_64.7z
7zr x MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z
tar -xf ninja-win.zip -C ninja
tar -xzf openssl-mingw-bin.tar.gz
tar -xf strawberry-perl-5.32.1.1-64bit.zip -C strawberry
tar -xJf qt-everywhere-src-6.5.2.tar.xz

DEL cmake-3.27.4-windows-x86_64.zip
DEL libclang-release_140-based-windows-mingw_64.7z
DEL MinGW-w64-x86_64-11.2.0-release-posix-seh-rt_v9-rev1.7z
DEL ninja-win.zip
DEL openssl-mingw-bin.tar.gz
DEL strawberry-perl-5.32.1.1-64bit.zip
DEL qt-everywhere-src-6.5.2.tar.xz

SET OPENSSL_ROOT_DIR=%CD%\openssl-mingw-bin
SET LLVM_INSTALL_DIR=%CD%\libclang
SET PATH=%CD%\ninja;%CD%\mingw64\bin;%CD%\cmake-3.27.4-windows-x86_64\bin;%CD%\strawberry\perl\bin;%CD%\qt-everywhere-src-6.5.2;%PATH%

CD qt-everywhere-src-6.5.2
MKDIR out 
CD out
rem configure -qt-zlib -qt-libjpeg -qt-libpng -qt-freetype -qt-pcre -qt-harfbuzz -openssl-runtime -opengl dynamic -prefix %CD%\qt_release_mingw64 -release -opensource -nomake examples -nomake tests -skip qtwebengine
rem mingw32-make install

rem tar -czf ..\..\qt_release_mingw64.tar.gz %CD%\qt_release_mingw64
