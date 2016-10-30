# if not interactive, return
echo $- | grep -q 'i' - || return

# consts
CONFIG_DIR="${HOME}/.config/sh"
SECRETS_PATH="${HOME}/.local/secrets.sh"

# trap logout script
test -f "${CONFIG_DIR}/logout.sh" && \
    trap ". ${CONFIG_DIR}/logout.sh; exit" EXIT

# alias tput to true when not available
type tput > /dev/null 2>&1 || alias tput=:

### initialize callback system {
# execute_callback <callback name> [unset function after executed]
execute_callback () {
  for cb in `eval echo '${__'${1}':-}'`
  do
    ${cb}
    test "${2:-}" = 'true' && unset -f ${cb}
  done

  test "${2:-}" = 'true' && eval unset '__'${1}
}

register_callback () {
  eval '__'${1}=${2} '${__'${1}':-}'
}

after_initialize () {
  register_callback after_initialize ${1}
}
### } initialize callback system

### load settings {
# require_secrets
alias require_secrets='return'

if test -f "${SECRETS_PATH}"
then
  . "${SECRETS_PATH}"
  alias require_secrets=':'
fi

# load configs
CONF_D="${CONFIG_DIR}/conf.d"
CONF_D_OBJECTIVE=''
. "${CONFIG_DIR}/conf.d.sh"

for i in ${CONF_D_OBJECTIVE}
do
    . "${CONF_D}/${i}"
done

# cleanup
unset CONF_D_OBJECTIVE
unset CONF_D
unalias require_secrets
### } load settings

# cleanup consts
unset SECRETS_PATH
unset CONFIG_DIR

print_initialized_date () {
    printf '%s\n' "`LANG=C date`"
}
after_initialize print_initialized_date

execute_callback after_initialize true

