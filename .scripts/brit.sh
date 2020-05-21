#!/bin/sh

if [ -z "$1" ]; then
	exit
fi

if [ "$1" = "inc" ]; then
	light -A 10 && notify-send -i info "Brightness: "$(light -G)""
elif [ "$1" = "dec" ]; then
	light -U 10 && notify-send -i info "Brightness: "$(light -G)""
fi
