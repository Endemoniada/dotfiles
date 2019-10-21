syntax on
set mouse=
"filetype off
set background=dark

" Fix backspace
set nocompatible
set backspace=indent,eol,start

" When there is a previous search pattern, highlight all its matches.
set hlsearch

set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital l

set laststatus=2								" always show status line

" Copy indent from current line when starting a new line.
set autoindent

" Do smart autoindenting when starting a new line.
set smartindent

" Four spaces looks nice when coding.
set softtabstop=4

" Number of spaces to use for each step of (auto)indent
" Looks best to match softtabstop.
set shiftwidth=4

" Use the appropriate number of spaces to insert a <Tab>
set expandtab

" Highlight whitespace(s) at the end of line.
autocmd VimEnter * :call matchadd('Error', '\s\+$', -1) | call matchadd('Error', '\%u00A0')

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'

Plug 'chriskempson/base16-vim'

" Initialize plugin system
call plug#end()

"let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme nord
colorscheme base16-tomorrow-night-eighties
"colorscheme base16-material-darker
"colorscheme base16-greenscreen
"colorscheme base16-eighties
