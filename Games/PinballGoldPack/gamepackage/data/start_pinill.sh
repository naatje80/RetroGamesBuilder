#! /bin/sh

cd `dirname ${0}`

DOSBOXCONFFILE="dosbox-staging_pinill.conf"

./bin/dosbox --nolocalconf --conf ${DOSBOXCONFFILE} --fullscreen
