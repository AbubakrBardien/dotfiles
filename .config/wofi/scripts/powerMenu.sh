#!/bin/bash

# options=("󰐥 Shut Down" "󰒲  Sleep" "󰜉 Reboot" "󰌾 Lock Screen" "󰍃 Log Out" "  Hibernate")
options=("󰐥 Shut Down" "󰒲  Sleep" "󰜉 Reboot" "󰌾 Lock Screen" "  Hibernate")

# chosen=$(printf "󰐥 Shut Down\n󰒲  Sleep\n󰜉 Reboot\n󰌾 Lock Screen\n󰍃 Log Out\n  Hibernate" | wofi -c "$HOME/.config/wofi/configs/power_menu/config" -s "$HOME/.config/wofi/configs/power_menu/style.css")
chosen=$(printf "󰐥 Shut Down\n󰒲  Sleep\n󰜉 Reboot\n󰌾 Lock Screen\n  Hibernate" | wofi -c "$HOME/.config/wofi/configs/power_menu/config" -s "$HOME/.config/wofi/configs/power_menu/style.css")

case $chosen in
"${options[0]}")
	shutdown now
	;;
"${options[1]}")
	systemctl hybrid-sleep
	;;
"${options[2]}")
	reboot
	;;
"${options[3]}")
	hyprlock # Not configured yet
	;;
# "${options[4]}")
# 	hyprctl dispatch exit
# 	;;
"${options[4]}")
	systemctl hibernate
	;;
esac
