# if not interactive, return
echo $- | fgrep -q 'i' || return

# consts
CONFIG_DIR="${HOME}/.config/ash"
SECRETS_PATH="${HOME}/.local/secrets.sh"

# if tput is not exist, fallback to shellscript implimentation.
type tput > /dev/null 2>&1 || . "${CONFIG_DIR}/tput.sh"

# callback system
## execute_callback <callback name> [unset function after executed]
execute_callback () {
  for cb in `eval printf '%s' '${__'${1}':-}'`
  do
    ${cb}
    test "${2:-}" = 'true' && unset -f ${cb}
  done
  unset cb

  test "${2:-}" = 'true' && eval unset '__'${1}
}

## register_callback <callback name> <function name>
register_callback () {
  eval '__'${1}=${2} '${__'${1}':-}'
}

# load configs
. "${CONFIG_DIR}/conf.d.sh"

# cleanup consts
unset SECRETS_PATH
unset CONFIG_DIR

# trap logout script
test -f "${CONFIG_DIR}/logout.sh" && \
    trap ". ${CONFIG_DIR}/logout.sh; exit" EXIT

# initialize is done
printf '%s\n' "`LANG=C date`"

