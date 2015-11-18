""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: WTFPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpo = &cpo
set cpo&vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PUBLIC FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO use the syntax Join/<pattern>/ & Split/<pattern>/ if empty use last
" search for split?

function! split_join#split_cmd(count, first_line, last_line, input, bang) abort "{{{2
    let input = s:get_input(a:input)

    let selection = selection#new(a:count, a:first_line, a:last_line)
    if selection.content == ''
        throw 'nothing there'
    endif

    let expr_list = split(selection.content, '\n', 1)

    for i in range(len(expr_list))
        let expr_list[i] = join(split(expr_list[i], input),"\n")
    endfor

    let expr_lines = join(expr_list, "\n")
    call selection.over_write(expr_lines)
endfunction "}}}2


function! split_join#join_cmd(count, first_line, last_line, input, bang) abort "{{{2
    let input = s:get_input(a:input)

    let selection = selection#new(a:count, a:first_line, a:last_line)
    if selection.content == ''
        throw 'nothing there'
    endif

    let expr_list = split(selection.content, '\n', 0)

    let expr_lines = join(expr_list, input)
    call selection.over_write(expr_lines)
endfunction "}}}2


function! split_join#split()
    s/\v(.{-})(\s*)(%#)(\s*)(.*)/\1\r\3\5
    call histdel("/", -1)
    normal! ==
endfunction


function! split_join#split_up()
    s/\v(.{-})(\s*)(%#)(\s*)(.*)/\3\5\r\1
    call histdel("/", -1)
    normal! k==
endfunction


function! split_join#join_front()
    s/\v(.*)\n(.*)/\2 \1
    call histdel("/", -1)
    normal! ==
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PRIVATE FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:get_input(cmd_input) abort
    if a:cmd_input == ''
        let input = nr2char(getchar())
    else
        let rg_expr = '\v/(.{-1,})/'
        let input = substitute(a:cmd_input, rg_expr, '\1', 'g')
        echomsg input
    endif

    return input
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
