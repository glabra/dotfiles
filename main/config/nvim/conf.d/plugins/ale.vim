scriptencoding utf-8

let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

nnoremap <silent> <C-k><C-b> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-k><C-f> <Plug>(ale_next_wrap)
