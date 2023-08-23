" -----------------------------------------------------------
" Plugins
" -----------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

"==== Editing ====="
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}} " JS Intellisense
Plug 'Shougo/echodoc.vim' " Print function signatures in echo area

Plug 'tpope/vim-repeat' " repeat support for vim-surround
Plug 'tpope/vim-surround' " change 'surroundings'
Plug 'tpope/vim-obsession' " save nvim session
Plug 'tpope/vim-eunuch' "Unix shell commands
Plug 'Raimondi/delimitMate' " Autoclosing
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'rizzatti/dash.vim' " dash documentation
Plug 'tmux-plugins/vim-tmux-focus-events' " Enable autoread for vim in tmux
Plug 'jremmen/vim-ripgrep' " search for words
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple Visual Mode
Plug 'sbdchd/neoformat' " Formatting code

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' " Fzf only if installed via homebrew
else
  Plug 'junegunn/fzf',  { 'do': { -> fzf#install() } } " Fuzzy file searching if not via homebrew
endif

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " Toggle the terminal

Plug 'junegunn/fzf.vim' " Fuzzy file searching
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins'}

"==== Git ====="
Plug 'tpope/vim-fugitive' " add git operation commands
Plug 'airblade/vim-gitgutter' " git signage in gutter

"==== Development ===="
Plug 'leafgarland/typescript-vim' " Typescript syntax
Plug 'pangloss/vim-javascript' " JS highlighting and indenting
Plug 'greatghoul/vim-web-indent'
Plug 'hashivim/vim-terraform' " Terraform support

"==== Syntax ===="
Plug 'dense-analysis/ale' " linting engine engine
Plug 'sheerun/vim-polyglot' " Syntax engine loads libraries only on demand,
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular' " tabular plugin is used to format tables
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Python syntax

"==== UI ===="
Plug 'cweagans/vim-taskpaper' " Taskpaper support
Plug 'kristijanhusak/vim-hybrid-material' " Light and dark theme based on hybrid
Plug 'w0ng/vim-hybrid' " colorscheme
Plug 'vim-scripts/summerfruit256.vim' " colorscheme
Plug 'crusoexia/vim-monokai' " colorschem
Plug 'Yggdroot/indentLine' " Indent line guides
Plug 'scrooloose/nerdcommenter' " commenting
Plug 'NLKNguyen/papercolor-theme' " colorscheme
Plug 'rakr/vim-two-firewatch' " colorscheme
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " Styled component syntax
Plug 'kyazdani42/nvim-web-devicons' " File icons for explorer
Plug 'kyazdani42/nvim-tree.lua' " File Explorer
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'nvim-lualine/lualine.nvim' " Status Line

"==== OrgMode ====="
Plug 'kristijanhusak/orgmode.nvim',

call plug#end()

