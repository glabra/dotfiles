__conf_local_onload () {
	IS_WSL=1

	wsl_root=/mnt/c
	WSL_USERDIR=$(cmd.exe /D /C 'ECHO %USERPROFILE:\=/%' 2>/dev/null)
	# erase drive letter (C:/) and `cr`, then append prefix (${wsl_root})
	WSL_USERDIR="${wsl_root}/${WSL_USERDIR:3:$((${#WSL_USERDIR} - 4))}"
	export WSL_USERDIR
	unset wsl_root
}

__conf_local_cleanup () {
	unset IS_WSL
}

