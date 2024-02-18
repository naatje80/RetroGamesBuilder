FROM archlinux:latest
RUN pacman -Suy --noconfirm base-devel git gtk2 gtk3 ncurses wget cmake xz zip
COPY package.sh /packagescripts/package.sh
RUN git clone --depth=1 https://github.com/icculus/mojosetup.git
CMD ["/packagescripts/package.sh"]