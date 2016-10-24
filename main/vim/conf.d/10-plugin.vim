scriptencoding utf-8

call plug#begin(expand(g:myvim . '/bundle'))
Plug 'mattn/sonictemplate-vim'
Plug 'justinmk/vim-dirvish'
Plug 'Shougo/neosnippet'
Plug 'scrooloose/syntastic'
Plug 'thinca/vim-quickrun'

" rust
Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer', { 'for': 'rust' }

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        \ | Plug 'Shougo/neco-syntax'
else
    Plug 'Shougo/neocomplete.vim'
        \ | Plug 'Shougo/neco-syntax'
endif

if executable('ctags')
    Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
endif
call plug#end()

