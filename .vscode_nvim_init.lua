vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Map semicolon to colon
vim.keymap.set('n', ';', ':', { desc = 'Map semicolon to colon', noremap = true })

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true


-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Enable being able to move up and down in the same line
vim.keymap.set('n', 'k', 'gk', { desc = 'Move up within the same line of text' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Move down within the same line of text' })


-- Map end of line and beginning of line
vim.keymap.set('n', 'H', 'g^', { desc = 'Move to beginning of line' })
vim.keymap.set('n', 'L', 'g$', { desc = 'Move to end of line' })

vim.keymap.set('n', '<C-\\>', '<C-w>v<C-w>l', { desc = 'Create and switch to veritcal split' })
vim.keymap.set('n', '<C-->', '<cmd>sp<C-w>j', { desc = 'Create and switch to horizontal split' })
