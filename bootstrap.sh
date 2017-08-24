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

		[ ! -d "$path" ] && continue

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
	find "${SRCDIR}" -maxdepth 1 -type d ! -name '.*' | \
		fgrep -q "${SRCDIR}/$1"
}

__update () {
	(
	check_srctype "$t" || return
	printf -- '-> create symlinks\n'
	create_symlinks "${SRCDIR}/$1" "${DESTDIR}"

	if [ -f "${SRCDIR}/$1.sh" ]; then
		printf -- '-> module install\n'
		. "${SRCDIR}/$1.sh"
		module_install
	fi
	)
}

__purge () {
	(
	check_srctype "$t" || return

	if [ -f "${SRCDIR}/$1.sh" ]; then
		printf -- '-> module uninstall\n'
		. "${SRCDIR}/$1.sh"
		module_uninstall
	fi

	printf -- '-> remove symlinks\n'
	remove_symlinks "${SRCDIR}/$1" "${DESTDIR}" true
	)
}

dotfiles_install () {
	if [ -f "${SRCTYPE}" ]; then
		printf '! dotfiles are already installed.\n'
		return
	fi

	for t in $@; do
		printf -- 'type: %s\n' "$t"
		__update $t
	done

	printf '%s\n' "$*" > "${SRCTYPE}"
}

dotfiles_uninstall () {
	[ -f "${SRCTYPE}" ] \
		&& read -r _type < "${SRCTYPE}"
	[ -z "${_type:-}" ] && return 1

	for t in ${_type}; do
		printf -- 'type: %s\n' "$t"
		__purge "$t"
	done

	rm -f "${SRCTYPE}"
}

dotfiles_sync () {
	[ -f "${SRCTYPE}" ] \
		&& read -r _type < "${SRCTYPE}"
	[ -z "${_type:-}" ] && return 1

	for t in ${_type}; do
		printf -- 'type: %s\n' "$t"
		check_srctype "$t" || continue
		printf -- '-> remove dangling symlinks\n'
		remove_symlinks "${SRCDIR}/$t" "${DESTDIR}"
		__update $t
	done
}

cmd="${1:-}"
[ "$#" -gt 0 ] && shift 1

case "$cmd" in
	'install') dotfiles_install "$@";;
	'uninstall') dotfiles_uninstall;;
	'sync' | '') dotfiles_sync;;
	*) printf -- 'Usage: %s [(install [src_type ...]|uninstall|sync)]\n' "$0";;
esac

