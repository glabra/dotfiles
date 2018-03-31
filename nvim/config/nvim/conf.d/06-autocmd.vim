scriptencoding utf-8

augroup vimrc_loading
  autocmd!

  autocmd FileType c setlocal noexpandtab
  autocmd FileType c ChangeTabSpaces 8

  autocmd FileType sh setlocal noexpandtab

  autocmd FileType ruby ChangeTabSpaces 2

  autocmd FileType tex ChangeTabSpaces 2
  autocmd FileType tex setlocal foldmethod=indent
  autocmd FileType tex setlocal foldenable
  if executable("latexmk.exe")
    autocmd FileType tex setlocal makeprg=latexmk.exe\ -interaction=nonstopmode
  else
    autocmd FileType tex setlocal makeprg=latexmk\ -interaction=nonstopmode
  endif

  autocmd FileType vim ChangeTabSpaces 2

  autocmd Filetype *
    \ if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
augroup END
