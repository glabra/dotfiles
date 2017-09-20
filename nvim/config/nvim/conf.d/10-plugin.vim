scriptencoding utf-8

call plug#begin(expand(g:myvim . '/bundle'))
Plug 'justinmk/vim-dirvish'
Plug 'simeji/winresizer'
Plug 'neomake/neomake'
Plug 'thinca/vim-splash'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'
Plug 'tweekmonster/deoplete-clang2'

Plug 'majutsushi/tagbar',
     \ executable('ctags')
     \ ? {'on': 'TagbarToggle'}
     \ : {'on': []}

if isdirectory(expand('~/.fzf/'))
    Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
endif

call plug#end()
