#!/usr/bin/env bash

# shellcheck disable=SC2164
cd "${XDG_CONFIG_HOME:-$HOME/.config}"

# Store the names of the gtk folders in an array
gtkVersionsFolderNames=(gtk*)

# Decide on what info to display
case "$1" in
0)
	gtk_theme=$(grep -Po '^gtk-theme-name="?\K(.+?)(?= \d+$|$)' "${XDG_CONFIG_HOME:-$HOME/.config}/${gtkVersionsFolderNames[0]}/settings.ini" 2>/dev/null)
	qt_theme=$(grep -Po '^theme=\K.+(?=#$)' "${XDG_CONFIG_HOME:-$HOME/.config}/Kvantum/kvantum.kvconfig")
	if [ -n "$qt_theme" ]; then
		ouputStr="${gtk_theme} [GTK], ${qt_theme} [Qt]"
	else
		ouputStr="${gtk_theme} [GTK]"
	fi
	;;
1)
	gtk_icon=$(grep -Po '^gtk-icon-theme-name="?\K(.+?)(?= \d+$|$)' "${XDG_CONFIG_HOME:-$HOME/.config}/${gtkVersionsFolderNames[0]}/settings.ini" 2>/dev/null)
	ouputStr="${gtk_icon} [GTK]"
	;;
2)
	gtk_font=$(grep -Po '^gtk-font-name="?\K(.+?)(?= \d+$|$)' "${XDG_CONFIG_HOME:-$HOME/.config}/${gtkVersionsFolderNames[0]}/settings.ini" 2>/dev/null)
	ouputStr="${gtk_font} [GTK]"
	;;
esac

echo "$ouputStr"
