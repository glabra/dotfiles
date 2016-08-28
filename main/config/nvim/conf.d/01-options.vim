scriptencoding utf-8

" options
set autoindent
set autoread
set autowriteall
set breakindent
set completeopt& completeopt-=preview
" set cursorline
set nocursorline
set expandtab
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,cp932,default,latin
set foldmethod=manual
set laststatus=2
set list
set listchars=tab:>.,trail:~,nbsp:%
set magic
set modeline
set mouse-=a
set nocursorcolumn
set nofoldenable
set number
set numberwidth=5
set showmatch
set smartindent
set splitbelow
set updatetime=1000
set wrap
set statusline=%f%(\ %M%R%)
set statusline+=%=\ \ 
set statusline+=%{(&ft!=''?&ft:'plain').':'.(&fenc!=''?&fenc:&enc).':'.&ff}\ [%2B]\ %v:%l/%L

" color scheme
colorscheme desert
highlight CursorLineNR cterm=bold

" rubyなファイルがストレスレスに開くようになる魔法の呪文
" 代償として、補完が少し弱くなる
let g:ruby_path = ""

