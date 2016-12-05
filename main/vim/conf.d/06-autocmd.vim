scriptencoding utf-8

augroup vimrc_loading
  autocmd!
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  autocmd BufRead,BufNewFile ~/.mutt/* set filetype=muttrc

  autocmd FileType c setlocal noexpandtab
  autocmd FileType c ChangeTabSpaces 8
  autocmd FileType ruby ChangeTabSpaces 2
  autocmd FileType verilog ChangeTabSpaces 3
augroup END

