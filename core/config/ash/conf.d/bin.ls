if [ -n "${RCFILE_ON_WSL:-}" ]; then
	# on WSL, assuming ls as GNU binary
	alias ls='ls --color=auto'
	return
fi

if is_busybox_binary 'ls' || ls --help 2>&1 >/dev/null; then
        # Busybox | GNU
        alias ls='ls --color=auto'
else
        # BSD
        alias ls='ls -G'
fi
