#! /bin/sh

cd `dirname ${0}`

GAMEMODE=`which gamemoderun 2>/dev/null`

export PATH="${PWD}/bin:${PATH}"
export LD_LIBRARY_PATH="${PWD}/lib/wine/i386-unix"
export GST_PLUGIN_PATH="${PWD}/lib/wine/i386-unix/gstreamer-1.0"

export WINEPREFIX=${PWD}/wineprefix

# Uncomment for installation
#./bin/winefile
gamemoderun gamescope -W 800 -H 600 -f wine c:\\GOG\ Games\\POD\ GOLD\\PODX3Dfx.exe
wineserver -k
