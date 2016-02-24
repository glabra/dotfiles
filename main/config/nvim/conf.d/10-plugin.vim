scriptencoding utf-8

call plug#begin(expand(g:myvim . '/bundle'))
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

