# conf.d 内のどのファイルを読むべきかを記述する

append () {
    CONF_D_OBJECTIVE="${CONF_D_OBJECTIVE:-} $1"
}

append _default

for i in `ls -1 "${CONF_D}"`
do
    if [[ -n "$(eval echo '${'${i}'}')" ]] || type "${i}" > /dev/null 2>&1
    then
        append "${i}"
    fi
done

lazy_load () {
    [[ -d "$2" ]] && eval $1=\"$2\" && append "$1"
}

lazy_load rbenv "${HOME}/.rbenv"
lazy_load pyenv "${HOME}/.pyenv"
lazy_load nvm "${HOME}/.nvm"
lazy_load rustup "${HOME}/.cargo"

unset append
unset lazy_load
