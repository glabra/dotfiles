# if not interactive, return
case "$-" in
	*i*) ;; # pass
	*) return ;;
esac

# mandatory environment variables
[ "${LANG}" != 'en_US.UTF-8' ] \
	&& export LANG="en_US.UTF-8"
printf "${PATH}" | fgrep -q "${HOME}/.local/bin" \
	|| export PATH="${HOME}/.local/bin:${PATH}"

# consts
CONFIG_DIR="${HOME}/.config/ash"
SECRETS_PATH="${HOME}/.local/secrets.sh"

# if tput is not exist, fallback to shellscript implimentation.
type tput >&/dev/null || . "${CONFIG_DIR}/tput.sh"

# load configs
. "${CONFIG_DIR}/conf.d.sh"

# cleanup consts
unset SECRETS_PATH
unset CONFIG_DIR

# setup PS1
export PS1='\[$(tput bold)\]\W\[$(tput sgr0)\]$(__git_ps1 '':%s'')\[$(tput bold)\]\$\[$(tput sgr0)\] (\t) \[$(tput dim)\]『$(fortune | tr -d ''\n'')』\[$(tput sgr0)\]\n${PS2}'

# initialize finished
printf '%s\n' "$(LANG=C date)"

