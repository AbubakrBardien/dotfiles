#!/usr/bin/env bash

emoji_list=$(cat "${XDG_CONFIG_HOME:-$HOME/.config}/wofi/configs/emoji_menu/emojis.txt")

chosen=$(printf '%s' "$emoji_list" | wofi -c "${XDG_CONFIG_HOME:-$HOME/.config}/wofi/configs/emoji_menu/config" -s "${XDG_CONFIG_HOME:-$HOME/.config}/wofi/configs/emoji_menu/style.css")

wl-copy "${chosen:0:1}" # copy on the chosen emoji to clipboard (not description)
