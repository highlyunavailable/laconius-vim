" Set up paths for loading
let g:load_path = escape(fnamemodify(resolve(expand("<sfile>:p")), ":h"), ' ')

" Load pathogen
exe 'source ' . g:load_path . '\vim-pathogen\autoload\pathogen.vim'
execute pathogen#infect()
execute pathogen#helptags()

" Set colorscheme
set background=dark
colorscheme solarized

" Enable syntax highlighting
syntax enable

" Allow plugins to indent based on filetype
filetype plugin indent on

" Enable plugins for filetypes
filetype plugin on
