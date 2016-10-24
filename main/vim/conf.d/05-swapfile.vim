scriptencoding utf-8

function! s:mkdir_if_not_exist(path) abort
    if empty(finddir(a:path))
        call mkdir(a:path, 'p')
    endif
endfunction

" swapfile等の格納先変更
if has('nvim')
    if exists($XDG_DATA_HOME)
        let s:datadir_prefix = expand('$XDG_CONFIG_HOME/nvim')
    else
        let s:datadir_prefix = expand('$HOME/.local/share/nvim')
    endif
else
    let s:datadir_prefix = expand('$HOME/.cache/vim')
endif

set swapfile
set undofile
set backup

let &backupdir=s:datadir_prefix . "/backup"
let &directory=s:datadir_prefix . "/swap"
let &undodir=s:datadir_prefix . "/undo"
call s:mkdir_if_not_exist(&backupdir)
call s:mkdir_if_not_exist(&directory)
call s:mkdir_if_not_exist(&undodir)

unlet s:datadir_prefix
delfunction s:mkdir_if_not_exist
