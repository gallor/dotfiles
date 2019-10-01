" -----------------------------------------------------------
" Plugins
" -----------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

"==== Editing ====="
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}} " JS Intellisense
Plug 'Shougo/denite.nvim' " Fuzzy file searching
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim' " Fuzzy file searching
Plug 'Shougo/echodoc.vim' " Print function signatures in echo area
Plug 'easymotion/vim-easymotion' " Improved motion in Vim
" Plug 'rstacruz/vim-closer' " Autoclose plugin
Plug 'Raimondi/delimitMate' " insert mode auto completion
Plug 'tpope/vim-repeat' " repeat support for vim-surround
Plug 'tpope/vim-surround' " change 'surroundings'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " markdown preview support
" Plug 'jiangmiao/auto-pairs' " Autoclose plugin
Plug 'rizzatti/dash.vim' " dash documentation

" Tmux/Neovim movement integration
" Plug 'christoomey/vim-tmux-navigator'
"
" Snippet support
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
"
"==== Git ====="
Plug 'tpope/vim-fugitive' " add git operation commands
Plug 'airblade/vim-gitgutter' " git signage in gutter


"==== JS ===="
Plug 'HerringtonDarkholme/yats.vim' " Typescript syntax highlighting
Plug 'mxw/vim-jsx' " ReactJS JSX syntax highlighting
Plug 'heavenshell/vim-jsdoc' " Generate JSDoc commands based on function signature
Plug 'pangloss/vim-javascript' " JS highlighting
" Plug 'othree/javascript-libraries-syntax.vim' " Syntax highlighting for javascript libraries
" Plug 'othree/yajs.vim' " Improved syntax highlighting and indentation

"==== Syntax ===="
Plug 'w0rp/ale' " linting engine engine
Plug 'sheerun/vim-polyglot' " Syntax engine loads libraries only on demand,

"==== UI ===="
Plug 'micke/vim-hybrid'
Plug 'crusoexia/vim-monokai'
Plug 'scrooloose/nerdtree' " File explorer
Plug 'scrooloose/nerdcommenter' " commenting
"
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
" Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

