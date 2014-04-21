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

" Cross-language plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'highlyunavailable/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-unimpaired'
Plugin 'ervandew/supertab'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mhinz/vim-startify'
Plugin 'HarnoRanaivo/vim-neatfoldtext'
Plugin 'Raimondi/delimitMate'
Plugin 'jelera/vim-javascript-syntax'

Plugin 'marijnh/tern_for_vim'

if executable('ag')
  Plugin 'rking/ag.vim'
endif

Plugin 'tmhedberg/matchit'

" VIML Plugins
Plugin 'ynkdir/vim-vimlparser'
Plugin 'syngan/vim-vimlint'

" Markdown Plugins
Plugin 'tpope/vim-markdown'

" JavaScript Plugins
Plugin 'pangloss/vim-javascript'

" JSON Plugins
Plugin 'elzr/vim-json'

" Coffeescript Plugins
Plugin 'kchmck/vim-coffee-script'

" Ruby Plugins
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'vim-ruby/vim-ruby'

" Chef Plugins
Plugin 'dougireton/vim-chef'

if s:vundle_installed == 0
  echo "Installing Bundles, please ignore key map error messages"
  :PluginInstall
endif
