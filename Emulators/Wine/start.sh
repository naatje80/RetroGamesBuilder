#! /bin/sh

#GAMEMODE=`which gamemoderun 2>/dev/null`
#CURRENT_DISPLAY=`xrandr|grep ' connected'|cut -d ' ' -f 4|cut -d+ -f1`

export PATH="${PWD}:${PATH}"
export LD_LIBRARY_PATH="/home/nathan/Development/RetroGamesBuilder/Emulators/Wine/dist/usr/local/lib/wine/i386-unix"
export GST_PLUGIN_PATH="/home/nathan/Development/RetroGamesBuilder/Emulators/Wine/dist/usr/local/lib/wine/i386-unix"
export GST_DEBUG=1

${GAMEMODE} strace -f -s 300 -o AAP.LOG ./wine c:\\GOG\ Games\\POD\ GOLD\\PODX3Dfx.exe
wineserver -k
#xrandr -s ${CURRENT_DISPLAY}
