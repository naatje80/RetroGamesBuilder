Requirements:
    - meson
    - opusfile
    - sdl2
    - sdl2_net
    - libpng
    - alsa-lib
    - zlib-ng (disabled for now --> No static lib included)

Compile:
    meson build --prefix=/usr --default-library static --reconfigure
    ninja -C build

Distribute:
    build/dosbox
    build/resources