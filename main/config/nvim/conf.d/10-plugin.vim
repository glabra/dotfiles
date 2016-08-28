scriptencoding utf-8

call plug#begin(expand(g:myvim . '/bundle'))
Plug 'mattn/sonictemplate-vim'
Plug 'travitch/hasksyn', {'for': 'haskell'}
Plug 'justinmk/vim-dirvish'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/neosnippet'

if has('nvim')
    Plug 'Shougo/deoplete.nvim'
        \ | Plug 'Shougo/neco-syntax'
endif

if executable('ctags')
    Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
endif
call plug#end()

