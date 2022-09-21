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

-- Load other configurations
require('config/numbertoggle')
require('config/nvimtree')
require('config/bufferline')

