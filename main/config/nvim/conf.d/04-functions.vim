scriptencoding utf-8

" Tab文字の数変更するヤツ
function! s:change_tab_spaces(scope, n) abort
  exec "let &".a:scope.":shiftwidth = ".a:n."\n"
    \. "let &".a:scope.":softtabstop = ".a:n."\n"
    \. "let &".a:scope.":tabstop = ".a:n."\n"
endfunction
function! s:get_and_change_local_tab_spaces() abort
  let l:chartable = ['1','2','3','4','5','6','7','8','9']
  let l:char = nr2char(getchar())
  if 0 <= index(l:chartable, l:char)
    call <SID>change_tab_spaces("l", l:char)
    echo '<Tab> is now' l:char 'spaces.'
  else
    echo '<Tab> is still' &l:tabstop 'spaces.'
  endif
endfunction
call s:change_tab_spaces("l",2)
call s:change_tab_spaces("g",2)
nnoremap <silent> <C-k><C-t> :call <SID>get_and_change_local_tab_spaces()<CR>
command! -nargs=1 ChangeTabSpaces call <SID>change_tab_spaces("l",<args>)

" 謎のバッファ殺しマシン
function! s:delete_hidden_buffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
nnoremap <silent> <C-k><C-f> :call <SID>delete_hidden_buffers()<CR>

