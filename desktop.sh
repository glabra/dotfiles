#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

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

module_install () {
	(
	errs=''
	__symlink_bins || errs="bin_symlink"

	if [ -n "${errs}" ]; then
		printf '\n> error: %s\n'  "${errs}"
	fi
	)
}

module_uninstall () {
	__unsymlink_bins
}

