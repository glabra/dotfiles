# source conf.d
conf_d="${CONFIG_DIR}/conf.d"
files=$(ls -1 "${conf_d}")

# util function
## is_busybox_binary
is_busybox_binary () {
	readlink "$(which $1 2> /dev/null)" 2> /dev/null | fgrep -q '/busybox'
	return $?
}

# append_path_if_exists PATH
append_path_if_exists () {
	[ -e "${1}" ] && export PATH="${1}:${PATH}"
}

# append_path_if_exists_lazy PATH commands...
append_path_if_exists_lazy () {
	path="${1}"
	shift 1
	[ -e "${path}" ] && for cmd in "$@"; do
		eval "${cmd} () {
			export PATH=\"${path}:\${PATH}\"
			unset -f $@
			${cmd} \"\$@\"
		}"
	done
	unset path
}

# source_if_exists PATH
source_if_exists () {
	if [ -f "${1}" ]; then
		. "${1}"
		return 0
	else
		return 1
	fi
}

# source_if_exists_lazy PATH commands...
source_if_exists_lazy () {
	path="${1}"
	shift 1
	[ -e "${path}" ] && for cmd in "$@"; do
		eval "${cmd} () {
			unset -f $@
			. \"${path}\"
			${cmd} \"\$@\"
		}"
	done
	unset path
}

## require_secrets: is ${SECRETS_PATH} exist?
alias require_secrets='return'
source_if_exists "${SECRETS_PATH}" && \
	alias require_secrets=':'

# read config
## `_FNAME` is always read.
## `FNAME` is read only when `FNAME` is defined or exist.
for i in ${files}; do
	[ "${i:0:1}" == '_' ] || \
	type "${i}" > /dev/null 2>&1 && \
		. "${conf_d}/${i}"
done
unset i

# cleanup
unalias require_secrets
unset -f is_busybox_binary
unset -f source_if_exists
unset -f source_if_exists_lazy
unset -f append_path_if_exists
unset -f append_path_if_exists_lazy
unset conf_d
unset files
