-- Load plugins
require("plugins")

-- Colorscheme setup
require("onedark").setup({
	style = "darker",
})
require("onedark").load()

-- General options
local vim_options = {
	number = true,
	mouse = "a", -- It's nice to have the option :)
	wrap = false,
	cursorline = true, -- Highlight current line
	autoindent = true,
	smartindent = true,
	shiftwidth = 2, -- Number of spaces per indentation
	ignorecase = true,
	smartcase = true,
	title = true,
	numberwidth = 2,
	signcolumn = "yes",
	scrolloff = 4, -- Number of lines to keep above and below the cursor
	sidescrolloff = 4, -- Number of lines to keep left and right of the cursor
}

for k, v in pairs(vim_options) do
	vim.opt[k] = v
end

-- Load other scripts
require("scripts.numbertoggle")

-- Load other configurations
require("config.nvimtree")
require("config.bufferline")
require("config.gitsigns")
require("config.lualine")
require("config.treesitter")
require("config.mapx")
