# source conf.d
conf_d="${CONFIG_DIR}/conf.d"
files=$(ls -1 "${conf_d}")

# util function
## is_busybox_binary
is_busybox_binary () {
    readlink "$(which $1 2> /dev/null)" 2> /dev/null | fgrep -q '/busybox'
    return $?
}

append_path_if_exists () {
    [ -d "${1}" ] && export PATH="${1}:${PATH}"
}

source_if_exists () {
    [ -f "${1}" ] && . "${1}"
}

## require_secrets: is ${SECRETS_PATH} exist?
alias require_secrets='return'
test -f "${SECRETS_PATH}" && \
    . "${SECRETS_PATH}" && \
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
unset -f append_path_if_exists
unset conf_d
unset files
