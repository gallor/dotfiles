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
Plugin 'tmhedberg/matchit' " Matching configuration for %
Plugin 'tpope/vim-git' "syntax, indent, and filetype plugin files for git, gitcommit, gitconfig, gitrebase, and gitsendemail
Plugin 'tpope/vim-fugitive' "Vim wrapper, allow for git viewing in airline
Plugin 'tpope/vim-surround' "provides mappings to easily delete, change and add surroundings like quotes, parenths etc
" Plugin 'plasticboy/vim-markdown' "Markdown support
Plugin 'davidoc/taskpaper.vim' "Taskpaper support
Plugin 'tpope/vim-commentary' " Simple commenting in vim 
Plugin 'scrooloose/nerdtree' "Tree navigation
Plugin 'Xuyuanp/nerdtree-git-plugin' "Nerdtree git tags for files support
Plugin 'scrooloose/syntastic' "Syntax check
Plugin 'majutsushi/tagbar' "Browse the tags of the current file and get an overview of its structure.
Plugin 'ctrlpvim/ctrlp.vim' "Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'bling/vim-airline' "Statusbar 
Plugin 'vim-airline/vim-airline-themes' "Airline themes
Plugin 'jiangmiao/auto-pairs' "Insert or delete brackets, parens, quotes in pair
Plugin 'Yggdroot/indentLine' "A vim plugin to display the indention levels with thin vertical lines
Plugin 'altercation/vim-colors-solarized' "Solarized color theme
Plugin 'chriskempson/vim-tomorrow-theme' "Tomorrow color theme
Plugin 'w0ng/vim-hybrid' "Hybrid Solarized, codecademy, Jellybeans, and Tomorrow-Night
"Plugin 'Valloric/YouCompleteMe' " Code completion 
"Plugin 'marijnh/tern_for_vim' "Vim tern usage, greatly improves YouCompleteMe JS use
Plugin 'elzr/vim-json' " JSON highlighting 
Plugin 'rking/ag.vim' " Advanced searching 
Plugin 'othree/yajs.vim' " ES6 syntax
" For JavaScript development
Plugin 'MaxMEllon/vim-jsx-pretty' "jsx syntax highlighting
Plugin 'pangloss/vim-javascript' "Javascript syntax highlighting
Plugin 'moll/vim-node' " Node js 
Plugin 'groenewege/vim-less' " Less syntax
Plugin 'othree/javascript-libraries-syntax.vim' " Javascript syntax library highlighting
Plugin 'othree/jspc.vim' " Javascript parameter completion
Plugin '1995eaton/vim-better-javascript-completion' " Expansion of vim's javascript syntax file for HTML5
"Plugin 'Shougo/neocomplete.vim' "code completiong

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
syntax sync minlines=200 " Syntax highlighting 200 lines instead of always from start
 
" -----------------------------------------------------------
" set color scheme
" -----------------------------------------------------------
set t_Co=256
set background=dark
colorscheme hybrid
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
" colorscheme Tomorrow-Night
"let g:solarized_termcolors=256
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE ctermfg=245
hi CursorLine ctermbg=234
hi NonText ctermbg=NONE
set synmaxcol=128
set term=xterm-256color
set termencoding=utf-8

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

" Easy bindings for its v arious modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


" -----------------------------------------------------------
" Vim JSON 
" -----------------------------------------------------------
"  Disable quote hiding
let g:vim_json_syntax_conceal = 0

" -----------------------------------------------------------
" Syntastic
" -----------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { "mode": "passive" }

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args = '--config /Users/gallor/.jshintrc'
nnoremap <leader>st :SyntasticToggle<CR><CR>
" -----------------------------------------------------------
" IndentLine
" -----------------------------------------------------------
let g:indentLine_color_term = 239 " Change Character color
let g:indentLine_char = '│'
let g:indentLine_indentLevel=5
let g:indentLine_faster = 1
let g:indentLine_noConcealCursor = ""

" -----------------------------------------------------------
" Neocomplete
" -----------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" -----------------------------------------------------------
" Airline Mods
" -----------------------------------------------------------
let g:airline_theme='sol'
let g:airline#extensions#tabline#enabled = 1 " Enable Vim Airline for list of buffers
let g:airline#extensions#whitespace#enabled = 0
let g:airline_detect_crypt = 1
let g:airline#extension#syntastic#enabled = 1 " Enable syntastic integration
let g:airline#extensions#branch#enabled = 1 " Enable git branch
" let g:airline#extensions#ycm#enabled = 1 " Enable YouCompleteMe errors and warnings
" let g:airline#extensions#ycm#error_symbol = 'E:' " YouCompleteMe error prefix
" let g:airline#extensions#ycm#warning_symbol = 'W:' " YouCompleteMe warning prefix


