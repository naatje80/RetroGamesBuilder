#! /bin/sh

cd `dirname ${0}`
./bin/scummvm --themepath=./bin/themes --extrapath=./bin --music-driver=mt32 --fullscreen --subtitles --path=./gamedata --auto-detect 
