#! /bin/bash
set -e

SDL2VERSION=2.30.0
GAMESCOPEVERSION=3.14.2
WINEVERSION=9.0

# Static build not possible, including required dynamic libraries instead
include_libraries=(
 'libmpg123.so.0'
)

# Prepare buildenv directory which will hold the downloaded sources
if [[ ! -d /buildenv ]]; then mkdir /buildenv; fi
cd /buildenv

# Cleanup dist
rm -rf /dist/*

# Add multilib support
cat << EOF >> /etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

pacman -Syu --noconfirm meson cmake vulkan-headers wayland-protocols libxcomposite libxcursor libxtst libxres libxmu libxkbcommon pixman seatd libinput xorg-xwayland xcb-util-wm glslang

# First required to install sub-depencies to build SDL
pacman -Suy --noconfirm libpipewire libpulse libglvnd
git clone --depth=1 --branch release-${SDL2VERSION} https://github.com/libsdl-org/SDL.git
cd SDL
./autogen.sh && ./configure --prefix=/usr/local --disable-shared --enable-static 
make -j $(nproc) install

cd /buildenv

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

git clone --recurse-submodules --branch ${GAMESCOPEVERSION} --depth=1 https://github.com/ValveSoftware/gamescope
cd gamescope
meson setup --default-library static --prefer-static static-build
meson compile -C static-build
if [[ ! -d /dist/bin ]]; then mkdir /dist/bin; fi
cp static-build/src/gamescope /dist/bin
cd /buildenv



pacman -Syu --noconfirm lib32-gcc-libs lib32-libx11 lib32-freetype2 lib32-libxcursor lib32-libxi lib32-libusb lib32-libxrandr lib32-libpulse \
	lib32-gst-plugins-base lib32-gst-plugins-base-libs lib32-gst-plugins-good lib32-gstreamer lib32-libxinerama lib32-libxcomposite lib32-wayland \
	lib32-libxkbcommon lib32-sdl2 mingw-w64-gcc

if [[ ! -d wine ]]; then git clone --depth=1 --branch wine-${WINEVERSION} https://github.com/wine-mirror/wine.git; fi
cd wine
./configure --prefix=/
make -j $(nproc) 
make -j $(nproc) install DESTDIR=/dist
cd /buildenv

for library in ${include_libraries[@]}
do
   if [[ -e /usr/lib32/${library} ]]
   then
      cp /usr/lib32/${library} /dist/lib/wine/i386-unix
   else
	  echo "Warning: library ${library} unavailable. Most likely you will not have fully functional Wine environment"
   fi
done

cp -r /usr/lib32/gstreamer-1.0 /dist/lib/wine/i386-unix
