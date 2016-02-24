scriptencoding utf-8

" options
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

" color scheme
colorscheme desert
highlight CursorLineNR cterm=bold

" rubyなファイルがストレスレスに開くようになる魔法の呪文
" 代償として、補完が少し弱くなる
let g:ruby_path = ""

