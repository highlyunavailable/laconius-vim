" Set up paths for loading
let g:load_path=escape(fnamemodify(resolve(expand("<sfile>:p")), ":h"), ' ')

" Load pathogen
exe 'source ' . g:load_path . '\vim-pathogen\autoload\pathogen.vim'
execute pathogen#infect()
execute pathogen#helptags()

" Set colorscheme
set background=dark
colorscheme solarized
