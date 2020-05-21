#!/bin/sh

if [ -z "$1" ]; then
	exit
fi

if [ "$1" = "inc" ]; then
	pamixer -i 5 && notify-send -i info "Volume: $(pamixer --get-volume)"
elif [ "$1" = "dec" ]; then
	pamixer -d 5 && notify-send -i info "Volume: $(pamixer --get-volume)"
elif [ "$1" = "mute" ]; then
	pamixer -t
	muted=$(pamixer --get-mute)
	if [ "$muted" = "true" ]; then
		notify-send -i info "Muted"
	else
		notify-send -i info "Unmuted!"
	fi
fi
