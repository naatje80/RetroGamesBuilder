#! /bin/sh

cd `dirname ${0}`

if [[ -n `which gsettings` ]]
then
	BACKUPSETTINGS_SW_RIGHT=`gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-right`
	BACKUPSETTINGS_SW_LEFT=`gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-left`
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
fi
./bin/dosbox -fullscreen -nolowcalconf -conf dosbox-staging_tombraider.conf
if [[ -n ${BACKUPSETTINGS_SW_RIGHT} ]]
then
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "${BACKUPSETTINGS_SW_RIGHT}"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "${BACKUPSETTINGS_SW_LEFT}"
fi
