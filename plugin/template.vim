""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: WTFPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_split_join")
    finish
else
    let g:loaded_split_join = 1
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" GLOBALS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:split_join_default_mapping = get(g:, 'split_join_default_mapping', 1)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" COMMANDS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=* -range=0 -bang Split
    \ call split_join#split(<count>, <line1>, <line2>, <q-args>, '<bang>')

command! -nargs=* -range=0 -bang Join
    \ call split_join#join(<count>, <line1>, <line2>, <q-args>, '<bang>')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" MAPPINGS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:do_map(mode, lhs, rhs, name, default_option) abort "{{{2
    let plug = '<Plug>('.a:name.')'
    execute a:mode.'noremap <silent> '.plug.' '.a:rhs
    if a:default_option
        execute a:mode.'map <unique> '.a:lhs.' '.plug
    endif
endfunction "}}}2

call s:do_map(
            \ "n",
            \ "S",
            \ ":\<C-u>call split_join#split()\<CR>",
            \ "split-join-split",
            \ g:split_join_default_mapping,
            \ )

call s:do_map(
            \ "n",
            \ "\<C-s>",
            \ ":\<C-u>call split_join#split_up()\<CR>",
            \ "split-join-split-up",
            \ g:split_join_default_mapping,
            \ )

call s:do_map(
            \ "n",
            \ "\<C-j>",
            \ ":\<C-u>call split_join#join_front()\<CR>",
            \ "split-join-join-front",
            \ g:split_join_default_mapping,
            \ )
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
