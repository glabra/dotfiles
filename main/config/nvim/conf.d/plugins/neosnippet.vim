scriptencoding utf-8

let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = expand(g:myvim . '/snippets')
nnoremap <silent> <C-k>E :split<CR>:NeoSnippetEdit<CR>
function! s:keymappings_tab() abort
  if neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  elseif neosnippet#jumpable()
    return "\<Plug>(neosnippet_jump)"
  elseif pumvisible()
    return "\<C-n>"
  else
    return "\<TAB>"
  endif
endfunction
imap <expr> <C-c> pumvisible() ? "\<C-y>" : "\<C-c>"
imap <expr> <C-k> (neosnippet#jumpable()) ? "\<Plug>(neosnippet_jump)" : "\<C-k>"
imap <expr> <TAB> <SID>keymappings_tab()

