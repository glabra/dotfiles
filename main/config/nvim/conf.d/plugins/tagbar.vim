scriptencoding utf-8

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
      \ 'deffile': expand(g:myvim . '/ctags/latex')
      \ }
nnoremap <silent> <C-k><C-m> :TagbarToggle<CR>
