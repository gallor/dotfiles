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

Plugin 'gmarik/Vundle.vim'
Plugin 'surround.vim'
Plugin 'tmhedberg/matchit'
Plugin 'SuperTab'
Plugin 'Tabular'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'Markdown'
Plugin 'repeat.vim'
Plugin 'davidoc/taskpaper.vim'
Plugin 'neocomplcache'
Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
Plugin 'Syntastic'
Plugin 'ack.vim'
Plugin 'Tagbar'
Plugin 'flazz/vim-colorschemes'
Plugin 'myusuf3/numbers.vim'
Plugin 'ctrlp.vim'
Plugin 'wincent/command-t'
Plugin 'sudo.vim'

call vundle#end()
filetype plugin indent on

" -----------------------------------------------------------
"  Allow intelligent auot-indenting for each filetype and for 
"  plugins that are filetype specific
" -----------------------------------------------------------
filetype indent plugin on

" -----------------------------------------------------------
"  Enable syntax highlighting
" -----------------------------------------------------------
filetype on
syntax on

"  -----------------------------------------------------------
" setup Pathoden to manage plugins
" -----------------------------------------------------------
" call pathogen#infect()
" call pathogen#helptags()
" filetype plugin indent on

" -----------------------------------------------------------
" change mapleader from \ to ,
" -----------------------------------------------------------
let mapleader = ","

" -----------------------------------------------------------
" set color scheme
" -----------------------------------------------------------
set t_Co=256
colorscheme codeschool
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi NonText ctermbg=NONE

" -----------------------------------------------------------
" Allow saving if file needs sudo priv after opening
" -----------------------------------------------------------
cmap w!! w !sudo tee % >/dev/null

" -----------------------------------------------------------
" Remap ; to :
" -----------------------------------------------------------
nnoremap ; :
set modelines=0

" -----------------------------------------------------------
" Block for Command mode, underscore for insert 
" -----------------------------------------------------------
let &t_SI = "\<Esc>]50;CursorShape=2\x7" 
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab 
set nojoinspaces
set splitright
set splitbelow

set encoding=utf-8
set scrolloff=3

" Keep the same indent as the line you're currently on
set autoindent 
set smartindent

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

"Show the (partial) command as it's being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3

set hidden

" Optimize for fast terminal connections
set ttyfast

" Better command-line completion
set wildmenu

" Add the g flag to search/replace by default
set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Don't add empty newlines at the end of files
set binary
set noeol

set wildmode=list:longest
set visualbell
"set cursorline
set ruler
set backspace=indent,eol,start

" Always show status line
set laststatus=2

" Don't show the intro message when starting vim
set shortmess=atI

set relativenumber
set number
set nobackup
set noswapfile
"set undofile
"set backupdir=~/.tmp
"set spell

nnoremap / /\v
vnoremap / /\v

" case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Dialogue aksing if you wish to save changed files
set confirm

" Enable mouse
set mouse=a

" Command window height to 2 lines
set cmdheight=2

set gdefault
set incsearch

" Bracket highlight matching
set showmatch

" Change highlighting of bracket matching. cterm can be none, bold or underline
hi MatchParen cterm=none ctermbg=white ctermfg=black
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" set wrap
set textwidth=90
set formatoptions=qrn1
"set colorcolumn=95

set gfn=Consolas:h11

"set list
"set listchars=tab:▸\ ,eol:¬

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

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

au FocusLost * :wa

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+//<cr>:let @/=''<CR>

" Fold tag leader
nnoremap <leader>ft Vatzf

" Exit insert mode
"inoremap jj <ESC>

" Create new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>1

" Remaps C-h/j/k/l to move around in the splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>;

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
