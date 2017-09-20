scriptencoding utf-8

augroup vimrc_loading
  autocmd!

  autocmd FileType c setlocal noexpandtab
  autocmd FileType c ChangeTabSpaces 8

  autocmd FileType sh setlocal noexpandtab

  autocmd FileType ruby ChangeTabSpaces 2

  autocmd FileType tex ChangeTabSpaces 2
  autocmd FileType tex setlocal makeprg=latexmk\ -xelatex\ -interaction=nonstopmode
  autocmd FileType tex setlocal foldmethod=indent
  autocmd FileType tex setlocal foldenable
augroup END
