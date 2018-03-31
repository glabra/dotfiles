scriptencoding utf-8

nnoremap <silent> <F5> :tabedit $MYVIMRC<CR>
nnoremap <silent> <F6> :source $MYVIMRC<CR>

nnoremap <silent> <S-y> "+y
vnoremap <silent> <S-y> "+y
inoremap <silent> <C-w><C-w> <Esc>
nnoremap <silent> <C-w><C-n> gt
nnoremap <silent> <C-w><C-p> gT
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-w>" :split<CR>
nnoremap <silent> <C-w>% :vsplit<CR>
nnoremap <silent> <C-s> :write<CR>
inoremap <silent> <C-s> <C-o>:write<CR>
vnoremap <silent> <C-s> <Esc>:write<CR>gv

nnoremap <silent> <C-k><C-n> :setlocal number!<CR>
nnoremap <silent> <C-k><C-p> :setlocal paste!<CR>:echo 'paste='.&paste<CR>
nnoremap <silent> <C-k><C-e> :setlocal expandtab!<CR>:echo 'expandtab='.&expandtab<CR>

if has('nvim')
    nnoremap <silent> <C-w>m :tabnew<CR>:terminal<CR>i<CR>
    tnoremap <silent> <C-w><C-w> <C-\><C-n>
endif
