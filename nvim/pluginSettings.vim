" -----------------------------------------------------------
" FZF
" -----------------------------------------------------------
let g:fzf_command_prefix = 'Fzf'
nnoremap <Leader>p :FzfBuffers<CR>
nnoremap <Leader>e :FzfHistory<CR>
nnoremap <Leader>t :FzfBTags<CR>
nnoremap <Leader>T :FzfTags<CR>
" Have FZF list all tracked files plus untracked files minus your ignored files
nnoremap <Leader>rg :Find<CR>
nnoremap <Leader>rf :FindWithWord<CR>
nnoremap <Leader>P :Files<CR>

let g:fzf_layout = { 'down': '~20%' }

nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':FzfFiles' : ':FzfGFiles --exclude-standard --others --cached')."\<CR>"

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find 
  \ call fzf#vim#grep(
  \    'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow 
  \    --glob "!.git/*" --color "always" --glob "!*.lock"
  \    --colors "match:bg:222,95,53" --colors "line:style:bold" --colors "path:fg:green" --colors "path:style:bold" 
  \    --colors "line:fg:yellow" '.shellescape(<q-args>), 1,
  \    fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* FindWithWord
  \ call fzf#vim#grep(
  \    'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" 
  \    --colors "match:bg:222,95,53" --colors "line:style:bold" --colors "path:fg:green" --colors "path:style:bold" 
  \    --colors "line:fg:yellow" '.shellescape(expand("<cword>")), 1,
  \    fzf#vim#with_preview(), <bang>0)
" Files with preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Floatin fzf window
let $FZF_DEFAULT_OPTS='--layout=reverse'

