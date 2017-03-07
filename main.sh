#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

VIM_VARIENT='nvim'

if [ "${VIM_VARIENT}" = 'nvim' ]; then
	VIM_CONFDIR="${DESTINATION}/.config/nvim"
else
	VIM_CONFDIR="${DESTINATION}/.vim"
fi

__vim_install () {
	if ! which ${VIM_VARIENT} git openssl 2>&1 >/dev/null; then
		printf 'vim, git or openssl not found. aborting vim initialize.\n'
		return 1
	fi

	local vimplug_dest="${VIM_CONFDIR}/autoload/plug.vim"
	local vimplug_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	# check if vim is already initialized
	[ -f "${vimplug_dest}" ] && return 0

	mkdir -p -- "$(dirname "${vimplug_dest}")"

	if which curl 2>&1 >/dev/null; then
		curl -o "${vimplug_dest}" -- "${vimplug_url}"
	elif which wget 2>&1 >/dev/null; then
		wget -O "${vimplug_dest}" -- "${vimplug_url}"
	else
		printf 'wget or curl not found. aborting.\n'
		return 1
	fi

	if [ "${VIM_VARIENT}" = 'nvim' ]; then
		${VIM_VARIENT} +PlugInstall +UpdateRemotePlugins +qall
	else
		${VIM_VARIENT} +PlugInstall +qall
	fi

	${VIM_VARIENT} +PlugInstall +qall
}

__vim_uninstall () {
	rm -rf -- "${VIM_CONFDIR}"
}

SOURCE_LINE='. "${HOME}/.profile"'
__shellrc_install () {
	if [ -f "${HOME}/.zshrc" ]; then
		fgrep -q "${SOURCE_LINE}" "${HOME}/.zshrc" || \
			printf '%s\n' "${SOURCE_LINE}" >> "${HOME}/.zshrc"
	elif [ -f "${HOME}/.bashrc" ]; then
		fgrep -q "${SOURCE_LINE}" "${HOME}/.bashrc" || \
			printf '%s\n' "${SOURCE_LINE}" >> "${HOME}/.bashrc"
	fi
}

__shellrc_warn () {
	[ -f "${HOME}/.zshrc" ] && \
		fgrep -q "${SOURCE_LINE}" "${HOME}/.zshrc" && \
		printf 'Please remove source procedure from .zshrc.'
	[ -f "${HOME}/.bashrc" ] && \
		fgrep -q "${SOURCE_LINE}" "${HOME}/.bashrc" && \
		printf 'Please remove source procedure from .bashrc.'
}

module_install () {
	__vim_install
	__shellrc_install
}

module_uninstall () {
	__vim_uninstall
	__shellrc_warn
}

