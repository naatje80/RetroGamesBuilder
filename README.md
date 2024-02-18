# RetroGamesBuilder

The purpose of this software is to create Linux self extracing setups using Mojosetup (The same installer used by GOG Games), mostly for Retro Games from 80's,90's and 00's. These applications are either started using dosbox-staging, scummvm or wine.

I'm also using this project to document the best configuration options for either dosbox-staging, scummvm or wine to get the best support for each game.

GOG Games also supplies installers for some games, but these are often not using the best settings and are still setup using an outdated version of dosbox.

Dosbox-staging, Scummvm are mainly compiled with static libraries, to allow the installation to run on most recent Linux distributions. However, Wine is dificult to build statically. Hence, for wine based applications most shared libraries (both 32 and 64 bit) are supplied with the installation.

## Setup
Both the "emulators" as well as the packages are compiled and/or generated with Arch Linux based docker containers.
To compile the Emulators, fist naviate to the emulators directory: `cd ./Emulators/` and change to the required emulator (Wine, Scumm, or Dosbox-staging; To reduce the size of the Scummvm executable, a setup is available for each engine a currently require). From within this directory, execute: `docker-compose run -d squid-container` to load the squid-container (usefull during development, reduces amount of time software has to be re-downloaded) and start the compilation of the emulator with: `docker-compose run --build --rm buildenv`. When the container is shutdown, the compiled software should then be available within the directory: ../dist.

The Games directory contains the setups to generate the installers. When the squid-container is no longer running, fist also execute: `docker-compose run -d squid-container`. To generate the installer execute `docker-compose run --build --rm packageenv`

## Further information
More information will be available within the README.md files within the subdirectories. (E.g. Game specific information required to setup the correct installation)