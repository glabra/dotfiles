# on WSL, `git` should be provided
if [ -z "${IS_WSL:-}" ]; then
	command -v 'tmux' >/dev/null || return
fi

alias t='tmux'

