" -----------------------------------------------------------
" use Vim settings rather than vi settings must be first
" -----------------------------------------------------------
set nocompatible

"  -----------------------------------------------------------
" Vundle package manager
" -----------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " Plugin Management
"Plugin 'tmhedberg/matchit' " Matching configuration for %
"Plugin 'SuperTab' "Allows you to use <Tab> for all your insert completion needs
"Plugin 'godlygeek/tabular' "Line up text
Plugin 'pangloss/vim-javascript' "Javascript syntax highlighting
"Plugin 'tpope/vim-surround' "provides mappings to easily delete, change and add surroundings like quotes, parenths etc
Plugin 'tpope/vim-fugitive' "Vim wrapper, allow for git viewing in airline
"Plugin 'tpope/vim-git' "syntax, indent, and filetype plugin files for git, gitcommit, gitconfig, gitrebase, and gitsendemail
"Plugin 'plasticboy/vim-markdown' "Markdown support
Plugin 'davidoc/taskpaper.vim' "Taskpaper support
"Plugin 'scrooloose/nerdcommenter' "Lots of commenting
Plugin 'scrooloose/nerdtree' "Tree navigation
Plugin 'Xuyuanp/nerdtree-git-plugin' "Nerdtree git tags for files support
Plugin 'scrooloose/syntastic' "Syntax check
"Plugin 'mileszs/ack.vim' "Enhanced searching
Plugin 'majutsushi/tagbar' "Browse the tags of the current file and get an overview of its structure.
"Plugin 'flazz/vim-colorschemes' "One colorscheme pack to rule them all!
"Plugin 'myusuf3/numbers.vim' "Intelligently toggling line numbers
"Plugin 'ctrlpvim/ctrlp.vim' "Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'bling/vim-airline' "Statusbar
"Plugin 'Shougo/neocomplete.vim' "Provides keyword completion system by maintaining a cache of keywords in the current buffer
Plugin 'jiangmiao/auto-pairs' "Insert or delete brackets, parens, quotes in pair
Plugin 'Yggdroot/indentLine' "A vim plugin to display the indention levels with thin vertical lines
Plugin 'altercation/vim-colors-solarized' "Solarized color theme
Plugin 'chriskempson/vim-tomorrow-theme' "Tomorrow color theme
Plugin 'w0ng/vim-hybrid' "Hybrid Solarized, codecademy, Jellybeans, and Tomorrow-Night

call vundle#end()
" -----------------------------------------------------------
"  Allow intelligent auot-indenting for each filetype and for
"  plugins that are filetype specific
" -----------------------------------------------------------
filetype indent plugin on

" -----------------------------------------------------------
" change mapleader from \ to ,
" -----------------------------------------------------------
let mapleader = ","

" -----------------------------------------------------------
"  Enable syntax highlighting
" -----------------------------------------------------------
syntax on

" -----------------------------------------------------------
" set color scheme
" -----------------------------------------------------------
set t_Co=256
"let g:solarized_termcolors=256
set background=dark
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi NonText ctermbg=NONE
set cursorline
hi CursorLine ctermbg=234
colorscheme Tomorrow-Night

" For Hybrid ColorScheme
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
" colorscheme hybrid

" -----------------------------------------------------------
" Allow saving if file needs sudo priv after opening
" -----------------------------------------------------------
cmap w!! w !sudo tee % >/dev/null

" -----------------------------------------------------------
" Disable modeline support
" -----------------------------------------------------------
set modelines=0

" -----------------------------------------------------------
" Block for Command mode, underscore for insert
" -----------------------------------------------------------
let &t_SI = "\<Esc>]50;CursorShape=2\x7" " Underscore in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

" -----------------------------------------------------------
" CtrlP Settings
" -----------------------------------------------------------
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(class|png|jpg|jpeg|DS_STORE)$',
  \}
" Use the nearest git directory as cwd
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nnoremap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" -----------------------------------------------------------
" IndentLine
" -----------------------------------------------------------
let g:indentLine_color_term = 239 " Change Character color
let g:indentLine_char = '│'

