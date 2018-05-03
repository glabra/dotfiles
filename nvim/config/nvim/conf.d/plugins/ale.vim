scriptencoding utf-8

let g:ale_lint_on_text_changed = "never"
let g:ale_open_list = 1
let g:ale_use_deprecated_neovim = 1

nnoremap <silent> <C-w><C-n> <Plug>(ale_next_wrap)
nnoremap <silent> <C-w><C-p> <Plug>(ale_previous_wrap)

if executable("chktex.exe")
  let g:ale_tex_chktex_executable = "chktex.exe"
endif

