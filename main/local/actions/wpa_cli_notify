#!/bin/sh

set -u
set -e
umask 0750
export PATH="/bin:/usr/bin"
export LANG="C"
IFS="	 
"

APPNAME=wpa_supplicant

case "$2" in
  CONNECTED)
    notify-send \
      --app-name ${APPNAME} \
      "Wifi Connected" \
      "connected to `wpa_cli get_network ${WPA_ID} ssid | tail -n 1` successfully."
    ;;
  DISCONNECTED)
    notify-send \
      --app-name ${APPNAME} \
      "Wifi Disconnected"
    ;;
esac
