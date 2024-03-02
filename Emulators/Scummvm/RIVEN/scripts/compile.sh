#! /bin/bash
set -e

PNGVERSION=1.6.43
SDL2VERSION=2.30.0
ZLIBVERSION=1.3.1
SCUMMVMVERSION=2.8.0
VORBISVERSION=1.3.7
OGGVERSION=1.3.5
FREETYPEVERSION=2.13.2

# Prepare buildenv directory which will hold the downloaded sources
if [[ ! -d /buildenv ]]; then mkdir /buildenv; fi
cd /buildenv

# First required to install sub-depencies to build SDL
pacman -Suy --noconfirm libpipewire libpulse libglvnd wget

git clone --depth 1 https://github.com/markjeee/libmad.git
cd libmad
wget -q -O - https://www.linuxfromscratch.org/patches/blfs/svn/libmad-0.15.1b-fixes-1.patch | git apply -v
./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

git clone --depth 1 --branch v${PNGVERSION} https://github.com/pnggroup/libpng.git
cd libpng
./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch release-${SDL2VERSION} https://github.com/libsdl-org/SDL.git
cd SDL
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
cd /buildenv

pacman -Syu --noconfirm cmake
git clone --depth=1 --branch v${ZLIBVERSION} https://github.com/madler/zlib.git
cd zlib
./configure --prefix=/usr --static 
make -j $(nproc) install
cd /buildenv

git clone --depth=1 --branch v${OGGVERSION} https://github.com/xiph/ogg.git
cd ogg
./autogen.sh && ./configure --prefix=/usr --disable-shared --enable-static 
make -j $(nproc) install
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
# Force removal of unrequired but detected depencies
pacman -Rdd --noconfirm brotli bzip2
cd scummvm
mkdir build
cd build
../configure --enable-release \
	--enable-static \
	--disable-all-engines \
	--disable-mt32emu \
	--disable-lua \
	--disable-discord \
	--disable-cloud \
	--disable-flac \
	--disable-libcurl \
	--disable-alsa \
	--enable-engines=${ENGINE}
sed -i 's/-lSDL2/-l:libSDL2.a/' config.mk
sed -i 's/-ljpeg/-l:libjpeg.a/' config.mk
sed -i 's/-lz/-l:libz.a/' config.mk
sed -i 's/-logg/-l:libogg.a/' config.mk
sed -i 's/-lvorbisfile/-l:libvorbisfile.a/' config.mk
sed -i 's/-lvorbis/-l:libvorbis.a/' config.mk
make -j $(nproc) V=1
strip scummvm
cp scummvm /dist
cp -r ../gui/themes /dist
cp ../dists/engine-data/fonts.dat /dist
cd /buildenv
