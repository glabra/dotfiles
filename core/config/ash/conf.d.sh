## is_busybox_binary bin
is_busybox_binary () {
	case $(readlink "$(command -v $1)") in
		*/busybox) return 0;;
		*) return 1;;
	esac
}

## source_if_exists PATH
source_if_exists () {
	[ -f "${1}" ] && . "${1}"
}

# source_lazy PATH commands...
source_lazy () {
	[ -e "${1}" ] || return

	path="${1}"
	shift 1
	for c in $@; do
		eval "$c () {
			unset -f $@
			. \"${path}\"
			$c \"\$@\"
		}"
	done
	unset path
}

## append_path PATH
append_path () {
	case "${PATH}" in
		*${1}*) ;;
		*) export PATH="${1}:${PATH}";;
	esac
}

__fetch () {
	if command -v curl >/dev/null; then
		curl -s "$1"
	elif command -v wget >/dev/null; then
		wget -q -O - "$1"
	else
		printf 'curl, wget not found.' 1>&2
		return 1
	fi
}

# append ~/.local/bin into PATH before reading configs
[ -d "${HOME}/.local/bin" ] \
	&& append_path "${HOME}/.local/bin"

# whether current shell is on WSL or not.
case $(uname -r) in
	*Microsoft)
		RCFILE_ON_WSL=true
esac

# read config
for i in ${CONFIG_DIR}/conf.d/*; do
	. "${i}"
done
unset i

# cleanup
[ -n "${RCFILE_ON_WSL:-}" ] && unset RCFILE_ON_WSL
unset -f is_busybox_binary
unset -f source_if_exists
unset -f source_lazy
unset -f append_path

