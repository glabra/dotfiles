scriptencoding utf-8

imap <silent> <F1> <Esc>
nmap <silent> <F1> <Esc>
nnoremap <silent> <F5> :tabedit $MYVIMRC<CR>
nnoremap <silent> <F6> :source $MYVIMRC<CR>
nnoremap x "_x
nnoremap X "_X
nnoremap Y "+y
nnoremap YY "+yy
nnoremap - "+p
nnoremap _ "+P
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <silent> [ %
nnoremap <silent> F <C-d>
nnoremap <silent> B <C-u>
nnoremap <expr> <C-w>T ":vsplit " . tempname() . "\<CR>"
nnoremap <silent> <C-w>x <C-w>q
nnoremap <silent> <C-w><C-n> gt
nnoremap <silent> <C-w><C-p> gT
nnoremap <silent> <C-k><C-n> :setlocal number!<CR>
nnoremap <silent> <C-k><C-r> :setlocal readonly!<CR>
nnoremap <silent> <C-k><C-p> :setlocal paste!<CR>:echo 'paste='.&paste<CR>
nnoremap <silent> <C-k><C-e> :setlocal expandtab!<CR>:echo 'expandtab='.&expandtab<CR>
inoremap <silent> <C-w><C-n> <Esc>gt
inoremap <silent> <C-w><C-p> <Esc>gT
inoremap <silent> <C-w><C-w> <Esc>
vnoremap Y "+y

if has('nvim')
  nnoremap <silent> <C-w>" :split<CR>:terminal<CR>
  nnoremap <silent> <C-w>% :vsplit<CR>:terminal<CR>
  nnoremap <silent> <C-w>c :tabnew<CR>:terminal<CR>
  nnoremap <silent> <C-w>t :tabnew<CR>
  tnoremap <silent> <C-w><C-n> <C-\><C-n>gt
  tnoremap <silent> <C-w><C-p> <C-\><C-n>gT
  tnoremap <silent> <C-w><C-w> <C-\><C-n>
endif

