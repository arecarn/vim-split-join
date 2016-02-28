split-join
==========

Usage
-----
| Mode   | Key Mapping | Description                    |
| ------ | ----------- | ------------------------------ |
| normal | S           | Split a line                   |
| normal | CTRL-S      | Split a line upwards           |
| normal | CTRL-J      | Join a to the fron of a line   |

* `:[range]Split[!][/{pattern}/]`
    * For each line in range replace spaces with newlines or the optional
      match. In the case that a {pattern} is supplied instead of replaces spaces
      matches to {pattern} are replaced with newlines.

* `:[range]Join[!][/{string}/]`
    * for each line in [range] newlines are removed and replaced with a space or
      the optional {string}.


Requirements
------------
* [vim-repeat](https://github.com/tpope/vim-repeat)
