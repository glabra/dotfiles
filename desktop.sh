#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

FZF_DIR="${HOME}/.fzf"

__symlink_bins () {
	(
	cd ${DESTDIR}/.local/bin/

	if [ -e gimp -a ! -e gimp-2.8 ]; then
		ln -s gimp gimp-2.8
	fi
	)
}

__unsymlink_bins () {
	(
	cd ${DESTDIR}/.local/bin/

	rm -f gimp-2.8
	)
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
	rm -f "${HOME}/.fzf.bash" "${HOME}/.fzf.zsh"
}

module_install () {
	(
	errs=''
	__symlink_bins || errs="bin_symlink"
	__fzf_install || errs="${errs} fzf"

	if [ -n "${errs}" ]; then
		printf '\n> error: %s\n'  "${errs}"
	fi
	)
}

module_uninstall () {
	__unsymlink_bins
	__fzf_uninstall
}

