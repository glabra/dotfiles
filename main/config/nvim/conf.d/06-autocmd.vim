scriptencoding utf-8

augroup vimrc_loading
  autocmd!
  autocmd BufNewFile *.tex setlocal filetype=tex
  autocmd FileType c setlocal noexpandtab
  autocmd FileType c call <SID>change_tab_spaces("l",8)
  autocmd FileType java call <SID>change_tab_spaces("l",4)
augroup END

