# if not interactive, return
case "$-" in
	*i*) ;; # pass
	*) return ;;
esac

# consts
CONFIG_DIR="${HOME}/.config/ash"

# load configs
. "${CONFIG_DIR}/conf.d.sh"

# cleanup consts
unset CONFIG_DIR

# initialization finished
date
