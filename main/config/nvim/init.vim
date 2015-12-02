scriptencoding utf-8

filetype off

set autoindent
set autoread
set breakindent
set completeopt& completeopt-=preview
set cursorline
set expandtab
set fileencodings=utf-8,ucs-bom,iso-2022-jp,cp932,euc-jp,default,latin
set laststatus=2
set list
set listchars=tab:>.,trail:~,nbsp:%
set modeline
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

nnoremap x "_x
nnoremap X "_X
nnoremap Y "+y
nnoremap YY "+yy
nnoremap - "+p
nnoremap _ "+P
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <expr> <C-w>T ":vsplit " . tempname() . "\<CR>"
nnoremap <silent> <C-w>x <C-w>q
nnoremap <silent> <C-w><C-n> gt
nnoremap <silent> <C-w><C-p> gT
nnoremap <expr> <C-k><C-n> (&number == 1) ? ":setlocal nonumber\<CR>" : ":setlocal number\<CR>"
nnoremap <expr> <C-k><C-p> (&paste == 1) ? ":setlocal nopaste\<CR>" : ":setlocal paste\<CR>"
nnoremap <expr> <C-k><C-r> (&readonly == 1) ? ":setlocal readonly!\<CR>" : ":setlocal readonly\<CR>"
nnoremap <expr> <C-k><C-e> (&expandtab == 1) ? ":setlocal expandtab!\<CR>" : ":setlocal expandtab\<CR>"
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

" rubyなファイルがストレスレスに開くようになる魔法の呪文
" 代償として、補完が少し弱くなる
let g:ruby_path = ""

" $MYVIM (vimの設定フォルダ格納するヤツ)
if has('nvim')
  if exists($XDG_CONFIG_HOME)
    let $MYVIM = expand('$XDG_CONFIG_HOME')
  else
    let $MYVIM = expand('$HOME/.config/nvim')
  endif
else
  let $MYVIM = expand('$HOME/.vim')
endif

" swapfile等の格納先変更
if exists($XDG_DATA_HOME)
  let s:datadir_prefix = expand('$XDG_CONFIG_HOME/nvim')
else
  let s:datadir_prefix = expand('$HOME/.local/share/nvim')
endif

set swapfile
set undofile
set backup

let &backupdir=s:datadir_prefix . "/backup"
call mkdir(&backupdir, 'p')
" default behavior
"let &directory=s:datadir_prefix . "/swap"
"let &undodir=s:datadir_prefix . "/undo"
"let &viewdir=s:datadir_prefix . "/view"
"call mkdir(&directory, 'p')
"call mkdir(&undodir, 'p')
"call mkdir(&viewdir, 'p')

unlet s:datadir_prefix

" Tab文字の数変更するヤツ
function! ChangeTabSpaces(n) abort
  let &l:shiftwidth = a:n
  let &l:softtabstop = a:n
  let &l:tabstop = a:n
endfunction
command! -nargs=1 Chtab :call ChangeTabSpaces(<f-args>)

" autocmd!
augroup vimrc_loading
  autocmd!
  autocmd BufNewFile *.rb 0r $MYVIM/templates/ruby.txt
  autocmd BufNewFile *.sh 0r $MYVIM/templates/sh.txt
  autocmd BufNewFile Makefile 0r $MYVIM/templates/Makefile.txt
  autocmd BufNewFile *.c 0r $MYVIM/templates/c.txt
  autocmd BufReadPost .mkshrc :setlocal filetype=sh
  autocmd FileType c :setlocal noexpandtab
  autocmd FileType c :call ChangeTabSpaces(8)
  autocmd FileType java :call ChangeTabSpaces(4)
augroup END

" Plugins
if has('vim_starting')
  set runtimepath+=$MYVIM/bundle/Vundle.vim
endif
call vundle#begin(expand('$MYVIM/bundle'))
Plugin 'gmarik/Vundle.vim'
Plugin 'Shougo/neosnippet'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'thinca/vim-splash'
Plugin 'travitch/hasksyn'
" vim-dirvish has serious bug after e430cdc949a743e2e13751db36a73b886dfa4c24.
" so, must stay in a14c58bcdf7b2b0f8aae895c107626d3470d016e.
Plugin 'justinmk/vim-dirvish', {'pinned': 1}

if has('nvim')
  Plugin 'Shougo/deoplete.nvim'
endif
if executable('ctags')
  Plugin 'majutsushi/tagbar'
endif
call vundle#end()

if has('nvim')
  " deoplete
  let g:deoplete#enable_at_startup = 1
endif

" neosnippet
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = expand('$MYVIM/snippets')
nnoremap <silent> <C-k>E :split<CR>:NeoSnippetEdit<CR>
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
      \ 'deffile': expand('$MYVIM/ctags/latex')
      \ }
nnoremap <silent> <C-k><C-h> :TagbarToggle<CR>

" vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
nnoremap <silent> <C-k><C-a> :AutoSaveToggle<CR>

" vim-dirvish
nnoremap <expr> <C-k><C-l> (glob('%')=='') ? ":Dirvish\<CR>" : ":Dirvish %\<CR>"

" vim-splash
let g:splash#path = expand('$MYVIM/splash.txt')

syntax on
filetype indent plugin on

