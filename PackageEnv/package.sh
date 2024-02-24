#! /bin/sh

READMEFILE="/gamepackage/data/README-linux.txt"
GAMEICONPATH="/gamepackage/data/gameicon.png"
GAMESPLASHIMAGE="/gamepackage/meta/splash.jpg"

# Remove spases from game name
export SHORT_GAMENAME=${GAMENAME// /}

MOJOBINARIERS="/mojosetup/build"

if [[ ! -e ${READMEFILE} ]]
then
    wget -q ${MOBYGAMESURL} -O - | \
        sed -n '/<div id="description-text" class="toggle-long-text">/,/<\/div>/p' | \
        sed 's/<[^>]*>//g'|sed 's/^[ ]*//g'|tr -d '\n' > ${READMEFILE}_tmp
    echo -e "\n\nSource: ${MOBYGAMESURL}" >> ${READMEFILE}_tmp
    # Reformat long lines
    fmt -s ${READMEFILE}_tmp > ${READMEFILE}
    rm -f ${READMEFILE}_tmp
fi

COUNTER=""
for ICONURL in ${ICONURLS}
do
    GAMEICON="${GAMEICONPATH%%.*}${COUNTER}.${GAMEICONPATH##*.}"
    if [[ ! -e "${GAMEICON}" ]]
    then
        wget -q ${ICONURL} -O "${GAMEICON}"
    fi
    COUNTER=${COUNTER:=1}
    COUNTER=$(( ${COUNTER} + 1 ))    
done

if [[ ! -d `dirname ${GAMESPLASHIMAGE}` ]]
then
    mkdir `dirname ${GAMESPLASHIMAGE}`
fi

if [[ ! -e ${GAMESPLASHIMAGE} ]]
then
    wget -q ${SPLASHURL} -O ${GAMESPLASHIMAGE}
fi


mkdir -p ${MOJOBINARIERS}
cd ${MOJOBINARIERS}
    
cmake .. -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DMOJOSETUP_ARCHIVE_TAR=ON \
    -DMOJOSETUP_ARCHIVE_TAR_XZ=ON \
    -DMOJOSETUP_ARCHIVE_TAR_BZ2=OFF \
    -DMOJOSETUP_ARCHIVE_TAR_GZ=OFF \
    -DMOJOSETUP_ARCHIVE_ZIP=ON \
    -DMOJOSETUP_URL_FTP=OFF \
    -DMOJOSETUP_URL_HTTP=OFF \
    -DMOJOSETUP_LUALIB_BIT=OFF \
    -DMOJOSETUP_LUALIB_CORE=OFF \
    -DMOJOSETUP_LUALIB_DB=OFF \
    -DMOJOSETUP_LUALIB_IO=ON \
    -DMOJOSETUP_LUALIB_MATH=OFF \
    -DMOJOSETUP_LUALIB_OS=OFF \
    -DMOJOSETUP_LUALIB_PACKAGE=OFF
make -j $(nproc)

# Prepare package
cd /gamepackage

# Prepare image
mkdir -p image/guis
mkdir -p image/scripts
mkdir -p image/data
mkdir -p image/meta/xdg-utils

strip ${MOJOBINARIERS}/mojosetup
mv ${MOJOBINARIERS}/mojosetup /dist/${SHORT_GAMENAME}-installer

for so_libary in ${MOJOBINARIERS}/*.so
do
    strip $so_libary
    mv $so_libary /gamepackage/image/guis
done

# Update total install
TOTALINSTALL=`du -sb data |perl -w -p -e 's/\A(\d+)\s+data\Z/$1/;'`
echo "TOTAL INSTALL: ${TOTALINSTALL}"
perl -w -pi -e "s/\A\s*(local TOTAL_INSTALL_SIZE)\s*\=\s*\d+\s*;\s*\Z/\$1 = $TOTALINSTALL;\n/;" scripts/config.lua
sed -i 's/GAMENAME = <SHORT_GAMENAME>/GAMENAME = \"'"${SHORT_GAMENAME}"'\"/' scripts/config.lua
sed -i 's/LONG_GAMENAME = <GAMENAME>/LONG_GAMENAME = \"'"${GAMENAME}"'\"/' scripts/config.lua
sed -i 's/GAME_DESCRIPTION = <GAME_DESCRIPTION>/GAME_DESCRIPTION = \"'"${GAME_DESCRIPTION}"'\"/' scripts/config.lua
sed -i 's/VENDOR_NAME = <VENDOR_NAME>/VENDOR_NAME = \"'"${VENDOR_NAME}"'\"/' scripts/config.lua

# Compile the Lua scripts, put them in the base archive.
for lua_script in ${MOJOBINARIERS}/../scripts/*.lua
do
    ${MOJOBINARIERS}/mojoluac -s -o  image/scripts/`basename ${lua_script}`c ${lua_script}
done

# Overwrite general config script
${MOJOBINARIERS}/mojoluac -s -o image/scripts/config.luac scripts/config.lua

# Don't want the example app_localization...use ours instead if it exists.
if [[ -e script/app_localization.luac ]]; then ${MOJOBINARIERS}/mojoluac -s -o  image/scripts/app_localization.luac script/app_localization.lua; fi

cp ${MOJOBINARIERS}/../meta/xdg-utils/* image/meta/xdg-utils
chmod +x image/meta/xdg-utils/*

# Copy the gamedata and remaining required files
rm -f data/README.md
cp -R data/* image/data/
cp meta/* image/meta/

# Make sure to execute from within 
cd image/
#tar -c -I 'xz -9 -T3' -f ../data.tar.xz *
#${MOJOBINARIERS}/make_self_extracting /gamepackage/${GAMENAME}-installer /gamepackage/data.tar.xz
zip -9ry ../pdata.zip *

echo "${MOJOBINARIERS}/make_self_extracting /dist/${SHORT_GAMENAME}-installer /gamepackage/pdata.zip"
${MOJOBINARIERS}/make_self_extracting /dist/${SHORT_GAMENAME}-installer /gamepackage/pdata.zip

cd -

cd /
rm -rf /gamepackage/image
rm -f /gamepackage/pdata.zip
