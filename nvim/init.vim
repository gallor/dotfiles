scriptencoding utf-8
set encoding=utf-8

let g:polyglot_disabled = ['python']
set termguicolors " enable 256 colors in iterm
source ~/.config/nvim/plugins.vim
let mapleader = "," " change mapleader from \ to ,

syntax on " Enable syntax highlighting
syntax sync minlines=200 " Syntax highlighting 200 lines instead of always from start

" -----------------------------------------------------------
" color settings
" -----------------------------------------------------------
set t_Co=256 " enable 256 colors in non-iterm terminal

" Enable True colors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" JS syntax highlighting
hi def link jsObjectKey Structure
hi def link jsObjectProp Tag

" colorscheme hybrid_material
colorscheme PaperColor
highlight clear SignColumn
set background=light

set synmaxcol=128
set termencoding=utf-8

" -----------------------------------------------------------
" Block for Command mode, underscore for insert
" -----------------------------------------------------------
let &t_SI = "\<Esc>]50;CursorShape=2\x7" " Underscore in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

" -----------------------------------------------------------
" Visual Updates
" -----------------------------------------------------------
filetype on " Enable file type detection
filetype plugin indent on " Enable filetype indentation
set tabstop=2 " 2 spaces
set shiftwidth=2 " Indenting with '>', use 2 spaces
set softtabstop=2 " 2 spaces tabbing when in insert mode
set expandtab " On pressing tab, insert 4 spaces. Has to be after set binary so expandtab is not reset
set autoindent " Keep the same indent as the line you're currently on
set smartindent " Smart indents for new lines
set nojoinspaces " Unset join spaces
set splitright " Opening splits to right
set splitbelow " Opening splits below
set synmaxcol=250 " Setting syntax highlighting to the first 250 columns. Helps with speed for long lines
set scrolloff=3 "Scrolling visual offset to three lines
set guifont=InconsolataGo\ Nerd\ Font\ Complete:h11

" set showmatch " Highlights the matching bracket/paren
" hi MatchParen cterm=none ctermbg=green ctermfg=blue " to change the colors
" of the showmatch
set noshowmode " Don't show mode, airlien already shows it
set title " Show the filename in the window titlebar
set showcmd "Show the (partial) command as it's being typed
set hidden " Hides buffers instead of closing them
set cmdheight=2 " Command window height to 2 lines
set mouse=a " Enable mouse
set signcolumn=yes " aloways show signcolumns

" Change highlighting of bracket matching. cterm can be none, bold or underline
hi MatchParen cterm=underline ctermbg=none ctermfg=none
set hlsearch

" -----------------------------------------------------------
" Vim Funtionality
" -----------------------------------------------------------
set iskeyword -=_ " Underscores denote words
set ttimeoutlen=50 "Set shorter timeout to disable esc key combination
set ttyfast " Optimize for fast terminal connections
set wildmenu " Better command-line completion
set wildmode=list:longest " List all matches and complete till longest
set gdefault " Add the g flag to search/replace by default
set autoread " force vim to reload files if differ on disk
set updatetime=100 " time to write to swap file. improve experience for diagnostic messages
" Don't add empty newlines at the end of files
set binary
set noeol

set backspace=indent,eol,start " Backspace over autoindent, line breaks, and start of insert
set laststatus=2 " Always show status line
set shortmess=atI " Don't show the intro message when starting vim
set shortmess+=c " Don't give ins-completion-menu messages
"
" Very magic search mode all non [0-9] and [A-Z] must be escaped and case sensitive
" nnoremap / /\v\C
" vnoremap / /\v\C

set nofoldenable " disable folding on startup
set ignorecase " case insensitive search, except when using capital letters
set smartcase " if the search string has an upper case letter in it, the search will be case sensitive
set confirm " if the search string has an upper case letter in it, the search will be case sensitive
set incsearch " Searches are redefined as search term is typed

" t - autowrap text
" c - autowrap comments
" j - remove comment leader when makes sense
" q - allow formatting of comments using 'gq'
" l - long lines are not broken in insert mode
set formatoptions=tcjql

set iskeyword+=_ " count underscore as part of the word

