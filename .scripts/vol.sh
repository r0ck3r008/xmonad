#!/bin/sh

if [ -z "$1" ]; then
	exit
fi

if [ "$1" = "inc" ]; then
	pamixer -i 5 && notify-send "Volume: $(pamixer --get-volume)" -t 250
elif [ "$1" = "dec" ]; then
	pamixer -d 5 && notify-send "Volume: $(pamixer --get-volume)" -t 250
elif [ "$1" = "mute" ]; then
	pamixer -t
	muted=$(pamixer --get-mute)
	if [ "$muted" = "true" ]; then
		notify-send -i info "Muted" -t 250
	else
		notify-send -i info "Unmuted!" -t 250
	fi
fi
