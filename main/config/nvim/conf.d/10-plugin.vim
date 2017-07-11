scriptencoding utf-8

call plug#begin(expand(g:myvim . '/bundle'))
Plug 'justinmk/vim-dirvish'
Plug 'mattn/sonictemplate-vim'
Plug 'simeji/winresizer'
Plug 'w0rp/ale'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'

Plug 'majutsushi/tagbar',
     \ executable('ctags')
     \ ? {'for': 'TagbarToggle'}
     \ : {'on': []}

if isdirectory(expand('~/.fzf/'))
    Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
endif

call plug#end()

