local opt = vim.opt

opt.wrap = false
opt.title = true
opt.autoindent = true
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.colorcolumn = "80"
opt.shell = "/usr/bin/fish"
vim.g.copilot_no_tab_map = true

require "custom.autocmds"
