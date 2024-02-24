#! /bin/sh

cd `dirname ${0}`

./bin/scummvm -c ./bin/settings.ini --themepath=./bin/themes --iconspath=./bin/icons --extrapath=./bin
