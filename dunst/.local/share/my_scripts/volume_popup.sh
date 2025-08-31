#!/usr/bin/env bash

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')

notification_timeout=1500 # 1.5 sec

function popup() {
	volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')

	# "-i" is to set the icon, and "-t" is to se the timeout (in milliseconds)
	dunstify -a "volume_popup" -u low -h "int:value:$volume" -h string:x-dunst-stack-tag:vol_tag -i "$HOME/.config/dunst/icons/$1" "Volume: $volume%" -t $notification_timeout
}

case $1 in
up)
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # unmute if muted
	if [ "$volume" -lt 100 ]; then
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
	fi
	popup "volume_$1.png"
	;;
down)
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # unmute if muted
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
	popup "volume_$1.png"
	;;
mute)
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	isMuted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

	if [[ $2 != "waybar" ]]; then        # When clicking on the waybar volume module, don't notify
		if [[ $isMuted = "[MUTED]" ]]; then # If Muted
			dunstify -a "volume_popup" -u low -h string:x-dunst-stack-tag:vol_tag -i "$HOME/.config/dunst/icons/mute.png" "Muted" -t $notification_timeout
		else
			dunstify -a "volume_popup" -u low -h string:x-dunst-stack-tag:vol_tag -i "$HOME/.config/dunst/icons/volume.png" "Volume: $volume%" -t $notification_timeout
		fi
	fi
	;;
esac
