scriptencoding utf-8

let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = expand(g:myvim . '/snippets')
nnoremap <silent> <C-k>E :split<CR>:NeoSnippetEdit<CR>

imap <expr> <TAB> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand)" :
            \ pumvisible() ?
            \ "\<C-n>" :
            \ neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)" :
            \ "\<TAB>"

smap <expr> <TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
