#!/bin/sh

tput sgr0

# delete dirty files
printf '%s' "
${HOME}/.ash_history
${HOME}/.bash_history
${HOME}/.wpa_cli_history
${HOME}/.viminfo.tmp
${HOME}/.lesshst
${HOME}/.thumbnails/
" | xargs rm -rf
