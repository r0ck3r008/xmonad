#!/bin/sh

if [ -z "$1" ]; then
	exit
fi

if [ "$1" = "inc" ]; then
	~/.xmonad/.scripts/pamixer/pamixer -i 5 && notify-send "Volume: $(~/.xmonad/.scripts/pamixer/pamixer --get-volume)" -t 250
elif [ "$1" = "dec" ]; then
	~/.xmonad/.scripts/pamixer/pamixer -d 5 && notify-send "Volume: $(~/.xmonad/.scripts/pamixer/pamixer --get-volume)" -t 250
elif [ "$1" = "mute" ]; then
	~/.xmonad/.scripts/pamixer/pamixer -t
	muted=$(pamixer/pamixer --get-mute)
	if [ "$muted" = "true" ]; then
		notify-send -i info "Muted" -t 250
	else
		notify-send -i info "Unmuted!" -t 250
	fi
fi
