
VIM_CONFDIR="${DESTINATION}/.vim"

__vim_install () {
    if ! which vim git openssl 2>&1 >/dev/null; then
        printf 'vim, git or openssl not found. aborting vim initialize.\n'
        return 1
    fi

    local vimplug_dest="${VIM_CONFDIR}/autoload/plug.vim"
    local vimplug_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # check if vim is already initialized
    [ -f "${vimplug_dest}" ] && return 0

    mkdir -p -- "$(dirname "${vimplug_dest}")"

    if which curl 2>&1 >/dev/null; then
        curl -o "${vimplug_dest}" -- "${vimplug_url}"
    elif which wget 2>&1 >/dev/null; then
        wget -O "${vimplug_dest}" -- "${vimplug_url}"
    else
        printf 'wget or curl not found. aborting.\n'
        return 1
    fi

    vim +PlugInstall +qall
}

__vim_uninstall () {
    rm -rf -- "${VIM_CONFDIR}"
}

module_install () {
    __vim_install
}

module_uninstall () {
    __vim_uninstall
}

