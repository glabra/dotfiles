# source conf.d
conf_d="${CONFIG_DIR}/conf.d"
files=$(ls -1 "${conf_d}")

# util function
## is_busybox_binary
is_busybox_binary () {
    readlink "$(which $1 2> /dev/null)" 2> /dev/null | fgrep -q '/busybox'
    return $?
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
unset conf_d
unset files

<< _COMMENT_
lazy_load () {
    [[ -d "$2" ]] && eval $1=\"$2\" && append "$1"
}
# do something here
unset lazy_load
_COMMENT_