" Set backups
" if has('persistent_undo')
"   set undofile
"   set undolevels=3000
"   set undoreload=10000
" endif
" set backup
" set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
" set noswapfile
" Some coc servers have problems with backups
set nobackup
set nowritebackup

" -----------------------------------------------------------
" Key Remapping, Line Numbering
" -----------------------------------------------------------
nnoremap ; :
set lazyredraw " fixes horizontal scrolling with relativenumber on
set relativenumber
set number

nnoremap <silent> <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Checks if any buffers were changed outside of vim. set autoread resets them
nnoremap <F5> :checktime<CR>

" set wrap
set wrap
set linebreak
set textwidth=90
set wrapmargin=0

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
vnoremap j gj
vnoremap k gk
nnoremap <S-4> g$
nnoremap <S-6> g^

" Exit terminal input mode
au TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
au FileType fzf tunmap <buffer> <ESC>

" Create new horizontal split with terminal
nnoremap <C-q> :30sp<cr>:term<cr>i
" Create and switch to it vertical split
nnoremap <C-\> <C-w>v<C-w>l
" Create and switch to it horizontal split
nnoremap <C--> :sp<C-w>j

" Remaps C-h/j/k/l to move around in the splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap buffer commands
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprev<cr>
nnoremap <leader>bq :bp <BAR> bd #<cr>
nnoremap <leader>bl :ls<cr>

" Close all open buffers save the last one
nnoremap <leader>bc :%bd\|e#<cr>

" Makes </ auto close HTML tag
" iabbrev </ </C-X><C-o>

" Shortcuts to open vimrc and plugin files
nnoremap <leader>vrc :e $HOME/.config/nvim/init.vim<cr>

" -----------------------------------------------------------
" VimDiff
" -----------------------------------------------------------
:set diffopt+=iwhite

" -----------------------------------------------------------
" Functions
" -----------------------------------------------------------
function LightColor()
  set background=light
  colorscheme PaperColor
	highlight clear SignColumn
endfunction

function DarkColor()
  set background=dark
  colorscheme hybrid_material
	highlight clear SignColumn
endfunction

" Strip Trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos('.')
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
nnoremap <leader>ss :call StripWhitespace()<CR>

function Foldsyn()
  set foldmethod=syntax
endfunction
function FoldIndent()
  set foldmethod=indent
endfunction
nnoremap <leader>zs :call Foldsyn()<CR>
nnoremap <leader>zi :call FoldIndent()<CR>

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <leader>sp :call <SID>SynStack()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
    autocmd FocusLost * silent! wa " Auto save buffers when focus is moved
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart " rescans for syntax on buffers for large tsx files
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear " stops rescans on leave for tsx files
    autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown textwidth=0
    autocmd BufNewFile,BufRead *.taskpaper setlocal filetype=taskpaper textwidth=0 fo-=t
    autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=Dockerfile textwidth=0
    autocmd FileType Dockerfile set textwidth=0
    autocmd BufNewFile,BufRead *.hcl setlocal filetype=terraform textwidth=0
    autocmd FileType terraform set textwidth=0
    autocmd BufNewFile,BufRead *.py3 setlocal filetype=python textwidth=0
    autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4 fo=cjql

    " Set relative if enter buffer, or in visual/normal mode
    " autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufEnter * call s:quit_current_win()
    " Set absolute if leaving buffer or in insert mode
    " autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    "autocmd BufWinLeave *.* mkview
    "autocmd BufWinEnter *.* silent loadview
endif

" Quit Nvim if we have only one window, and its filetype match our pattern
function! s:quit_current_win() abort
  let l:quit_filetypes = ['NvimTree']

  let l:should_quit = v:true

  let l:tabwins = nvim_tabpage_list_wins(0)
  for w in l:tabwins
    let l:buf = nvim_win_get_buf(w)
    let l:bf = getbufvar(l:buf, '&filetype')

    if index(l:quit_filetypes, l:bf) == -1
      let l:should_quit = v:false
    endif
  endfor

  if l:should_quit
    qall
  endif
endfunction

" Add a Remove command
command! -complete=file -nargs=1 Trash :echo 'Trash: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

try
source ~/.config/nvim/pluginSettings.vim
catch
    echo "Plugins didn't work" . v:exception
endtry
