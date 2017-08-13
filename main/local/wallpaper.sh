#!/bin/sh
set -ue
umask 0027
export PATH='/bin:/usr/bin'
export LANG='C'
IFS=' 	
'

WALLPAPERS="${HOME}/.local/wallpapers"

if [ -f "${1:-}" ]; then
	WALLPAPER=${1}
else
	set_if_exists () {
		if [ -r "$2" ]; then
			eval $1=$2
			return 0
		else
			return 1
		fi
	}

	set_if_exists WALLPAPER "${HOME}/.local/wallpaper.jpg" \
		|| set_if_exists WALLPAPER "${HOME}/.local/wallpaper.png" \
		|| WALLPAPER="$WALLPAPERS/$(ls -1 $WALLPAPERS | shuf -n1)"
fi

if [ "$(command -v feh)" -a -f "${WALLPAPER}" ]; then
	if printf '%s' ${WALLPAPER} | fgrep -q '.tiled.'; then
		feh --no-fehbg --bg-tile "${WALLPAPER}"
	else
		feh --no-fehbg --bg-fill "${WALLPAPER}"
	fi
fi