let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"


" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

function! AirlineInit()
    let g:airline_section_c = ''
    let g:airline_section_x = airline#section#create(['filetype','readonly'])
    let g:airline_section_y = airline#section#create_right(['file', '%l', '%L'])
    let g:airline_section_z = airline#section#create(['%{getcwd()}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
""let g:airline_section_b = airline#section#create(['%<%F'])

" -----------------------------------------------------------
" NerdTree
" -----------------------------------------------------------
map <leader>n :NERDTreeToggle<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Close vim if nerdtree is the last window open


" -----------------------------------------------------------
" TagBar
" -----------------------------------------------------------
nnoremap <F8> :TagbarToggle<CR>
" CtrlP tag searching 
nnoremap <leader>. :CtrlPTag<CR>
set tags=./tags;,tags;


" -----------------------------------------------------------
" Visual Updates
" -----------------------------------------------------------
filetype plugin indent on
set tabstop=4 " 4 spaces
set shiftwidth=4 " Indenting with '>', use 4 spaces
set softtabstop=4 " 4 spaces tabbing when in insert mode
set nojoinspaces " Unset join spaces
set splitright " Opening splits to right
set splitbelow " Opening spluts below
set synmaxcol=250 " Setting syntax highlighting to the first 250 columns. Helps with speed for long lines
set encoding=utf-8
set scrolloff=3 "Scrolling visual offset to three lines
set guifont=Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Mono:h11

set showmatch " Highlights the matching bracket/paren 
" hi MatchParen cterm=none ctermbg=green ctermfg=blue " to change the colors
" of the showmatch
set autoindent " Keep the same indent as the line you're currently on
set smartindent " Smart indents for new lines
set showmode " Show the current mode
set title " Show the filename in the window titlebar
set showcmd "Show the (partial) command as it's being typed
"set hidden " Hides buffers instead of closing them
set cmdheight=2 " Command window height to 2 lines
set mouse=a " Enable mouse

" Change highlighting of bracket matching. cterm can be none, bold or underline
hi MatchParen cterm=underline ctermbg=none ctermfg=none
set hlsearch

" -----------------------------------------------------------
" Vim Funtionality
" -----------------------------------------------------------
set iskeyword -=_ " Underscores denote words
set ttimeoutlen=100 "Set shorter timeout to disable esc key combination
set ttyfast " Optimize for fast terminal connections
set wildmenu " Better command-line completion
set wildmode=list:longest " List all matches and complete till longest
set gdefault " Add the g flag to search/replace by default
set autoread " force vim to reload files if differ on disk

" Don't add empty newlines at the end of files
set binary
set noeol

set expandtab " On pressing tab, insert 4 spaces. Has to be after set binary so expandtab is not reset

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

nnoremap <leader>pwd :echo @%<CR>
" -----------------------------------------------------------
" Key Remapping, Line Numbering
" -----------------------------------------------------------
" set lazyredraw " fixes horizontal scrolling with relativenumber on
" set relativenumber
set norelativenumber
set number
set nobackup
set noswapfile
"set undofile
"set backupdir=~/.tmp
"set spell

" Look up tag definition
" nnoremap <F3> :TernDef<CR>
" nnoremap <F4> :TernRefs<CR>

nnoremap ; :
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Toggle syntax on and off
nnoremap <leader>ts :syntax off<cr>:syntax on<cr>

" Checks if any buffers were changed outside of vim. set autoread resets them
nnoremap <F5> :checktime<CR>

" set wrap
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

" set textwidth=90
" set formatoptions=qrnt

set gfn="Inconsolata\ for\ Powerline":h11

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
	" Treat .scss files as css
	autocmd BufRead,BufNewFile *.scss set filetype=css syntax=css
	autocmd BufRead,BufNewFile *.less set filetype=css syntax=css
    autocmd FileType less set omnifunc=csscomplete#CompleteCSS
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " Set relative if enter buffer, or in visual/normal mode
    " autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    " Set absolute if leaving buffer or in insert mode
    " autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview
endif
