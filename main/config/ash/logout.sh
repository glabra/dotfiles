tput sgr0

# delete dirty files
printf '%s' "
${HOME}/.bash_history
${HOME}/.wpa_cli_history
" | xargs rm
