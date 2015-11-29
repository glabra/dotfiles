filetype off

set autoindent
set autoread
set breakindent
set completeopt& completeopt-=preview
set cursorline
set encoding=utf-8
set expandtab
set fileencodings=utf-8,ucs-bom,iso-2022-jp,cp932,euc-jp,default,latin
set laststatus=2
set list
set listchars=tab:>.,trail:~,nbsp:%
set modeline
set mouse=v
set nocursorcolumn
set nofoldenable
set number
set numberwidth=5
set shiftwidth=2 "cindentや>><<で入力されるインデントの幅
set showmatch
set smartindent
set softtabstop=2 "<TAB>を入力した際に入力されるインデントの幅
set splitbelow
set tabstop=2 "<TAB>の見た目の幅数
set wrap
set statusline=%f%(\ %M%R%)
set statusline+=%=\ \ 
set statusline+=%{(&ft!=''?&ft:'plain').':'.(&fenc!=''?&fenc:&enc).':'.&ff}\ [%2B]\ %v:%l/%L

colorscheme desert
highlight CursorLineNR cterm=bold

" rubyなファイルがストレスレスに開くようになる魔法の呪文
let g:ruby_path = ""

nnoremap <C-b> <C-u>
nnoremap <C-f> <C-d>
nnoremap <C-u> <C-y>
nnoremap <C-d> <C-e>
nnoremap <expr> <C-k><C-p> ( &paste == 1 ) ? ":set nopaste\<CR>" : ":set paste\<CR>"
nnoremap <expr> <C-k><C-n> ( &number == 1 ) ? ":set nonumber\<CR>" : ":set number\<CR>"
nnoremap <expr> <C-k><C-r> ( &readonly == 1 ) ? ":set readonly!\<CR>" : ":set readonly\<CR>"
nnoremap <expr> <C-k><C-e> ( &expandtab == 1 ) ? ":set expandtab!\<CR>" : ":set expandtab\<CR>"
nnoremap x "_x
nnoremap X "_X
nnoremap Y "+y
nnoremap YY "+yy
nnoremap - "+p
nnoremap _ "+P
vnoremap Y "+y
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <silent> <C-w><C-n> gt
nnoremap <silent> <C-w><C-p> gT
nnoremap <silent> <C-w>" :split<CR>:terminal<CR>
nnoremap <silent> <C-w>% :vsplit<CR>:terminal<CR>
nnoremap <silent> <C-w>x <C-w>q
nnoremap <silent> <C-w>c :tabnew<CR>:terminal<CR>
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <expr> <C-w>T ":vsplit " . tempname() . "\<CR>"
inoremap <silent> <C-w><C-n> <Esc>gt
inoremap <silent> <C-w><C-p> <Esc>gT
inoremap <silent> <C-w><C-w> <Esc>
tnoremap <silent> <C-w><C-n> <C-\><C-n>gt
tnoremap <silent> <C-w><C-p> <C-\><C-n>gT
tnoremap <silent> <C-w><C-w> <C-\><C-n>

call mkdir(expand("~/.cache/nvim/swap"), 'p')
set swapfile
set directory=~/.cache/nvim/swap
call mkdir(expand("~/.cache/nvim/undo"), 'p')
set undofile
set undodir=~/.cache/nvim/undo
call mkdir(expand("~/.cache/nvim/backup"), 'p')
set backup
set backupdir=~/.cache/nvim/backup

augroup vimrc_loading
  autocmd!
  autocmd BufNewFile *.rb 0r ${HOME}/.config/nvim/templates/ruby.txt
  autocmd BufNewFile *.sh 0r ${HOME}/.config/nvim/templates/sh.txt
  autocmd BufNewFile Makefile 0r ${HOME}/.config/nvim/templates/Makefile.txt
  autocmd BufNewFile *.c 0r ${HOME}/.config/nvim/templates/c.txt
augroup END

if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/Vundle.vim
endif
call vundle#begin('~/.config/nvim/bundle')
Plugin 'gmarik/Vundle.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/neosnippet'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'thinca/vim-splash'
Plugin 'travitch/hasksyn'
" vim-dirvish has serious bug after e430cdc949a743e2e13751db36a73b886dfa4c24.
" so, must stay in a14c58bcdf7b2b0f8aae895c107626d3470d016e.
Plugin 'justinmk/vim-dirvish', {'pinned': 1}

if executable('ctags')
  Plugin 'majutsushi/tagbar'
endif
call vundle#end()

" deoplete
let g:deoplete#enable_at_startup = 1

" neosnippet
let path_snippet_local = expand('~/.cache/neosnippet/localsnippets')
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = expand('~/.config/nvim/snippets')
nnoremap <expr> <C-i><C-i> ":NeoSnippetSource " . path_snippet_local . "\<CR>"
nnoremap <expr> <C-i>e ":new " . path_snippet_local . "\<CR>:set filetype=neosnippet\<CR>"
nnoremap <silent> <C-i>E :split<CR>:NeoSnippetEdit<CR>
function! s:keymappings_tab() abort
  if neosnippet#jumpable()
    return "\<Plug>(neosnippet_jump)"
  elseif neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  elseif pumvisible()
    return "\<C-n>"
  else
    return "\<TAB>"
  endif
endfunction
imap <expr> <C-k> (neosnippet#expandable()) ? "\<Plug>(neosnippet_expand)" : "\<C-k>"
imap <expr> <TAB> <SID>keymappings_tab()

" tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_type_tex = {
      \ 'ctagstype': 'latex',
      \ 'kinds': [
      \              's:sections',
      \              'g:graphics:0:0',
      \              'l:labels',
      \              'r:refs:1:0',
      \              'p:pagerefs:1:0'
      \          ],
      \ 'sort': 0,
      \ 'deffile': expand('~/.config/nvim/ctags/latex')
      \ }
nnoremap <silent> <C-k><C-l> :TagbarToggle<CR>

" vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
nnoremap <silent> <C-k><C-a> :AutoSaveToggle<CR>

" vim-dirvish
nnoremap <expr> <C-l> (glob('%')=='') ? ":Dirvish\<CR>" : ":Dirvish %\<CR>"

" vim-splash
let g:splash#path = expand('~/.config/nvim/splash.txt')

syntax on
filetype indent plugin on

