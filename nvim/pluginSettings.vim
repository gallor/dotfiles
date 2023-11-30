" -----------------------------------------------------------
" FZF
" -----------------------------------------------------------
let g:fzf_command_prefix = 'Fzf'
nnoremap <Leader>p :FzfBuffers<CR>
nnoremap <Leader>e :FzfHistory<CR>
nnoremap <Leader>t :FzfBTags<CR>
nnoremap <Leader>T :FzfTags<CR>
" Have FZF list all tracked files plus untracked files minus your ignored files
" nnoremap <Leader>rg :Find<CR>
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
  \ 'coc-actions',
  \ 'coc-prettier',
  \ 'coc-docker',
  \ 'coc-pyright',
	\ 'coc-sh'
  \ ]

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
noremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (coc#float#has_float() == 0)
  " if (coc#rpc#ready())
    silent call CocActionAsync('doHover')
  elseif (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent><leader>K :call <SID>show_documentation()<CR>

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

" Formatting selected code.
xmap <leader>gf  <Plug>(coc-format-selected)
nmap <leader>gf  <Plug>(coc-format-selected)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>do  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" -----------------------------------------------------------
" Lua Plugins:
" WebIcons
" Bufferline
" LuaLine
" NvimTree
" -----------------------------------------------------------
:lua require('nvim-web-devicons').setup{
      \ override_by_extension = {
      \ ["txt"] = {
          \ icon = "",
          \ name = "Text"
          \ }
          \ }
  \ }
:lua require('bufferline').setup{
  \
  \ }
:lua require('lualine').setup {
      \ options = {
      \   component_separators = { left = '', right = '' },
      \   section_separators = { left = '', right = '' }
      \ },
      \ sections = {
      \   lualine_x = {'filetype'}
      \ }
    \ }
:lua vim.g.loaded = 1
:lua vim.g.loaded_netrwPlugin = 1

:lua require("nvim-tree").setup({
  \ log = {
  \  enable = true,
  \  truncate = true,
  \  types = {
  \    diagnostics = true,
  \    git = true,
  \    profile = true,
  \    watcher = true,
  \  }
  \ }
  \ })

nnoremap <leader>n :NvimTreeToggle<CR>

" -----------------------------------------------------------
" Wilder
" -----------------------------------------------------------
call wilder#setup({
      \ 'modes': [':', '/', '/?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<C-y>',
      \ 'reject_key': '<C-e>'
      \ })

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline(),
      \     wilder#search_pipeline(),
      \   ),
      \ ])

 call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'fuzzy': 1,
      \       'sorter': wilder#python_difflib_sorter(),
      \       'debounce': 30,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern(),
      \       'sorter': wilder#python_difflib_sorter(),
      \       'engine': 're',
      \       'debounce': 30,
      \     }),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \ },
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer(),
      \ '/': wilder#wildmenu_renderer(),
      \ }))

call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlights': {
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
      \ })))


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

let g:ale_linters= {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'typescriptreact': ['tslint']
\}

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

" ALE automatically open a window for loclist
" let g:ale_open_list = 1

" -----------------------------------------------------------
" GitGutter
" -----------------------------------------------------------
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1 " To use floating/popup windows for hunk previews
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gf <Plug>(GitGutterFold)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Highlights
" (default: links to DiffAdd)
hi GitGutterAdd guibg=none ctermbg=none
" (default: links to DiffChange)
hi GitGutterChange guibg=none ctermbg=none
" (default: links to DiffDelete)
hi GitGutterDelete guibg=none ctermbg=none
" (default: links to GitGutterChange)
hi GitGutterChangeDelete guibg=none ctermbg=none

" -----------------------------------------------------------
" delimitMate
" -----------------------------------------------------------
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" -----------------------------------------------------------
" PolyGlot
" -----------------------------------------------------------
let g:javascript_plugin_jsdoc = 1
"
" -----------------------------------------------------------
" Semshri Python Highlighting
" -----------------------------------------------------------
hi semshiSelected ctermbg=238 guibg=#444444

" -----------------------------------------------------------
" IndentLine
" -----------------------------------------------------------
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['md']

" -----------------------------------------------------------
" Vim Markdown Preview
" -----------------------------------------------------------
let vim_markdown_preview_toggle=2
let vim_markdown_preview_browser='Google Chrome'

" -----------------------------------------------------------
" Vim Markdown Syntax
" -----------------------------------------------------------
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" -----------------------------------------------------------
" Typescript Vim
" -----------------------------------------------------------
let g:typescript_indent_disable = 1

" -----------------------------------------------------------
" Toggle Term
" -----------------------------------------------------------
lua require("toggleterm").setup()
" -----------------------------------------------------------
" NeoFormat
" -----------------------------------------------------------
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable trimming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Look for formatter executable in the node_modules/.bin in
" current working directory or one of its parents
let g:neoformat_try_node_exe = 1

" let g:neoformat_javascript_jsbeautify = {
"     \ 'try_node_exe': 1
"     \ }


" -----------------------------------------------------------
" Taskpaper
" -----------------------------------------------------------
let g:task_paper_follow_move = 0
let g:task_paper_search_hide_done = 1

" highlight-args
" let g:task_paper_styles={'wait': 'ctermfg=Blue guifg=Blue', 'FAIL': 'ctermbg=Red guibg=Red'}

