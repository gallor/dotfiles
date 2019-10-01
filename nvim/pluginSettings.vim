" -----------------------------------------------------------
" FZF
" -----------------------------------------------------------
" let g:fzf_command_prefix = 'Fzf'
" nnoremap <Leader>p :FzfBuffers<CR>
" nnoremap <Leader>e :FzfHistory<CR>
" nnoremap <Leader>t :FzfBTags<CR>
" nnoremap <Leader>T :FzfTags<CR>
" nnoremap <C-p> :FzfFiles<CR>
" " Have FZF list all tracked files plus untracked files minus your ignored files
" nnoremap <Leader>gf :FzfGitFiles --exclude-standard --others --cached<CR>
" nnoremap <Leader>gt :FzfRg<CR>
"
" let g:fzf_layout = { 'down': '~20%' }

" -----------------------------------------------------------
" Denite
" -----------------------------------------------------------
if has('nvim')
    call denite#custom#option('_', { 'split': 'floating' })
endif

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> o denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')

  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> h denite#do_map('do_action', 'split')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" For ripgrep
" Note: It is slower than ag
call denite#custom#var('file/rec', 'command',
      \ ['rg', '--files', '--glob', '!.git'])
" For Pt(the platinum searcher)
" NOTE: It also supports windows.
call denite#custom#var('file/rec', 'command',
      \ ['pt', '--follow', '--nocolor', '--nogroup',
      \  (has('win32') ? '-g:' : '-g='), ''])
" For python script scantree.py
" Read bellow on this file to learn more about scantree.py
call denite#custom#var('file/rec', 'command', ['scantree.py'])

" Change matchers.
call denite#custom#source(
      \ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

if has('nvim') && &runtimepath =~# '\/cpsm'
    call denite#custom#source(
            \ 'buffer,file_mru,file_old,file/rec,grep,mpc,line,neoyank',
            \ 'matchers', ['matcher/cpsm', 'matcher/fuzzy'])
endif

" Change sorters.
call denite#custom#source(
      \ 'file/rec', 'sorters', ['sorter/sublime'])

" Add custom menus
let s:menus = {}

let s:menus.zsh = {
      \ 'description': 'Edit your import zsh configuration'
      \ }
let s:menus.zsh.file_candidates = [
      \ ['zshrc', '~/.config/zsh/.zshrc'],
      \ ['zshenv', '~/.zshenv'],
      \ ]

let s:menus.my_commands = {
      \ 'description': 'Example commands'
      \ }
let s:menus.my_commands.command_candidates = [
      \ ['Split the window', 'vnew'],
      \ ['Open zsh menu', 'Denite menu:zsh'],
      \ ['Format code', 'FormatCode', 'go,python'],
      \ ]

call denite#custom#var('menu', 'menus', s:menus)

" Specify multiple paths in grep source
"call denite#start([{'name': 'grep',
"      \ 'args': [['a.vim', 'b.vim'], '', 'pattern']}])

" Define alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#alias('source', 'file/rec/py', 'file/rec')
call denite#custom#var('file/rec/py', 'command',['scantree.py'])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Custom action
" Note: lambda function is not supported in Vim8.
call denite#custom#action('file', 'test',
      \ {context -> execute('let g:foo = 1')})
call denite#custom#action('file', 'test2',
      \ {context -> denite#do_action(
      \  context, 'open', context['targets'])})

" Custom options for ripgrep for default_opts
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
if executable('rg')
    " Ripgrep
    set grepprg=rg\ --vimgrep\ --no-heading\ -S
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'default_opts',
        \ ['--hidden', '--vimgrep', '--heading', '-S'])
elseif executable('ag')
  " The Silver Searcher
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '-U', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''])
  " Setup ignore patterns in your .agignore file!
  " https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
        \ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])
elseif executable('ack')
    " Ack command
    call denite#custom#var('grep', 'command', ['ack'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--match'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'default_opts',
        \ ['--ackrc', $HOME.'/.config/ackrc', '-H',
        \ '--nopager', '--nocolor', '--nogroup', '--column'])

endif

call denite#custom#option('search', { 'start_filter': 0, 'no_empty': 1 })
call denite#custom#option('list', { 'start_filter': 0 })
call denite#custom#option('jump', { 'start_filter': 0 })
call denite#custom#option('git', { 'start_filter': 0 })

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Disable internal statusline to use airline
call denite#custom#option('_', 'statusline', v:false)

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt ,
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
      \ 'auto_resize': 1,
      \ 'prompt': 'λ',
      \ 'direction': 'belowright',
      \ 'winminheight': '20',
      \ 'highlight_mode_insert': 'Visual',
      \ 'highlight_mode_normal': 'Visual',
      \ 'highlight_matched_char': 'Function',
      \ 'highlight_matched_range': 'Normal',
      \ 'split': 'floating'
      \ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)

" === Denite shortcuts === "
  "<Ctrl>p - Browse list of files in current directory
  "<leader>p - Browser currently open buffers
  "<leader>wg - Search current directory for occurences of word under cursor
  "<leader>wg - Search current directory for occurences of given term and
  "close window if no results
nnoremap <C-p> :Denite file/rec -start-filter<CR>
nnoremap <leader>p :Denite buffer<CR>
nnoremap <leader>wg :DeniteCursorWord grep:.<CR>
nnoremap <leader>g :Denite grep:. -no-empty<CR>
" nnoremap <leader><Space>/ :DeniteBufferDir grep:.<CR>
" nnoremap <leader>d :DeniteBufferDir file/rec -start-filter<CR>
nnoremap <leader>r :Denite -resume -cursor-pos=+1<CR>
" nnoremap <leader><C-r> :Denite register:.<CR>
" references source from LanguageClient

hi link deniteMatchedChar Special

" Quit filter window in denite filter window
autocmd FileType denite-filter call s:denite_filter_my_settings()
  function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
  endfunction

" -----------------------------------------------------------
" Coc - https://github.com/neoclide/coc.nvim
" -----------------------------------------------------------
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
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
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

" -----------------------------------------------------------
" Airline
" -----------------------------------------------------------
let g:airline_theme='base16_twilight'
let g:airline#extensions#ale#enabled = 1 " Ale enabled
let g:airline#extensions#tabline#enabled = 1 " Enable Vim Airline for list of buffers
let g:airline#extensions#whitespace#enabled = 1
let g:airline_detect_crypt = 1
" let g:airline#extension#syntastic#enabled = 1 " Enable syntastic integration
let g:airline#extensions#branch#enabled = 1 " Enable git branch
let g:airline#extensions#coc#enabled = 1 " Enable Coc
let g:airline#extensions#hunks#enabled = 1 " Enable git hunk
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
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create(['branch'])
    " let g:airline_section_b = airline#section#create(['hunks', 'branch'])
    let g:airline_section_c = ''
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
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

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

" === vim-javascript === "
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" -----------------------------------------------------------
" Syntax and Syntastic
" -----------------------------------------------------------
" Highlight jsx syntax even in non .jsx files
" let g:jsx_ext_required = 0
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
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red guifg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow guifg=yellow

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_sign_column_always = 1 " keep the sign gutter on all the time
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign<Paste>
" nmap <silent> [l <Plug>(ale_previous_wrap)
" nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l :lprevious<CR>
nmap <silent> ]l :lnext<CR>
nmap <silent> <leader>]l :lopen<CR>
nmap <silent> <leader>[l :lclose<CR>

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
nmap <Leader>gp <Plug>GitGutterPreviewHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
nmap <Leader>gf <Plug>GitGutterFold
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

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
" Dash
" -----------------------------------------------------------
" nnoremap <C-k> <Plug>DashSearch
