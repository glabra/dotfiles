#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

SOURCE_LINE='. "${HOME}/.profile"'
__shellrc_install () {
	if [ -f "${HOME}/.zshrc" ]; then
		fgrep -q "${SOURCE_LINE}" "${HOME}/.zshrc" \
			|| printf '%s\n' "${SOURCE_LINE}" >> "${HOME}/.zshrc"
	elif [ -f "${HOME}/.bashrc" ]; then
		fgrep -q "${SOURCE_LINE}" "${HOME}/.bashrc" \
			|| printf '%s\n' "${SOURCE_LINE}" >> "${HOME}/.bashrc"
	fi
}

__shellrc_warn () {
	if [ -f "${HOME}/.zshrc" ]; then
		fgrep -q "${SOURCE_LINE}" "${HOME}/.zshrc" \
			&& printf '! remove `%s` from .zshrc manually.\n' "${SOURCE_LINE}"
	elif [ -f "${HOME}/.bashrc" ]; then
		fgrep -q "${SOURCE_LINE}" "${HOME}/.bashrc" \
			&& printf '! remove `%s` from .bashrc manually.\n' "${SOURCE_LINE}"
	fi
}

module_install () {
	__shellrc_install
}

module_uninstall () {
	__shellrc_warn
}

