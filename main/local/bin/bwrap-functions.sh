urldecode() {
	# from: https://unix.stackexchange.com/questions/159253/decoding-url-encoding-percent-encoding
	printf '%s' "$1" | sed 's@+@ @g;s@%@\\x@g' | xargs -0 printf "%b"
}

passenv () {
	printf -- '--setenv %s %s ' "$1" $(eval "printf -- '%s' \$$1")
}

passenv_if_exists () {
	_enval=$(eval printf '%s' '${'$1':-}')
	[ -n "$_enval" ] \
		&& printf -- '--setenv %s %s ' $1 "$_enval"
}

ro_bind () {
	printf -- '--ro-bind %s %s ' "$1" "$1"
}

rw_bind () {
	printf -- '--bind %s %s ' "$1" "$1"
}

rw_bind_if_exists () {
	[ -e "${1:-}" ] && rw_bind "$1"
}

dev_bind () {
	printf -- '--dev-bind /dev/%s /dev/%s ' "$1" "$1"
}

allow_ssl () {
	dev_bind random
	dev_bind urandom
	ro_bind /etc/ssl
	ro_bind /etc/ca-certificates
	ro_bind /usr/share/ca-certificates
}

allow_gpu () {
	dev_bind dri
	dev_bind null
	ro_bind /sys/dev/char
	ro_bind /sys/devices/pci0000:00
}

allow_locale () {
	ro_bind "/usr/share/locale/$1/LC_MESSAGES/$2.mo"
}

allow_localtime () {
	ro_bind /usr/share/zoneinfo
	ro_bind /etc/localtime
}

allow_fonts () {
	ro_bind /usr/share/fonts
	ro_bind /etc/fonts
}

parse_opts () {
	for i in $(seq 1 $(($# - 1))); do
		opts="${opts:+$opts }$1"
		shift 1
	done

	filepath=$(urldecode "${1:-}")
	filepath=${filepath#file://}
	if [ -f "${filepath}" ]; then
		fileext=${filepath##*.}
	elif [ -d "${filepath}" ]; then
		fileext=dir
	else
		opts="${opts:+$opts }${1:-}"
		unset filepath
	fi
}

