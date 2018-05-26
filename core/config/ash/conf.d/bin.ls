alias l='ls'
alias la='ls -a'
alias ll='ls -la'

if [ -n "${ASH_LIGHTWEIGHT_MODE:-}" ] || is_busybox_binary 'ls' || ls --help >/dev/null 2>&1; then
        # Lightweight mode (WSL) | Busybox | GNU
        alias ls='ls --color=auto'
else
        # BSD
        alias ls='ls -G'
fi

