# Qt-mingw64
  A build of Qt using the Mingw64 toolchain (with some basic
  dependencies), on Windows.

## Goal
  This project was built for the sole purpose of facilitating 
  Qt-based development using Mingw and QMake/CMake/Meson,
  without the need of external tools (WSL, MSYS2, etc.).

### Targetted features
  - Working release mode build of Qt.
  - Use of qt based zlib, libjpeg, libpng, harfbuzz, freetype,
    pcre.
  - Runtime detection and usage of OpenSSL(v3) backend for TLS.
  - Support of FFmpeg backend for qtmultimedia.
  - Dynamic linking of OpenGL.
  - Availability of Qt documentation (secondary).

## How to download
  Download the artifacts from the latest [_successful_] CI 
  run. Extract the archive(s) to your desired folder. Adjust
  PATH to include the 'bin' directory in extracted folder, 
  and build system / IDE search directories to extracted 
  folder and start building your projects.

## Contributions
  If you have any doubts / queries / suggestion, feel free 
  to open an issue. Contributions / Pull Requests are always 
  welcome.

## Targets
### Short-term Targets
  - [x] Provide a basic working Qt distribution.
  - [x] Enable QDoc build (needs libclang from LLVM).
  - [x] Enable support for OpenSSL(v3) backend for TLS.
  - [x] Enable support for FFmpeg backend for qtmultimedia.
  - [ ] Enable documentation building.

### Long-term Targets
  - [ ] Extend the default build to include most (if not
        all) features of Qt for Mingw64 based development
        on Windows.
  - [ ] Clean the build process (CI).
    - [ ] Make each module available independently along
          with full Qt.
  - [ ] Clean the build process (build scripts).

### Impossible(?) Targets
  - [ ] Conquer the [_Qt development_] world [_on Windows_]

## Warranty
  All the files are provided on an "AS IS" BASIS, WITHOUT
  WARRANTIES OR CONDITIONS OF ANY KIND, either express or
  implied.

## FAQ
- Missing dependencies (.dll) files
  The build artifact only includes Qt libraries and tools,
  which can lead to missing file(s) issue (if not already
  installed). Binaries that were used during build, along
  with links to relevant sources is available at [releases/tag /dependencies](https://github.com/FetheredSerpent/qt-mingw64/releases/tag/dependencies).
  - libav* means dependencies on FFmpeg.
  - libclang.dll means dependencies on libclang / LLVM.
  - libgcc, libstdc++, libwinpthread  means dependencies
  on Mingw.
  - libssl, libcrypto means dependencies on OpenSSL.
