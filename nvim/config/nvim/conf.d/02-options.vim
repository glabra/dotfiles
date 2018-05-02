scriptencoding utf-8

" options
set autoindent
set autoread
set autowrite
set ambiwidth=double
set backspace=indent,start
set expandtab
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,cp932,default,latin
set list
set listchars=tab:>.,trail:~,nbsp:%
set magic
set nomodeline
set mouse=
set nocursorline
set nocursorcolumn
set nofoldenable
"set number
"set numberwidth=5
set noshowmatch
set smartindent
set splitbelow
set wrap
set laststatus=1
set rulerformat=%v:%l/%L%=\ \ %P
set statusline=%f%(\ %M%R%)
set statusline+=%=\ \ 
set statusline+=%{(&ft!=''?&ft:'plain').':'.(&fenc!=''?&fenc:&enc).':'.&ff}\ [%2B]\ %v:%l/%L\ %P

if (v:version >= 704) && has('patch338')
    set breakindent
endif

" rubyなファイルがストレスレスに開くようになる魔法の呪文
" 代償として、補完が少し弱くなる
let g:ruby_path = ""

" set tex flavour as latex
let g:tex_flavor = "latex"

" enable files
set swapfile
set undofile
set backup
set backupdir-=.

" if backupdir not exist, create it
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif

colorscheme industry
