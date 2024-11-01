#!/bin/bash

options=("󰇄" "" "󰆟") 
display_str="󰇄\n\n󰆟" # Intended Order

# shellcheck disable=SC2059
chosen=$(printf "$display_str" | wofi -c "$HOME/.config/wofi/configs/screenshot/config" -s "$HOME/.config/wofi/configs/screenshot/style.css")

case $chosen in
	"${options[0]}")
		hyprshot -m output -o "$HOME/Pictures/Screenshots"
	;;
	"${options[1]}")
		hyprshot -m window -o "$HOME/Pictures/Screenshots" -z
	;;
	"${options[2]}")
		hyprshot -m region -o "$HOME/Pictures/Screenshots" -z
	;;
esac
