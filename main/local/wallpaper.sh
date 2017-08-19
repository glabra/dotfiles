#!/bin/sh
set -ue
umask 0027
export PATH='/bin:/usr/bin'
export LANG='C'
IFS=' 	
'

WALLPAPERS="${HOME}/.local/wallpapers"
SCREEN_SIZE=1920x1080

[ ! "$(command -v feh)" -o ! "$(command -v convert)" ] \
	&& exit 2

if [ -z "${1:-}" ]; then
	defaultpaper=$(ls -1 $WALLPAPERS | fgrep '!default' || true)
	if [ -n "$defaultpaper" ]; then
		wallpaper=$WALLPAPERS/$defaultpaper
	else
		wallpaper=$WALLPAPERS/$(ls -1 $WALLPAPERS | shuf -n1)
	fi
else
	wallpaper=${1:-}
fi

[ ! -e "${wallpaper}" ] \
	&& exit 1

case "${wallpaper}" in
	*.tiled.*)
		feh --no-fehbg --bg-tile "${wallpaper}"
		;;
	*.center.*)
		color=$(printf '%s' "${wallpaper}" | egrep -o '[0-9a-f]+\.(jpg|png)$' | cut -d. -f1)
		convert "${wallpaper}" \
			-gravity center \
			-background "#${color}" \
			-extent ${SCREEN_SIZE} - \
			| feh --no-fehbg --bg-fill -
		;;
	*)
		feh --no-fehbg --bg-fill "${wallpaper}"
		;;
esac

