#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

VIM_VARIENT=nvim
VIM_CONFDIR="${DESTDIR}/.config/nvim"

__fetch () {
	if command -v curl >/dev/null; then
		curl -o - -- "$1"
	elif command -v wget >/dev/null; then
		wget -O - -- "$1"
	else
		printf 'curl, wget not found.' 1>&2
		return 1
	fi
}

__vim_install () {
	(
	[ ! "$(command -v ${VIM_VARIENT})" -o ! "$(command -v git)" ] \
		&& printf 'vim or git not found. aborting vim initialize.\n' \
		&& return 1

	vimplug_dest="${VIM_CONFDIR}/autoload/plug.vim"
	vimplug_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	# check if vim is already initialized
	[ -f "${vimplug_dest}" ] && return 0

	mkdir -p -- "$(dirname "${vimplug_dest}")"

	__fetch "${vimplug_url}" > "${vimplug_dest}"

	${VIM_VARIENT} +PlugInstall +qall
	)
}

__vim_uninstall () {
	rm -rf -- "${VIM_CONFDIR}"
}

module_install () {
	(
	if ! __vim_install; then
		printf '\nnvim initialization failed.\n'
	fi
	)
}

module_uninstall () {
	__vim_uninstall
}

