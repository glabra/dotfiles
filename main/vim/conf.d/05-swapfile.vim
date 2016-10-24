scriptencoding utf-8

if has('nvim')
  " swapfile等の格納先変更
  if exists($XDG_DATA_HOME)
    let s:datadir_prefix = expand('$XDG_CONFIG_HOME/nvim')
  else
    let s:datadir_prefix = expand('$HOME/.local/share/nvim')
  endif

  set swapfile
  set undofile
  set backup

  let &backupdir=s:datadir_prefix . "/backup"
  call mkdir(&backupdir, 'p')
  " default behavior
  "let &directory=s:datadir_prefix . "/swap"
  "let &undodir=s:datadir_prefix . "/undo"
  "let &viewdir=s:datadir_prefix . "/view"
  "call mkdir(&directory, 'p')
  "call mkdir(&undodir, 'p')
  "call mkdir(&viewdir, 'p')

  unlet s:datadir_prefix
endif

