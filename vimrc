" vim:fdm=marker
" vim:set ft=vim et sw=2:
" vimrc

" Set encoding of file
scriptencoding utf-8

set nocompatible " Use vim, no vi defaults

if has('win32') || has ('win64')
    let $VIMHOME = $HOME . "/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" Set the backup and swap directories before running Vundle to prevent first
" time setup errors
set directory^=$VIMHOME/temp//      " where to put swap files.

filetype off " Turn off filetype plugins for Vundle

source $VIMHOME/vundle.vim

filetype plugin indent on " Turn on filetype plugins after Vundle is enabled

" Load matchit if an updated version is not present
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ========================================================================
" moving around, searching and patterns {{{1
" ========================================================================
set ignorecase
set incsearch
set smartcase

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
" ========================================================================
" tags {{{1
" ========================================================================
" ========================================================================
" displaying text {{{1
" ========================================================================

set display+=lastline

set cmdheight=2

set list      " Show invisible characters
set nowrap    " Don't wrap lines
set number    " Show line numbers
set ruler     " Show line and column number

if !&scrolloff
  set scrolloff=2
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
set showbreak=\¬\ \
" ========================================================================
" syntax, highlighting and spelling {{{1
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

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Set the Ruby filetype for a number of common Ruby files without .rb
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby

  " Set the Markdown filetype for all markdown files and set wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
  au FileType markdown setlocal wrap linebreak textwidth=72 nolist

  " Treat JSON files like JavaScript
  " au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
endif


" ========================================================================
" multiple windows {{{1
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

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" ========================================================================
" multiple tab pages {{{1
" ========================================================================
if &tabpagemax < 50
  set tabpagemax=50
endif
" ========================================================================
" terminal {{{1
" ========================================================================
set ttyfast
" ========================================================================
" using the mouse {{{1
" ========================================================================
" ========================================================================
" GUI {{{1
" ========================================================================
" ========================================================================
" printing {{{1
" ========================================================================
" ========================================================================
" messages and info {{{1
" ========================================================================
set showcmd
" ========================================================================
" selecting text {{{1
" ========================================================================
set clipboard=unnamed " Yank to the system clipboard by default
" ========================================================================
" editing text {{{1
" ========================================================================

set backspace=indent,eol,start " backspace through everything in insert mode
set complete-=i
set nrformats-=octal
" ========================================================================
" tabs and indenting {{{1
" ========================================================================

set autoindent
set expandtab                     " use spaces, not tabs
set shiftround
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set smarttab
set tabstop=2                     " a tab is two spaces
" ========================================================================
" folding {{{1
" ========================================================================

if has('folding')
  set nofoldenable " When opening files, all folds open by default
  set foldtext=NeatFoldText() " Use a custom foldtext function
endif

" ========================================================================
" diff mode {{{1
" ========================================================================

set diffopt+=vertical

" ========================================================================
" mapping {{{1
" ========================================================================
set ttimeout
set ttimeoutlen=100

source $VIMHOME/mapping.vim

" ========================================================================
" reading and writing files {{{1
" ========================================================================
set autoread
set fileformats+=mac

set backupdir^=$VIMHOME/backup//    " where to put backup files.

if has("autocmd")
  au FocusLost * silent! wall
endif

" ========================================================================
" the swap file {{{1
" ========================================================================
if exists('+undodir')
  set undodir^=$VIMHOME/undo//
endif
if exists('+undofile')
  set undofile
endif

" ========================================================================
" command line editing {{{1
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

" Add guard around 'wildignorecase' to prevent terminal vim error
if exists('&wildignorecase')
  set wildignorecase
endif

set wildmenu

" ========================================================================
" executing external commands {{{1
" ========================================================================
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
" ========================================================================
" running make and jumping to errors {{{1
" ========================================================================
" ========================================================================
" system specific {{{1
" ========================================================================
" ========================================================================
" language specific {{{1
" ========================================================================
" ========================================================================
" multi-byte characters {{{1
" ========================================================================

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" ========================================================================
" various {{{1
" ========================================================================
set sessionoptions-=options

if !empty(&viminfo)
  set viminfo^=!
endif
" ========================================================================

