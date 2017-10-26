alias l='ls'
alias la='ls -a'
alias ll='ls -la'

if [ -n "${IS_WSL:-}" ]; then
	# on WSL, assuming ls as GNU binary
	alias ls='ls --color=auto'
	return
fi

if is_busybox_binary 'ls' || ls --help >/dev/null 2>&1; then
        # Busybox | GNU
        alias ls='ls --color=auto'
else
        # BSD
        alias ls='ls -G'
fi

