tput () {
    (cmd="${1:-}"

    case "${cmd}" in
        sgr0) printf '\033[0m' ;;
        bold) printf '\033[1m' ;;
         dim) printf '\033[2m' ;;
        smkx) printf '\033[?1h\033=' ;;
           *) ;;
    esac
    )
}