" -----------------------------------------------------------
" Coc - https://github.com/neoclide/coc.nvim
" -----------------------------------------------------------
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-actions',
  \ 'coc-prettier'
  \ ]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <C-cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if coc#float#has_float()
    call coc#float#has_float()
  elseif (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Fix autofix problem of current line
nmap <leader>cf <Plug>(coc-fix-current)

" Remap for codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

xmap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>ca :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Automatically installs and uses coc-eslint if eslint exists in the node modules
" if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"   let g:coc_global_extensions += ['coc-eslint']
" endif
" 
" if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
"   let g:coc_global_extensions += ['coc-prettier']
" endif


" -----------------------------------------------------------
" Airline
" -----------------------------------------------------------
let g:airline_extensions = ['branch', 'coc', 'ale', 'tabline', 'whitespace']
let g:airline_skip_empty_sections = 1

let g:airline#extensions#branch#format = 2
" let g:airline_theme='base16_twilight'
let g:airline#extensions#ale#enabled = 1 " Ale enabled
let g:airline#extensions#tabline#enabled = 1 " Enable Vim Airline for list of buffers
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#formatter = 'short_path'
" let g:airline#extensions#whitespace#enabled = 1
let g:airline_detect_crypt = 1
" let g:airline#extension#syntastic#enabled = 1 " Enable syntastic integration
" let g:airline#extensions#branch#enabled = 1 " Enable git branch
let g:airline#extensions#coc#enabled = 1 " Enable Coc
let g:airline#extensions#hunks#enabled = 0 " Enable git hunk
" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Do not draw separators for empty sections (only for the active window) >
" let g:airline_skip_empty_sections = 1

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Hide the Nerdtree status line to avoid clutter
let g:NERDTreeStatusline = ''

" Disable vim-airline in preview mode
let g:airline_exclude_preview = 1
" Enable powerline font support
let g:airline_powerline_fonts = 1
" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_symbols.branch = ''

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create(['branch'])
    " let g:airline_section_b = airline#section#create(['hunks', 'branch'])
    " let g:airline_section_c = '%{getcwd()}'
    let g:airline_section_c = '%F'
    let g:airline_section_x = airline#section#create(['filetype','readonly'])
    let g:airline_section_y = airline#section#create_right(['file', '%l', '%L'])
    let g:airline_section_z = ''
    let g:airline_section_warning = ''
endfunction
autocmd User AirlineAfterInit call AirlineInit()
""let g:airline_section_b = airline#section#create(['%<%F'])

" let g:airline_skip_empty_sections = 1
" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" -----------------------------------------------------------
" Nerdtree
" -----------------------------------------------------------
" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Show hidden files/directories
let g:NERDTreeShowHidden=1

" Hide Line Numbers
let g:NERDTreeShowLineNumbers=1
" autocmd BufEnter NERD_* setlocal nornu

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI=1

" Automatically delete buffer of the file just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Custom icons for expandable/expanded directories
" let g:NERDTreeDirArrowExpandable = '⬏'
" let g:NERDTreeDirArrowCollapsible = '⬎'

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Close vim if NERDtree is only buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$', '\.vscode$']


" -----------------------------------------------------------
" Nerd Commenter
" -----------------------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" -----------------------------------------------------------
" Vim Javascript
" -----------------------------------------------------------
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" -----------------------------------------------------------
" Syntax and Syntastic
" -----------------------------------------------------------
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 1
"
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" -----------------------------------------------------------
" Additional Key mappings 
" -----------------------------------------------------------
" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>w <Plug>(easymotion-bd-w)

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" -----------------------------------------------------------
" MISC
" -----------------------------------------------------------
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -----------------------------------------------------------
" ALE
" -----------------------------------------------------------
let g:ale_disable_lsp = 1 " Disables language server since integrating with Coc
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
hi ALEErrorSign ctermbg=NONE ctermfg=red guifg=red
hi ALEWarningSign ctermbg=NONE ctermfg=yellow guifg=yellow
if g:colors_name == 'monokai'
  hi ALEErrorSign guibg=#303030 
  hi ALEWarningSign guibg=#303030
endif

" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['eslint'],
" \}
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'sh': ['language_server'],
" \}

let g:ale_sign_column_always = 1 " keep the sign gutter on all the time
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign<Paste>
nmap <silent> [l <Plug>(ale_previous_wrap)
nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l :lprevious<CR>
nmap <silent> ]l :lnext<CR>
nmap <silent> <leader>[l :lopen<CR>
nmap <silent> <leader>]l :lclose<CR>

let g:ale_lint_on_text_changed = 'never' " run linter on save

" Close loclist automatically when buffer is closed
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" let g:ale_open_list = 1

" -----------------------------------------------------------
" GitGutter
" -----------------------------------------------------------
let g:gitgutter_map_keys = 0
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gf <Plug>(GitGutterFold)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" let g:gitgutter_sign_added = 'xx'
" let g:gitgutter_sign_modified = 'yy'
" let g:gitgutter_sign_removed = 'zz'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_modified_removed = 'ww'
" Highlights
" GitGutterAdd          " an added line             (default: links to DiffAdd)
" GitGutterChange       " a changed line            (default: links to DiffChange)
" GitGutterDelete       " at least one removed line (default: links to DiffDelete)
" GitGutterChangeDelete " a changed line followed by at least one removed line (default: links to GitGutterChange)

" -----------------------------------------------------------
" delimitMate
" -----------------------------------------------------------
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" -----------------------------------------------------------
" PolyGlot
" -----------------------------------------------------------

" -----------------------------------------------------------
" Semshri Python Highlighting
" -----------------------------------------------------------
hi semshiSelected ctermbg=238 guibg=#444444

" -----------------------------------------------------------
" NerdTree Git
" -----------------------------------------------------------
"  let g:NERDTreeIndicatorMapCustom = {
    " \ 'Modified'  : '✹',
    " \ 'Staged'    : '✚',
    " \ 'Untracked' : '✭',
    " \ 'Renamed'   : '➜',
    " \ 'Unmerged'  : '═',
    " \ 'Deleted'   : '✖',
    " \ 'Dirty'     : '✗',
    " \ 'Clean'     : '✔︎',
    " \ 'Ignored'   : '☒',
    " \ 'Unknown'   : '?'
    " \ }

" -----------------------------------------------------------
" IndentLine
" -----------------------------------------------------------
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['md']

" -----------------------------------------------------------
" Vim Markdown 
" -----------------------------------------------------------
let vim_markdown_preview_toggle=2
let vim_markdown_preview_browser='Google Chrome'

" -----------------------------------------------------------
" NerdTree Syntax Highlight
" -----------------------------------------------------------
let g:NERDTreeLimitedSyntax = 1 " Limit the syntax highlighting to improve lag
let g:NERDTreeHighlightCursorline = 0 " Disable cursor line highlighting to improve lag

" Additional configs if the above does not help solve lag
" let g:NERDTreeSyntaxDisableDefaultExtensions = 1
" let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
" let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
" let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'cpp', 'php', 'rb', 'js', 'css', 'html'] " enabled extensions with default colors
" let g:NERDTreeSyntaxEnabledExactMatches = ['node_modules', 'favicon.ico'] " enabled exact matches with default colors
