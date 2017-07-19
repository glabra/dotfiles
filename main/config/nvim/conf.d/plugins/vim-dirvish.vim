scriptencoding utf-8

nnoremap <expr> <C-k><C-l> (glob('%')=='') ? ":Dirvish\<CR>" : ":Dirvish %\<CR>"
