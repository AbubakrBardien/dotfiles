#!/usr/bin/env bash

# Store the full paths of the gtk folders
gtkVersionsFolderPaths=("${XDG_CONFIG_HOME:-$HOME/.config}"/gtk*)

# Create a new array to store just the folder names
gtkVersionsFolderNames=()

# Loop through the full paths and strip the parent directory
for path in "${gtkVersionsFolderPaths[@]}"; do
	gtkVersionsFolderNames+=("${path##*/}")
done

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
