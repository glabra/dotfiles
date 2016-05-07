scriptencoding utf-8

augroup vimrc_loading
  autocmd!
  autocmd BufNewFile *.tex setlocal filetype=tex
  autocmd BufRead,BufNewFile *.ll setlocal filetype=llvm
  autocmd FileType c setlocal noexpandtab
  autocmd FileType c ChangeTabSpaces 8
  autocmd FileType ruby ChangeTabSpaces 2
augroup END

