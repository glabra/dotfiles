scriptencoding utf-8

nnoremap <silent> <F5> :tabedit $MYVIMRC<CR>
nnoremap <silent> <F6> :source $MYVIMRC<CR>

nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <expr> <C-w>T ":vsplit " . tempname() . "\<CR>"
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-w>" :split<CR>
nnoremap <silent> <C-w>% :vsplit<CR>

nnoremap <silent> <C-k><C-n> :setlocal number!<CR>
nnoremap <silent> <C-k><C-r> :setlocal readonly!<CR>
nnoremap <silent> <C-k><C-p> :setlocal paste!<CR>:echo 'paste='.&paste<CR>
nnoremap <silent> <C-k><C-e> :setlocal expandtab!<CR>:echo 'expandtab='.&expandtab<CR>

inoremap <silent> <C-w><C-w> <Esc>
vnoremap Y "+y

if has('nvim')
    nnoremap <silent> <C-w>c :tabnew<CR>:terminal<CR>
    tnoremap <silent> <C-w><C-w> <C-\><C-n>
endif