" -----------------------------------------------------------
" Airline Mods
" -----------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1 " Enable Vim Airline for list of buffers
"let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename of buffer
let g:airline_detect_crypt = 1
let g:airline#extension#syntastic#enabled = 1 " Enable syntastic integration
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled=0
" if !exists('g:airline_symbols')
"	let g:airline_symbols = {}
" endif
" let g:airline_right_sep =''
" let g:airline_left_sep =''
" let g:airline_symbols.branch = '⎇ '

let g:airline_section_a = airline#section#create(['mode',' ','branch'])
let g:airline_section_b = airline#section#create(['%<%F'])
let g:airline_section_c = airline#section#create(['filetype','readonly'])
let g:airline_section_x = 0
let g:airline_section_y = 0
let g:airline_section_z = airline#section#create(['%{getcwd()}'])

" -----------------------------------------------------------
" NerdTree
" -----------------------------------------------------------
map <leader>n :NERDTreeToggle<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Close vim if nerdtree is the last window open

" -----------------------------------------------------------
" TagBar
" -----------------------------------------------------------
nmap <leader>t :TagbarToggle<CR>

" -----------------------------------------------------------
" Visual Updates
" -----------------------------------------------------------
filetype plugin indent on
set tabstop=4 " 4 spaces
set shiftwidth=4 " Indenting with '>', use 4 spaces
set expandtab " On pressing tab, insert 4 spaces
set softtabstop=4 " 4 spaces tabbing when in insert mode
set nojoinspaces " Unset join spaces
set splitright " Opening splits to right
set splitbelow " Opening spluts below
set synmaxcol=250 " Setting syntax highlighting to the first 250 columns. Helps with speed for long lines
set encoding=utf-8
set scrolloff=3 "Scrolling visual offset to three lines

set autoindent " Keep the same indent as the line you're currently on
set smartindent " Smart indents for new lines
set showmode " Show the current mode
set title " Show the filename in the window titlebar
set showcmd "Show the (partial) command as it's being typed
set hidden " Hides buffers instead of closing them
set cmdheight=2 " Command window height to 2 lines
set mouse=a " Enable mouse

" Change highlighting of bracket matching. cterm can be none, bold or underline
hi MatchParen cterm=underline ctermbg=none ctermfg=none
set hlsearch

" -----------------------------------------------------------
" Vim Funtionality
" -----------------------------------------------------------
set noesckeys " Disable Escape keys in insert mode
set ttimeoutlen=100 "Set shorter timeout to disable esc key combination
set ttyfast " Optimize for fast terminal connections
set wildmenu " Better command-line completion
set wildmode=list:longest " List all matches and complete till longest
set gdefault " Add the g flag to search/replace by default

" Don't add empty newlines at the end of files
set binary
set noeol

set visualbell
"set cursorline
set backspace=indent,eol,start " Backspace over autoindent, line breaks, and start of insert
set laststatus=2 " Always show status line
set shortmess=atI " Don't show the intro message when starting vim
"
" Very magic search mode all non [0-9] and [A-Z] must be escaped
nnoremap / /\v
vnoremap / /\v

" case insensitive search, except when using capital letters
set ignorecase
set smartcase
set confirm " Dialogue aksing if you wish to save changed files

set incsearch " Searches are redefined as search term is typed

" -----------------------------------------------------------
" Key Remapping, Line Numbering
" -----------------------------------------------------------
set relativenumber
set number
set nobackup
set noswapfile
"set undofile
"set backupdir=~/.tmp
"set spell

nnoremap ; :
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Toggle syntax on and off
nnoremap <leader>ts :syntax off<cr>:syntax on<cr>

" set wrap
set textwidth=90
set formatoptions=qrnt
"set colorcolumn=95

set gfn=Consolas:h11

"set list
"set listchars=tab:▸\ ,eol:¬

" Disable arrow navigation
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Create new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>1

" Remaps C-h/j/k/l to move around in the splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap buffer commands
nnoremap <leader>t :enew<cr>
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprev<cr>
nnoremap <leader>bq :bp <BAR> bd #<cr>
nnoremap <leader>bl :ls<cr>

" Makes </ auto close HTML tag
iabbrev </ </C-X><C-o>

" Unsets last search pattern by hitting enter
nnoremap <CR> :noh<CR><CR>

" Strip Trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos('.')
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif