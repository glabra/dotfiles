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

<< _COMMENT_
lazy_load () {
    [[ -d "$2" ]] && eval $1=\"$2\" && append "$1"
}
# do something here
unset lazy_load
_COMMENT_

unset append
