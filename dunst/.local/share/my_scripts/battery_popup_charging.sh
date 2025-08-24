#!/bin/bash

# Send a notification displaying that the battery is charging or discharging
# Pass 1 as an argument for charging, 0 for discharging

# Check if argument is passed
[ $# != 1 ] && printf '0 or 1 must be passed as an argument.\nUsage: %s 0|1\n' "$0" && exit

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

battery_charging=$1
notification_timeout=2000 # 2 seconds

# Send notifications
if [ "$battery_charging" -eq 1 ]; then
	dunstify -a "battery_popup" -i "$HOME/.config/dunst/icons/battery_charging.png" "Charging" -t $notification_timeout
elif [ "$battery_charging" -eq 0 ]; then
	dunstify -a "battery_popup" -i "$HOME/.config/dunst/icons/battery_discharging.png" "Switched to battery power" -t $notification_timeout
fi
