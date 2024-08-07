-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode.
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line.
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Follow current line indentation.
vim.opt.autoindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable signcolumn.
vim.opt.signcolumn = 'no'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live.
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Minimal number of lines to keep to the left and right side of the cursor.
vim.opt.sidescrolloff = 5

-- Disable line wrapping.
vim.opt.wrap = false

-- Change default shell.
vim.opt.shell = '/usr/bin/fish'

-- Set highlight on search.
vim.opt.hlsearch = true

-- vim: ts=2 sts=2 sw=2 et
