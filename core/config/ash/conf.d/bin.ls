alias l='ls'
alias la='ls -a'
alias ll='ls -la'

if [ -n "${IS_WSL:-}" ] || is_busybox_binary 'ls' || ls --help >/dev/null 2>&1; then
        # WSL (GNU) | Busybox | GNU
        alias ls='ls --color=auto'
else
        # BSD
        alias ls='ls -G'
fi

