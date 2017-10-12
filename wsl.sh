#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

__bloatware_warn () {
	if dpkg -s bash-completion 2>/dev/null; then
		printf 'bash-completion is installed. This slow downs your shell.\n'
	fi

	if dpkg -s command-not-found 2>/dev/null; then
		printf 'command-not-found is installed. This shows bloated message.\n'
	fi
}

module_install () {
	__bloatware_warn
}

module_uninstall () {
	:
}

