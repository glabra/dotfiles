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
    cat << _EOF_
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
    local srcdir=$1
    local destdir=$2

    find "${srcdir}" -type d | \
        sed "s%^${srcdir}/%${destdir}/.%" | \
        xargs mkdir -p >/dev/null 2>&1

    local files=$(find "${srcdir}" -type f)
    for file in ${files}; do
        dest="${destdir}/.${file#${srcdir}/}"
        [ ! -L "${dest}" ] && ln -s -- "${file}" "${dest}"
    done
    unset dest
    unset file
}

remove_symlinks () {
    local srcdir=$1
    local destdir=$2

    local files=$(find "${srcdir}" -type f)
    for file in ${files}; do
        dest="${destdir}/.${file#${srcdir}/}"
        [ -L "${dest}" ] && rm -f "${dest}"
    done
    unset dest
    unset file

    find "${srcdir}" -type d | \
        sed "s%^${srcdir}/%${destdir}/.%" | \
        xargs rmdir -p >/dev/null 2>&1
}

remove_dangling_symlinks () {
    local srcdir=$1
    local destdir=$2

    local files=$(find "${destdir}" -type l)
    for file in ${files}; do
        realfile=$(readlink "${file}") && \
            printf '%s' "${realfile}" | fgrep -q "${srcdir}" && \
            [ ! -e "${realfile}" ] && \
            rm -f -- "${file}"
    done
    unset realfile
    unset file

    find "${srcdir}" -type d | \
        sed "s%^${srcdir}/%${destdir}/.%" | \
        xargs rmdir -p >/dev/null 2>&1
}

get_srctype () {
    [ -n "${1:-}" ] && \
        printf -- '%s' "${src_type}" > "${SRCTYPE_FILE}"

    [ -e "${SRCTYPE_FILE}" ] && \
        src_type=$(cat "${SRCTYPE_FILE}")

    [ -z "${src_type:-}" ] && \
        printf -- 'No src_type defined.\n' && \
        exit 1

    printf -- '%s' "${src_type}"
}

__install () {
    local src_type=$(get_srctype ${1:-})
    local srcdir="${ROOT}/${src_type}"

    [ ! -d "${srcdir}" ] && \
        printf -- '`%s` not found.\n' "${srcdir}" && \
        return 1

    printf -- '-> create symlinks\n'
    create_symlinks "${srcdir}" "${DESTINATION}"

    printf -- '-> module install\n'
    [ -f "${srcdir}.sh" ] && \
        . "${srcdir}.sh" && \
        module_install
}

__uninstall () {
    local src_type=$(get_srctype ${1:-})
    local srcdir="${ROOT}/${src_type}"

    printf -- '-> module uninstall\n'
    [ ! -d "${srcdir}" ] && \
        printf -- '`%s` not found.\n' "${srcdir}" && \
        return 1

    [ -f "${srcdir}.sh" ] && \
        . "${srcdir}.sh" && \
        module_uninstall

    printf -- '-> delete symlinks\n'
    remove_dangling_symlinks "${srcdir}" "${DESTINATION}"
    remove_symlinks "${srcdir}" "${DESTINATION}"
}

__sync () {
    local src_type=$(get_srctype ${1:-})
    local srcdir="${ROOT}/${src_type}"
    [ ! -d "${srcdir}" ] && \
        printf -- '`%s` not found.\n' "${srcdir}" && \
        return 1

    remove_dangling_symlinks "${srcdir}" "${DESTINATION}"
}

case "${1:-}" in
    'install' | '') __install "${2:-}" ;;
    'uninstall') __uninstall ;;
    'sync') __sync ;;
    'help') die 0;;
    *) die 1;;
esac

