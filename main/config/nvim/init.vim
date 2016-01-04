" only for vim compability
if !1 | finish | endif

scriptencoding utf-8

" vim-plug do this
"filetype off

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
set mouse-=a
set nocursorcolumn
set nofoldenable
set number
set numberwidth=5
set showmatch
set smartindent
set splitbelow
set wrap
set statusline=%f%(\ %M%R%)
set statusline+=%=\ \ 
set statusline+=%{(&ft!=''?&ft:'plain').':'.(&fenc!=''?&fenc:&enc).':'.&ff}\ [%2B]\ %v:%l/%L

colorscheme desert
highlight CursorLineNR cterm=bold

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

" rubyなファイルがストレスレスに開くようになる魔法の呪文
" 代償として、補完が少し弱くなる
let g:ruby_path = ""

" s:myvim (vimの設定フォルダ格納するヤツ)
if has('nvim')
  if exists($XDG_CONFIG_HOME)
    let s:myvim = expand('$XDG_CONFIG_HOME')
  else
    let s:myvim = expand('$HOME/.config/nvim')
  endif
else
  let s:myvim = expand('$HOME/.vim')
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
function! s:change_tab_spaces(scope, n) abort
  exec "let &".a:scope.":shiftwidth = ".a:n."\n"
    \. "let &".a:scope.":softtabstop = ".a:n."\n"
    \. "let &".a:scope.":tabstop = ".a:n."\n"
endfunction
function! s:get_and_change_local_tab_spaces() abort
  let l:chartable = ['1','2','3','4','5','6','7','8','9']
  let l:char = nr2char(getchar())
  if 0 <= index(l:chartable, l:char)
    call <SID>change_tab_spaces("l", l:char)
    echo '<Tab> is now' l:char 'spaces.'
  else
    echo '<Tab> is still' &l:tabstop 'spaces.'
  endif
endfunction
call s:change_tab_spaces("l",2)
call s:change_tab_spaces("g",2)
nnoremap <silent> <C-k><C-t> :call <SID>get_and_change_local_tab_spaces()<CR>
nnoremap command! -nargs=2 ChangeTabSpaces :call <SID>change_tab_spaces(<f-args>)

" autocmd!
augroup vimrc_loading
  autocmd!
  autocmd BufReadPost .mkshrc setlocal filetype=sh
  autocmd BufNewFile *.tex setlocal filetype=tex
  autocmd FileType c setlocal noexpandtab
  autocmd FileType c call <SID>change_tab_spaces("l",8)
  autocmd FileType java call <SID>change_tab_spaces("l",4)
augroup END

" Plugins
call plug#begin(expand(s:myvim . '/bundle'))
Plug 'Shougo/neosnippet'
Plug 'vim-scripts/vim-auto-save'
Plug 'mattn/sonictemplate-vim'
Plug 'travitch/hasksyn', {'for': 'haskell'}
Plug 'justinmk/vim-dirvish', {'commit': 'a14c58bcdf7b2b0f8aae895c107626d3470d016e'}

if has('nvim')
  Plug 'Shougo/deoplete.nvim'
endif
if executable('ctags')
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
endif
call plug#end()

" Neovim only plugins
if has('nvim')
  " deoplete
  let g:deoplete#enable_at_startup = 1
endif

" neosnippet
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = expand(s:myvim . '/snippets')
nnoremap <silent> <C-k>E :split<CR>:NeoSnippetEdit<CR>
function! s:keymappings_tab() abort
  if neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  elseif neosnippet#jumpable()
    return "\<Plug>(neosnippet_jump)"
  elseif pumvisible()
    return "\<C-n>"
  else
    return "\<TAB>"
  endif
endfunction
imap <expr> <C-c> pumvisible() ? "\<C-y>" : "\<C-c>"
imap <expr> <C-k> (neosnippet#jumpable()) ? "\<Plug>(neosnippet_jump)" : "\<C-k>"
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
      \ 'deffile': expand(s:myvim . '/ctags/latex')
      \ }
nnoremap <silent> <C-k><C-m> :TagbarToggle<CR>

" vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
nnoremap <silent> <C-k><C-a> :AutoSaveToggle<CR>

" vim-dirvish
nnoremap <expr> <C-k><C-l> (glob('%')=='') ? ":Dirvish\<CR>" : ":Dirvish %\<CR>"

" vim-sonictemplate
let g:sonictemplate_vim_template_dir = expand(s:myvim . '/templates')
nnoremap <C-k><C-w> :Template 

" vim-plug do this
"syntax on
"filetype indent plugin on

