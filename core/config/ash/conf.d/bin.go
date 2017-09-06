command -v 'go' >/dev/null || return

export GOPATH="${HOME}/workspace/golang"
[ ! -d "${GOPATH}" ] && mkdir "${GOPATH}"

