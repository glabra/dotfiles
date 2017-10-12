# whether current shell is on WSL or not.
#case $(uname -r) in
#        *Microsoft)
#                IS_WSL=true
#                ;;
#esac

__conf_local_onload () {
	wsl_root=/mnt/c
	IS_WSL=1
	WSL_USERDIR=$(cd ${wsl_root}; cmd.exe /D /C 'ECHO %USERPROFILE:\=/%')
	WSL_USERDIR="${wsl_root}/${WSL_USERDIR:3}"
	# erase `cr`, using bash extension since WSL should works on bash.
	WSL_USERDIR="${WSL_USERDIR:0:-1}"
	unset wsl_root
}

__conf_local_cleanup () {
	unset IS_WSL
	unset -f __conf_local_onload
	unset -f __conf_local_cleanup
}
