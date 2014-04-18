if has('win32') || has ('win64')
    let $VIMHOME = $HOME . "/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_readme=expand($VIMHOME . '/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent execute '!mkdir ' . $VIMHOME . '/bundle'
  silent execute '!git clone https://github.com/gmarik/vundle ' . $VIMHOME . '/bundle/vundle'
  let vundle_installed=0
endif

let &rtp.=',' . $VIMHOME . '/bundle/vundle/'
if has('win32') || has ('win64')
  let path=$VIMHOME . '/bundle/'
endif

call vundle#rc(path)
Plugin 'gmarik/vundle'
"Add your bundles here
Plugin 'Syntastic' "uber awesome syntax and errors highlighter
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
"...All your other bundles...
if vundle_installed == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif
" Setting up Vundle - the vim plugin bundler end

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif


" ========================================================================
"  1 important
" ========================================================================

set nocompatible " Use vim, no vi defaults

" ========================================================================
"  2 moving around, searching and patterns
" ========================================================================
set ignorecase  " searches are case insensitive...
set incsearch   " incremental searching
set smartcase   " ... unless they contain at least one capital letter

let s:default_path = escape(&path, '\ ') " store default value of 'path'

" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
" ========================================================================
"  3 tags
" ========================================================================
" ========================================================================
"  4 displaying text
" ========================================================================

set display+=lastline

set list      " Show invisible characters
set nowrap    " Don't wrap lines
set number    " Show line numbers
set ruler     " Show line and column number

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

syntax enable " Turn on syntax highlighting allowing local overrides

" List chars
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" string to put before wrapped screen lines
set showbreak=¬\ \
" ========================================================================
" 5 syntax, highlighting and spelling
" ========================================================================

if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

set background=dark

 " Use the Solarized colorscheme: http://ethanschoonover.com/solarized
" ignore colorscheme doesn't exist error if solarized isn't installed
silent! colorscheme solarized

if exists('+colorcolumn')
  set colorcolumn=80 " display a line in column 80 to show you
                     " where to line break.
endif

set hlsearch              " highlight matches
filetype plugin indent on " Turn on filetype plugins

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Set the Ruby filetype for a number of common Ruby files without .rb
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby

  " Set the Markdown filetype for all markdown files and set wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
  au FileType markdown setlocal wrap linebreak textwidth=72 nolist

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
endif


" ========================================================================
" 6 multiple windows
" ========================================================================

set laststatus=2  " always show the status bar

" Start the status line
set statusline=
set statusline+=b%-1.3n\ > " buffer number
set statusline+=\ %{fugitive#statusline()}:
set statusline+=\ %F
set statusline+=\ %M
set statusline+=%R
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=
set statusline+=\ %Y
set statusline+=\ <\ %{&fenc}
set statusline+=\ <\ %{&ff}
set statusline+=\ <\ %p%%
set statusline+=\ %l:
set statusline+=%02.3c " cursor line/total lines

if has("gui_running")
  if has("autocmd")
    " Automatically resize splits when resizing a GUI VIM window
    autocmd VimResized * wincmd =
  endif
endif


" ========================================================================
" 7 multiple tab pages
" ========================================================================
if &tabpagemax < 50
  set tabpagemax=50
endif
" ========================================================================
" 8 terminal
" ========================================================================
set ttyfast
" ========================================================================
" 9 using the mouse
" ========================================================================
" ========================================================================
" 10 GUI
" ========================================================================
" ========================================================================
" 11 printing
" ========================================================================
" ========================================================================
" 12 messages and info
" ========================================================================
set showcmd
" ========================================================================
" 13 selecting text
" ========================================================================
set clipboard=unnamed " Yank to the system clipboard by default
" ========================================================================
" 14 editing text
" ========================================================================

set backspace=indent,eol,start " backspace through everything in insert mode
set complete-=i
set nrformats-=octal
" ========================================================================
" 15 tabs and indenting
" ========================================================================

set autoindent
set expandtab                     " use spaces, not tabs
set shiftround
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set smarttab
set tabstop=2                     " a tab is two spaces
" ========================================================================
" 16 folding
" ========================================================================
" ========================================================================
" 17 diff mode
" ========================================================================
" ========================================================================
" 18 mapping
" ========================================================================
set ttimeout
set ttimeoutlen=100
""
"" General Mappings (Normal, Visual, Operator-pending)
""

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map alt-[ and alt-] to indenting or outdenting
" while keeping the original selection in visual mode
vmap <A-]> >gv
vmap <A-[> <gv

nmap <A-]> >>
nmap <A-[> <<

omap <A-]> >>
omap <A-[> <<

imap <A-]> <Esc>>>i
imap <A-[> <Esc><<i

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Map Control-# to switch tabs
map  <C-0> 0gt
imap <C-0> <Esc>0gt
map  <C-1> 1gt
imap <C-1> <Esc>1gt
map  <C-2> 2gt
imap <C-2> <Esc>2gt
map  <C-3> 3gt
imap <C-3> <Esc>3gt
map  <C-4> 4gt
imap <C-4> <Esc>4gt
map  <C-5> 5gt
imap <C-5> <Esc>5gt
map  <C-6> 6gt
imap <C-6> <Esc>6gt
map  <C-7> 7gt
imap <C-7> <Esc>7gt
map  <C-8> 8gt
imap <C-8> <Esc>8gt
map  <C-9> 9gt
imap <C-9> <Esc>9gt

inoremap <C-U> <C-G>u<C-U>


""
"" Command-Line Mappings
""

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"

" ========================================================================
" 19 reading and writing files
" ========================================================================
set autoread
set backupdir^=$VIMHOME/_backup//    " where to put backup files.
set fileformats+=mac

if has("autocmd")
  au FocusLost * silent! wall
endif

" ========================================================================
" 20 the swap file
" ========================================================================
set directory^=$VIMHOME/_temp//      " where to put swap files.

" ========================================================================
" 21 command line editing
" ========================================================================
if &history < 1000
  set history=1000
endif
" Display available files to tab to
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

set wildmenu

" ========================================================================
" 22 executing external commands
" ========================================================================
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
" ========================================================================
" 23 running make and jumping to errors
" ========================================================================
" ========================================================================
" 24 system specific
" ========================================================================
" ========================================================================
" 25 language specific
" ========================================================================
" ========================================================================
" 26 multi-byte characters
" ========================================================================

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" ========================================================================
" 27 various
" ========================================================================
set sessionoptions-=options

if !empty(&viminfo)
  set viminfo^=!
endif
" ========================================================================

" vim:set ft=vim et sw=2:
