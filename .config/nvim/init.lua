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
prequire = require("scripts.functions").prequire
prequire("scripts.numbertoggle")

-- Load other configurations
prequire("config.nvimtree")
prequire("config.bufferline")
prequire("config.gitsigns")
prequire("config.lualine")
prequire("config.treesitter")
prequire("config.mapx")
