scriptencoding utf-8

let g:deoplete#enable_at_startup = 1

augroup deopleteLocalAutoCmd
  autocmd!
  autocmd CompleteDone * pclose!
augroup END
