#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

FZF_DIR="${HOME}/.fzf"
VIM_VARIENT='nvim'

if [ "${VIM_VARIENT}" = 'nvim' ]; then
	VIM_CONFDIR="${DESTDIR}/.config/nvim"
else
	VIM_CONFDIR="${DESTDIR}/.vim"
fi

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

__fzf_install () {
	[ ! "$(command -v git)" ] \
		&& printf 'git not found. aborting fzf initialize.\n' \
		&& return 1

	[ -d "${FZF_DIR}" ] && return 0

	git clone --depth 1 https://github.com/junegunn/fzf.git "${FZF_DIR}"
	"${FZF_DIR}/install" --key-bindings --completion --no-update-rc --64
}

__fzf_uninstall () {
	rm -rf "${FZF_DIR}"
}

module_install () {
	(
	errs=''
	__shellrc_install || errs="${errs} shellrc"
	__vim_install || errs="${errs} vimrc"
	__fzf_install || errs="${errs} fzf"

	if [ -n "${errs}" ]; then
		printf '\n> error: %s\n'  "${errs}"
	fi
	)
}

module_uninstall () {
	__vim_uninstall
	__shellrc_warn
	__fzf_uninstall
}

