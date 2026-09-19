#!/usr/bin/env bash

# Helper to fetch active gsettings key cleanly
get_gsetting() {
	gsettings get org.gnome.desktop.interface "$1" 2>/dev/null | tr -d "'"
}

case "$1" in
0)
	gtk_theme=$(get_gsetting gtk-theme)
	outputStr="${gtk_theme:-Unknown}"
	;;
1)
	gtk_icon=$(get_gsetting icon-theme)
	outputStr="${gtk_icon:-Unknown}"
	;;
2)
	gtk_font=$(get_gsetting font-name)
	outputStr="${gtk_font:-Unknown}"
	;;
*)
	echo "Usage: $0 {0|1|2}"
	exit 1
	;;
esac

echo "$outputStr"
