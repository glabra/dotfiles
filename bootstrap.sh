#!/bin/sh
set -ue
umask 0027
export LANG='C'
IFS=' 	
'

: ${SRCDIR:=${HOME}/.dotfiles}
: ${DESTDIR:=${HOME}}
: ${SRCTYPE:=${SRCDIR}/.src_type}

# create_symlinks FROM TO
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

# remove_symlinks FROM TO ${REMOVE_ALL_SYMLINKS:-false}
remove_symlinks () {
	(
	for d in $(find $1 -type d); do
		case "$d" in
			"$1") path=$2;;
			*) path="$2/.${d#$1/}";;
		esac

		for l in $(find "$path" -maxdepth 1 -type l); do
			realFile=$(readlink "$l")
			case "$realFile" in
				$1*)
					[ "_${3:-}" = '_true' -o ! -e "$l" ] \
						&& rm -f "$l"
					;;
			esac
		done

		rmdir -p "$d" >/dev/null 2>&1 || true
	done

	return 0
	)
}

check_srctype () {
	find "${SRCDIR}" -maxdepth 1 -type d ! -name '_*' ! -name '.*' \
		| fgrep -q "${SRCDIR}/${1:-_invalid}" \
		|| return 1
}

get_srctype () {
	(
	[ -f "${SRCTYPE}" ] \
		&& read -r _type < "${SRCTYPE}"

	if check_srctype "${_type:-}"; then
		printf '%s' "${_type}"
	else
		printf ''
	fi
	)

}

dotfiles_install () {
	(
	check_srctype $1
	_previous=$(get_srctype)

	if [ "_${_previous:-$1}" != "_$1" ]; then
		printf -- '-> remove previously installed symlinks\n'
		dotfiles_uninstall
	fi

	printf -- '-> create symlinks\n'
	create_symlinks "${SRCDIR}/$1" "${DESTDIR}"
	for i in ${SRCDIR}/_*/; do
		create_symlinks "${i%/}" "${DESTDIR}"
	done

	printf -- '-> module install\n'
	if [ -f "${SRCDIR}/$1.sh" ]; then
		. "${SRCDIR}/$1.sh"
		module_install
	fi

	printf "%s\n" "$1" > "${SRCTYPE}"
	)
}

dotfiles_uninstall () {
	(
	_type=$(get_srctype)
	[ -z "${_type}" ] && return 1

	printf -- '-> module uninstall\n'
	if [ -f "${SRCDIR}/${_type}.sh" ]; then
		. "${SRCDIR}/${_type}.sh"
		module_uninstall
	fi

	printf -- '-> remove symlinks\n'
	remove_symlinks "${SRCDIR}/${_type}" "${DESTDIR}" true
	for i in ${SRCDIR}/_*/; do
		remove_symlinks "${i%/}" "${DESTDIR}" true
	done

	rm -f "${SRCTYPE}"
	)
}

dotfiles_sync () {
	(
	_type=$(get_srctype)
	[ -z "${_type}" ] && return 1

	printf -- '-> remove dangling symlinks\n'
	remove_symlinks "${SRCDIR}/${_type}" "${DESTDIR}"
	for i in ${SRCDIR}/_*/; do
		remove_symlinks "${i%/}" "${DESTDIR}"
	done

	printf -- '-> update current symlinks\n'
	dotfiles_install ${_type}
	)
}

case "${1:-}" in
	'install') dotfiles_install "${2}" ;;
	'uninstall') dotfiles_uninstall;;
	'sync' | '') dotfiles_sync;;
	*) printf -- 'Usage: %s [(install [src_type]|uninstall|sync)]' "$0"
esac

