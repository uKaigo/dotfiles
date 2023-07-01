local opt = vim.opt

opt.wrap = false
opt.title = true
opt.autoindent = true
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.colorcolumn = "80"
opt.shell = "/bin/fish"

require "custom.autocmds"
