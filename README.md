# A Vim Compiler for Pytest

Provides a compiler so that `:make` can run `pytest` and populate your quickfix
list appropriately.

Ostensibly this was to get [vim-dispatch] and [vim-test] to play nice with
`pytest`.

Based on [pytest-vim-compiler] by Whyme Lyu.

## Installation

For vim-plug:

```viml
Plug 'tartansandal/vim-compiler-pytest'
```

## Usage

Use `:compiler pytest` to set your current compiler to be `pytest`.
Then run `make` or any of its derivatives.

## License

MIT Licensed. See file LICENSE.

[pytest-vim-compiler]: https://github.com/5long/pytest-vim-compiler
[vim-dispatch]: https://github.com/tpope/vim-dispatch
[vim-test]: https://github.com/
