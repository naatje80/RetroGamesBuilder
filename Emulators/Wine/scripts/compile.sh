#! /bin/bash
set -e

WINEVERSION=9.0

# Static build not possible, including required dynamic libraries instead
include_libraries=(
 'libgstvideo-1.0.so.0'
 'libgstaudio-1.0.so.0'
 'libgstbase-1.0.so.0'
 'libgsttag-1.0.so.0'
 'libgstreamer-1.0.so.0'
 'libgstpbutils-1.0.so.0'
 'libgstaudioparsers.so'
 'libgstmpg123.so'
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

pacman -Syu --noconfirm lib32-gcc-libs lib32-libx11 lib32-freetype2 lib32-libxcursor lib32-libxi lib32-libusb lib32-libxrandr lib32-libpulse \
	lib32-gst-plugins-base lib32-gst-plugins-base-libs lib32-gst-plugins-good lib32-gstreamer lib32-libxinerama lib32-libxcomposite lib32-wayland \
	lib32-libxkbcommon lib32-sdl2 mingw-w64-gcc

if [[ ! -d wine ]]; then git clone --depth=1 --branch wine-${WINEVERSION} https://github.com/wine-mirror/wine.git; fi
cd wine
./configure --prefix=/
make -j $(nproc) install DESTDIR=/dist
cd /buildenv

for library in ${include_libraries[@]}
do
   if [[ -e /usr/lib32/${library} ]]
   then
      cp /usr/lib32/${library} /dist/lib/wine/i386-unix
   elif [[ -e /usr/lib32/gstreamer-1.0/${library} ]]
   then
      cp /usr/lib32/gstreamer-1.0/${library} /dist/lib/wine/i386-unix
   else
	  echo "Warning: library ${library} unavailable. Most likely you will not have fully functional Wine environment"
   fi
done
