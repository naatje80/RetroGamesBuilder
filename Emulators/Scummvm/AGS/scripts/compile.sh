#! /bin/bash
set -e

SDL2VERSION=2.30.0
ZLIBNGVERSION=2.1.6
SCUMMVMVERSION=2.8.0
VORBISVERSION=1.3.7
FREETYPEVERSION=2.13.2

# Prepare buildenv directory which will hold the downloaded sources
if [[ ! -d /buildenv ]]; then mkdir /buildenv; fi
cd /buildenv

# First required to install sub-depencies. Some dependies will be overwritten below by statically compiled version
pacman -Suy --noconfirm libpipewire libpulse libglvnd

git clone --depth=1 --branch release-${SDL2VERSION} https://github.com/libsdl-org/SDL.git
cd SDL
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

pacman -Syu --noconfirm cmake
git clone --depth=1 --branch ${ZLIBNGVERSION} https://github.com/zlib-ng/zlib-ng.git
cd zlib-ng
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=OFF
make -C build -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${VORBISVERSION} https://github.com/xiph/vorbis.git
cd vorbis
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch VER-`echo ${FREETYPEVERSION}|sed 's/\./-/g'` https://github.com/freetype/freetype.git
cd freetype
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${SCUMMVMVERSION} https://github.com/scummvm/scummvm.git
cd scummvm
mkdir build
cd build
../configure --enable-static \
	--disable-all-engines \
	--disable-mt32emu \
	--disable-lua \
	--enable-engines=${ENGINE}
sed -i 's/-lSDL2/-l:libSDL2.a/' config.mk
sed -i 's/-ljpeg/-l:libjpeg.a/' config.mk
sed -i 's/-lz/-l:libz.a/' config.mk
sed -i 's/-lvorbisfile/-l:libvorbisfile.a/' config.mk
sed -i 's/-lvorbis/-l:libvorbis.a/' config.mk
make -j $(nproc) V=1
strip scummvm
cp scummvm /dist
cp -r ../gui/themes /dist
cd /buildenv
