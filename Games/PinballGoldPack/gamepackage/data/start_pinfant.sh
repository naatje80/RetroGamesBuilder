#! /bin/sh

cd `dirname ${0}`

DOSBOXCONFFILE="dosbox-staging_pinfant.conf"

./bin/dosbox --nolocalconf --conf ${DOSBOXCONFFILE} --fullscreen
