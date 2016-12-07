# if not interactive, return
echo $- | fgrep -q 'i' || return

# mandatory environment variables
export LANG="en_US.UTF-8"
export PATH="${HOME}/.local/bin:${PATH}"

# consts
CONFIG_DIR="${HOME}/.config/ash"
SECRETS_PATH="${HOME}/.local/secrets.sh"

# if tput is not exist, fallback to shellscript implimentation.
type tput 2>&1 >/dev/null || . "${CONFIG_DIR}/tput.sh"

# callback system
## in callback in PS1, you can use $? as $EXITCODE.
## execute_callback <callback name> [unset function after executed]
execute_callback () {
  EXITCODE=$?

  local cbs=$(eval "printf '%s' \"\${__cbsys_${1}:-}\"" | sort -n | sed '/^$/d' | cut -d'/' -f2)
  for cb in ${cbs:-}
  do
    ${cb}
    [ -n "${2:-}" ] && unset -f ${cb}
  done

  [ -n "${2:-}" ] && eval "unset __cbsys_${1}"

  return $EXITCODE
}

## register_callback <callback name> <function name> <priority>
##   priority: smaller is better
register_callback () {
  eval "__cbsys_${1}=\"${3:-100}/${2}
\${__cbsys_${1}:-}\""
}

# load configs
. "${CONFIG_DIR}/conf.d.sh"

# cleanup consts
unset SECRETS_PATH
unset CONFIG_DIR
unset EXITCODE # when execute_callback in main shell, this remains.

# initialize finished
printf '%s\n' "`LANG=C date`"

