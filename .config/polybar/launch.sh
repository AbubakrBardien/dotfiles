#!/bin/bash

#Kill already running polybars
killall -q polybar

# Wait until processes are shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#Lauch bar
polybar status_bar &
#polybar left &
#polybar center &
#polybar right &
