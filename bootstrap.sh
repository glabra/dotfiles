#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

ROOT="$(pwd)"
SRCTYPE_FILE="${ROOT}/.src_type"
DESTINATION="${HOME}"

die () {
	cat <<- _EOF_
	usage: $0 COMMAND

	The following commands are available:
	  install [src_type]:
	    install dotfiles into ~/
	  uninstall:
	    uninstall dotfiles from ~/
	  sync:
	    remove unresolvable symlinks
	  help:
	    show this text.

	Default command is [install].
	_EOF_
	exit $1
}

create_symlinks () {
	(
	srcdir=$1
	destdir=$2

	find "${srcdir}" -type d | \
		sed "s%^${srcdir}/%${destdir}/.%" | \
		xargs mkdir -p >/dev/null 2>&1

	files=$(find "${srcdir}" -type f)
	for file in ${files}; do
		dest="${destdir}/.${file#${srcdir}/}"
		[ ! -L "${dest}" ] && ln -s -- "${file}" "${dest}"
	done

	return 0
	)
}

remove_symlinks () {
	(
	srcdir=$1
	destdir=$2

	files=$(find "${srcdir}" -type f)
	for file in ${files}; do
		dest="${destdir}/.${file#${srcdir}/}"
		[ -L "${dest}" ] && rm -f "${dest}"
	done

	find "${srcdir}" -type d | \
		sed "s%^${srcdir}/%${destdir}/.%" | \
		xargs rmdir -p >/dev/null 2>&1

	return 0
	)
}

remove_dangling_symlinks () {
	(
	srcdir=$1
	destdir=$2

	files=$(find "${destdir}" -type l)
	for file in ${files}; do
		realfile=$(readlink "${file}") && \
			printf '%s' "${realfile}" | fgrep -q "${srcdir}" && \
			[ ! -e "${realfile}" ] && \
			rm -f -- "${file}"
	done

	find "${srcdir}" -type d | \
		sed "s%^${srcdir}/%${destdir}/.%" | \
		xargs rmdir -p >/dev/null 2>&1

	return 0
	)
}

get_srctype () {
	(
	[ -n "${1:-}" ] && \
		printf -- '%s' "${1}" > "${SRCTYPE_FILE}"

	[ -e "${SRCTYPE_FILE}" ] && \
		src_type=$(cat "${SRCTYPE_FILE}")

	[ -z "${src_type:-}" ] && \
		printf -- 'No src_type defined.\n' && \
		exit 1

	printf -- '%s' "${src_type}"

	return 0
	)
}

__install () {
	(
	src_type=$(get_srctype ${1:-})

	[ ! -d "${ROOT}/${src_type}" ] && \
		printf -- '`%s` not found.\n' "${src_type}" && \
		return 1

	printf -- '-> create symlinks\n'
	create_symlinks "${ROOT}/${src_type}" "${DESTINATION}"
	[ -d "${ROOT}/_common" ] && create_symlinks "${ROOT}/_common" "${DESTINATION}"

	printf -- '-> module install\n'
	[ -f "${ROOT}/${src_type}.sh" ] && \
		. "${ROOT}/${src_type}.sh" && \
		module_install

	return 0
	)
}

__uninstall () {
	(
	src_type=$(get_srctype ${1:-})

	[ ! -d "${ROOT}/${src_type}" ] && \
		printf -- '`%s` not found.\n' "${srcdir}" && \
		return 1

	printf -- '-> module uninstall\n'
	[ -f "${ROOT}/${src_type}.sh" ] && \
		. "${ROOT}/${src_type}.sh" && \
		module_uninstall

	printf -- '-> delete symlinks\n'
	remove_dangling_symlinks "${ROOT}/${src_type}" "${DESTINATION}"
	remove_symlinks "${ROOT}/${src_type}" "${DESTINATION}"
	[ -d "${ROOT}/_common" ] && remove_symlinks "${ROOT}/_common" "${DESTINATION}"

	return 0
	)
}

__sync () {
	(
	src_type=$(get_srctype ${1:-})
	srcdir="${ROOT}/${src_type}"
	[ ! -d "${srcdir}" ] && \
		printf -- '`%s` not found.\n' "${srcdir}" && \
		return 1

	remove_dangling_symlinks "${srcdir}" "${DESTINATION}"

	return 0
	)
}

case "${1:-}" in
	'install' | '') __install "${2:-}" ;;
	'uninstall') __uninstall ;;
	'sync') __sync ;;
	'help') die 0;;
	*) die 1;;
esac

