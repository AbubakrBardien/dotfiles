#!/bin/bash

# Send a notification if the laptop battery is either low or is fully charged.

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

warning_level=20
battery_charging=$(acpi -b | grep "Battery 0" | grep -c "Charging")
battery_level=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')
notification_timeout=2000 # 2 seconds

# Use two files to store whether we've shown a notification or not (to prevent multiple notifications)
EMPTY_FILE=/tmp/batteryempty
FULL_FILE=/tmp/batteryfull

# Reset notifications if the computer is charging/discharging
if [ "$battery_charging" -eq 0 ] && [ -f $FULL_FILE ]; then
	rm $FULL_FILE
elif [ "$battery_charging" -eq 1 ] && [ -f $EMPTY_FILE ]; then
	rm $EMPTY_FILE
fi

# If the battery is charging and is full (and has not shown notification yet)
if [ "$battery_level" -eq 100 ] && [ "$battery_charging" -eq 1 ] && [ ! -f $FULL_FILE ]; then
	dunstify -a "battery_popup" -i "$HOME/.config/dunst/icons/battery_full.png" "Battery Full" -t $notification_timeout
	touch $FULL_FILE

# If the battery is low and is not charging (and has not shown notification yet)
elif [ "$battery_level" -le $warning_level ] && [ "$battery_charging" -eq 0 ] && [ ! -f $EMPTY_FILE ]; then
	dunstify -a "battery_popup" -u critical "Battery  Low  ($battery_level%)" -i "$HOME/.config/dunst/icons/battery_low.png"
	touch $EMPTY_FILE
fi
