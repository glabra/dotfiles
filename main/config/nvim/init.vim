if !1 | finish | endif
" ^ only for vim-tiny compability

scriptencoding utf-8

" for evim compability
if v:progname =~? "evim"
    finish
endif

set nocompatible

" vim-plug do this
"filetype off

if has('nvim')
  if exists($XDG_CONFIG_HOME)
    let g:myvim = expand('$XDG_CONFIG_HOME')
  else
    let g:myvim = expand('$HOME/.config/nvim')
  endif
else
  let g:myvim = expand('$HOME/.vim')
endif

runtime! conf.d/*.vim
runtime! conf.d/plugins/*.vim

unlet g:myvim

" vim-plug do this
"syntax on
"filetype indent plugin on

