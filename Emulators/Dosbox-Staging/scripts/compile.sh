#! /bin/bash
set -e

OGGVERSION=1.3.5
OPUSVERSION=1.4
OPUSFILEVERSION=0.12
SDL2VERSION=2.30.0
SDL2NETVERSION=2.2.0
LIBPNGVERSION=1.6.42
ZLIBNGVERSION=2.1.6
ALSALIBVERSION=1.2.11
LIBGLVNDVERSION=1.2.0
DOSBOXSTAGINGVERSION=0.81.0

# Prepare buildenv directory which will hold the downloaded sources
if [[ ! -d /buildenv ]]; then mkdir /buildenv; fi
cd /buildenv

# First required to install sub-depencies. Some dependies will be overwritten below by statically compiled version
pacman -Suy --noconfirm libpipewire libpulse libglvnd

git clone --depth=1 --branch v${OGGVERSION} https://github.com/xiph/ogg.git
cd ogg
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static && make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${OPUSVERSION} https://github.com/xiph/opus.git
cd opus
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static && make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${OPUSFILEVERSION} https://github.com/xiph/opusfile.git
cd opusfile
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static && make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${ALSALIBVERSION} https://github.com/alsa-project/alsa-lib.git
cd alsa-lib
autoreconf -fi
./configure --prefix=/usr --disable-shared --enable-static && make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch release-${SDL2VERSION} https://github.com/libsdl-org/SDL.git
cd SDL
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch release-${SDL2NETVERSION} https://github.com/libsdl-org/SDL_net.git
cd SDL_net
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static && make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${LIBPNGVERSION} https://github.com/pnggroup/libpng
cd libpng
./configure --prefix=/usr --disable-shared --enable-statuc && make -j $(nproc) install
make install
cd  -

pacman -Syu --noconfirm cmake
git clone --depth=1 --branch ${ZLIBNGVERSION} https://github.com/zlib-ng/zlib-ng.git
cd zlib-ng
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=OFF
make -C build -j $(nproc) install
cd /buildenv

pacman -Syu --noconfirm meson
git clone --depth=1 --branch v${DOSBOXSTAGINGVERSION} https://github.com/dosbox-staging/dosbox-staging.git
cd dosbox-staging
meson setup --prefix /usr --prefer-static --default-lib=static build
meson compile -C build
cp -rpv build/dosbox build/resources/ /dist
cd /buildenv
