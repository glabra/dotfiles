scriptencoding utf-8

augroup vimrc_loading
  autocmd!
  autocmd BufRead,BufNewFile *.tex set filetype=tex

  autocmd FileType c setlocal noexpandtab
  autocmd FileType c ChangeTabSpaces 8
  autocmd FileType sh setlocal noexpandtab
  autocmd FileType ruby ChangeTabSpaces 2
augroup END
