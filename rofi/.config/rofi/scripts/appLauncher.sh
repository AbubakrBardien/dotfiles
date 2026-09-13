#!/usr/bin/env bash
#rofi -show combi -combi-modes "window,drun" -theme ~/.config/rofi/configs/app_launcher.rasi -terminal foot
rofi -show drun -theme "${XDG_CONFIG_HOME:-$HOME/.config}/rofi/configs/app_launcher.rasi" -terminal ghostty
