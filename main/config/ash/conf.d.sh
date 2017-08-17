# util function
## is_busybox_binary
is_busybox_binary () {
	readlink "$(command -v $1)" | fgrep -q '/busybox'
}

## source_if_exists PATH
source_if_exists () {
	[ -f "${1}" ] \
		&& . "${1}"
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

append_path () {
	case "${PATH}" in
		*${1}*) ;;
		*) export PATH="${1}:${PATH}";;
	esac
}

# append ~/.local/bin into PATH before reading configs
append_path "${HOME}/.local/bin"

# read config
for i in ${CONFIG_DIR}/conf.d/*; do
	. "${i}"
done
unset i

# cleanup
unset -f is_busybox_binary
unset -f source_if_exists
unset -f source_lazy
unset -f append_path

