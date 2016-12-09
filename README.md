split-join
==========

Usage
-----
| Mode   | Key Mapping | Description                    |
| ------ | ----------- | ------------------------------ |
| normal | S           | Split a line                   |
| normal | CTRL-S      | Split a line upwards           |
| normal | CTRL-J      | Join a to the fron of a line   |

* `:[range]Split[!][/{pattern}/[flags]]`
    * For each line in [range] replace spaces or matches to {pattern} with
      newlines and the leading spaces of the first item. When [!] is added the
      leading spaces of the first item are not inserted.

* `:[range]Join[!][/{string}/[flags]]`
    * For each line in [range] leading spaces and newlines are replaced with a
      single space or the optional {string}. When [!] is added the leading
      spaces of the first item are preserved.

Requirements
------------
* [vim-repeat](https://github.com/tpope/vim-repeat)
