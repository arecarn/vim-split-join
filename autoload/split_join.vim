""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: WTFPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" * add visual mode mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpo = &cpo
set cpo&vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" GLOBALS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:error_tag = 'Split-Join error: '
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PUBLIC FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! split_join#split_cmd(count, first_line, last_line, input, bang) abort "{{{2
    try
            let input = s:get_input(a:input)
            if input.pattern == ''
                let input.pattern = @/
            endif
            let selection = selection#new(a:count, a:first_line, a:last_line)
            if selection.content == ''
                let selection = selection#new(1, line('.'), line('.'))
            endif

            let expr_list = split(selection.content, '\n', 1)
            let indent = matchstr(selection.content, '\v^\s*')

            if input.options ==# 'r'
                let expr_list = reverse(expr_list)
            endif

            if a:bang !=# "!"
                for i in range(len(expr_list))
                    let expr_list[i] = substitute(expr_list[i], input.pattern, '\n'.indent, 'g')
                endfor
            endif

            let expr_lines = join(expr_list, "\n")
            call selection.over_write(expr_lines)
    catch /Split-Join error: /
        call s:echo_error(v:exception)
    endtry
endfunction "}}}2


function! split_join#join_cmd(count, first_line, last_line, input, bang) abort "{{{2
    try
            let input = s:get_input(a:input)
            let selection = selection#new(a:count, a:first_line, a:last_line)
            if selection.content == ''
                let selection = selection#new(1, line('.'), line('.') + 1)
            endif

            let expr_list = split(selection.content, '\n', 0)


            let range = range(len(expr_list))
            call remove(range, 0)

            if input.options ==# 'r'
                let expr_list = reverse(expr_list)
            endif

            if a:bang !=# "!"
                for i in range
                    let expr_list[i] = substitute(expr_list[i], '\v^\s+|\s+$', '', 'g')
                endfor
            endif

            let expr_lines = join(expr_list, input.pattern)
            call selection.over_write(expr_lines)
    catch /Split-Join error: /
        call s:echo_error(v:exception)
    endtry
endfunction "}}}2


function! split_join#split(count) "{{{2
    for i in range(1, a:count)
        s/\v(.{-})(\s*)(%#)(\s*)(.*)/\1\r\3\5
        call histdel("/", -1)
        normal! ==
    endfor
    call repeat#set("\<Plug>(split-join-split)", a:count)
endfunction "}}}2


function! split_join#split_up(count) "{{{2
    for i  in range(1, a:count)
        s/\v(.{-})(\s*)(%#)(\s*)(.*)/\3\5\r\1
        call histdel("/", -1)
        normal! k==
    endfor
    call repeat#set("\<Plug>(split-join-split-up)", a:count)
endfunction "}}}2


function! split_join#join_front(count) "{{{2
    for i in range(1, a:count)
        s/\v(.*)\n(.*)/\2 \1
        call histdel("/", -1)
        normal! ==
    endfor
    call repeat#set("\<Plug>(split-join-join-front)", a:count)
endfunction "}}}2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PRIVATE FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:get_input(cmd_input) abort "{{{2
    let input = {}
    if a:cmd_input == ''
        let input.pattern = ' '
        let input.options = ''
    else

        let rg_expr = '\v\/(.{})\/(.{})?'

        if a:cmd_input !~ rg_expr
            call s:throw('invalid input')
        endif

        let input.pattern = substitute(a:cmd_input, rg_expr, '\1', 'g')
        let input.options = substitute(a:cmd_input, rg_expr, '\2', 'g')
    endif

    return input
endfunction "}}}2

function! s:echo_error(error_string) "{{{2
    echohl WarningMsg
    echomsg a:error_string
    echohl None
endfunction "}}}2

function!  s:throw(error_body) abort "{{{2
    let error_msg = s:error_tag.a:error_body
    throw error_msg
endfunction "}}}2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
