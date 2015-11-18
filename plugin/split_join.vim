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
    \ call split_join#split_cmd(<count>, <line1>, <line2>, <q-args>, '<bang>')

command! -nargs=* -range=0 -bang Join
    \ call split_join#join_cmd(<count>, <line1>, <line2>, <q-args>, '<bang>')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" MAPPINGS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:do_map(name, lhs, rhs, mode, default_option) abort "{{{2
    let plug = '<Plug>('.a:name.')'
    execute a:mode.'noremap <silent> '.plug.' '.a:rhs
    if a:default_option
        execute a:mode.'map <unique> '.a:lhs.' '.plug
    endif
endfunction "}}}2

call s:do_map(
            \ "split-join-split",
            \ "S",
            \ ":\<C-u>call split_join#split()\<CR>",
            \ "n",
            \ g:split_join_default_mapping,
            \ )

call s:do_map(
            \ "split-join-split-up",
            \ "\<C-s>",
            \ ":\<C-u>call split_join#split_up()\<CR>",
            \ "n",
            \ g:split_join_default_mapping,
            \ )

" The mapping function can't set the default mapping without producing an
" error, so we do it manually. This is because "\<C-j>" is expanding to ^@ or
" (null) see more here:
" http://vi.stackexchange.com/questions/5233/strange-behavior-of-ctrl-j-remapping
call s:do_map(
            \ "split-join-join-front",
            \ "\<C-j>",
            \ ":\<C-u>call split_join#join_front()\<CR>",
            \ "n",
            \ 0,
            \ )
if g:split_join_default_mapping
    nmap <C-j> <Plug>(split-join-join-front)
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
