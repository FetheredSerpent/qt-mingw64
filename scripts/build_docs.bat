CD %FULL_SOURCE_DIRECTORY%
MKDIR out && CD out
call ..\configure.bat -qt-zlib -qt-libjpeg -qt-libpng ^
    -qt-freetype -qt-pcre -qt-harfbuzz -openssl-runtime ^
    -opengl dynamic -prefix %RELEASE_BUILD_DIR% -release ^
    -opensource -nomake examples -nomake tests
cmake --build . --target docs
cmake --build . --target install_docs

CD %BUILD_START_DIR%
RENAME qt_release_mingw64 qt_release_mingw64_with_docs
tar -czf qt_release_mingw64_with_docs.tar.gz qt_release_mingw64_with_docs
