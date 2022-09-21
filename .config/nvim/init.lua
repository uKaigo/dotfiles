-- Load plugins
require('plugins')

-- Colorscheme setup
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- General options
vim.o.number = true
vim.o.mouse = 'h'
vim.o.wrap = false

-- Load other configurations
require('config.numbertoggle')
require('config.nvimtree')
require('config.bufferline')
require('config.gitsigns')
require('config.whichkey')
require('config.lualine')
