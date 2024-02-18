#! /bin/sh

cd `dirname ${0}`

DOSBOXCONFFILE="dosbox-staging_pindrms.conf"

./bin/dosbox --nolocalconf --conf ${DOSBOXCONFFILE} --fullscreen
