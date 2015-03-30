let s:vundle_installed=1
let s:vundle_readme=expand($VIMHOME . '/bundle/vundle/README.md')
if !filereadable(s:vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent execute '!mkdir ' . $VIMHOME . '/bundle'
  silent execute '!git clone https://github.com/gmarik/vundle ' 
        \ . $VIMHOME . '/bundle/vundle'
  let s:vundle_installed=0
endif

let &rtp.=',' . $VIMHOME . '/bundle/vundle/'
let s:path=$VIMHOME . '/bundle/'

call vundle#rc(s:path)
Plugin 'gmarik/vundle'

" Syntax Highlighting
Plugin 'chriskempson/base16-vim'

" Syntax checking/linting
Plugin 'scrooloose/syntastic'
Plugin 'bronson/vim-trailing-whitespace'

" Git
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'

" Text alignment
Plugin 'godlygeek/tabular'

" File browsing
Plugin 'scrooloose/nerdtree'

" Autocomplete
Plugin 'tpope/vim-surround'

" Code comments
Plugin 'scrooloose/nerdcommenter'

" Mappings/tab completion
Plugin 'tpope/vim-unimpaired'
Plugin 'Valloric/YouCompleteMe', {'pinned': 1 }
Plugin 'mhinz/vim-startify'
Plugin 'HarnoRanaivo/vim-neatfoldtext'

if executable('ag')
  Plugin 'rking/ag.vim'
endif

Plugin 'tmhedberg/matchit'

" VIML Plugins
Plugin 'ynkdir/vim-vimlparser'
Plugin 'syngan/vim-vimlint'

" Javascript
Plugin 'marijnh/tern_for_vim'
Plugin 'jelera/vim-javascript-syntax'

" Salt plugins
Plugin 'saltstack/salt-vim'
Plugin 'Jinja'
let g:sls_use_jinja_syntax = 1

" Python
Plugin 'davidhalter/jedi-vim'

" Powershell Plugins
Plugin 'PProvost/vim-ps1'

" Markdown Plugins
Plugin 'tpope/vim-markdown'

" Go plugins
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}

if s:vundle_installed == 0
  echo "Installing Bundles, please ignore key map error messages"
  :PluginInstall
endif
