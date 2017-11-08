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

# append ~/.local/bin into PATH before reading configs
[ -d "${HOME}/.local/bin" ] \
	&& append_path "${HOME}/.local/bin"

# read config
if [ -f "${CONFIG_DIR}/conf.d.local.sh" ]; then
	. "${CONFIG_DIR}/conf.d.local.sh"
	__conf_local_onload
fi

for i in ${CONFIG_DIR}/conf.d/*; do
	. "${i}"
done
unset i

# cleanup
if [ -f "${CONFIG_DIR}/conf.d.local.sh" ]; then
	unset -f __conf_local_onload
	unset -f __conf_local_cleanup
fi

unset -f is_busybox_binary
unset -f source_lazy
unset -f append_path

