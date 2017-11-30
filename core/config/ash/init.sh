# if not interactive, return
case "$-" in
	*i*) ;; # pass
	*) return ;;
esac

CONFIG_DIR="${HOME}/.config/ash"
for i in \
	${CONFIG_DIR}/pre.d/* \
	${CONFIG_DIR}/conf.d/* \
	${CONFIG_DIR}/post.d/*
do
	. "${i}"
done
unset i
unset CONFIG_DIR

# initialization finished
date

