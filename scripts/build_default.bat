SET srcs=%*

FOR %%i in (%srcs%) do ( 
    echo Preparing: %%i
    CD %FULL_SOURCE_DIRECTORY%\%%i
    MKDIR out && CD out
    call qt-configure-module.bat ..
    cmake --build . --parallel
    cmake --install .
    CD %FULL_SOURCE_DIRECTORY%
    RMDIR /S /Q %%i\out
)