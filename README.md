split-join
==========

Usage
-----

| Mode   | Default Key | `<Plug>` map                    | Description                    |
| ------ | ----------- | ------------------------------- | ------------------------------ |
| normal | S           | `<Plug>(split-join-split)`      | Split a line                   |
| normal | CTRL-S      | `<Plug>(split-join-split-up)`   | Split a line upwards           |
| normal | CTRL-J      | `<Plug>(split-join-join-front)` | Join a to the fron of a line   |

* `:[range]Split[/{pattern}/]`
    * For each line in range replace spaces with newlines or the optional
      match. In the case that a {pattern} is supplied instead of replaces spaces
      matches to {pattern} are replaced with newlines.

* `:[range]Join[/{string}/]`
    * for each line in [range] newlines are removed and replaced with a space or
      the optional {string}.

Requirements
------------
* ![vim-repeat](https://github.com/tpope/vim-repeat)

Customization
-------------
Example:
```vim
let g:split_join_default_mapping = 0
nmap <leader>s <Plug>(split-join-split)
nmap <leader>su <Plug>(split-join-split-up)
nmap <leader>jf <Plug>(split-join-join-front)
```
