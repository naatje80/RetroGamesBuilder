#! /bin/sh

cd `dirname ${0}`

GAMEMODE=`which gamemoderun 2>/dev/null`

export PATH="${PWD}/bin:${PATH}"
export LD_LIBRARY_PATH="${PWD}/lib/wine/i386-unix"
export GST_PLUGIN_PATH="${PWD}/lib/wine/i386-unix/gstreamer-1.0"

export WINEPREFIX=${PWD}/wineprefix

# Uncomment for installation
#./bin/winefile
${GAMEMODE} wine c:\\GOG\ Games\\Jazz\ Jackrabbit\ 2\\Jazz2.exe
wineserver -k
