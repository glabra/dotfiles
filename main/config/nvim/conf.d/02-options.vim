scriptencoding utf-8

" options
set autoindent
set autoread
set autowrite
set backspace=indent
set expandtab
set laststatus=2
set list
set listchars=tab:>.,trail:~,nbsp:%
set magic
set modeline
set mouse=a
set nocursorline
set nocursorcolumn
set nofoldenable
set number
set numberwidth=5
set noshowmatch
set smartindent
set splitbelow
set wrap
set statusline=%f%(\ %M%R%)
set statusline+=%=\ \ 
set statusline+=%{(&ft!=''?&ft:'plain').':'.(&fenc!=''?&fenc:&enc).':'.&ff}\ [%2B]\ %v:%l/%L

if (v:version >= 704) && has('patch338')
    set breakindent
endif

" rubyなファイルがストレスレスに開くようになる魔法の呪文
" 代償として、補完が少し弱くなる
let g:ruby_path = ""

" allow directory-specific vimrc
set exrc
set secure

" enable files
set swapfile
set undofile
set backup
set backupdir-=.
