-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable Nerd Font icons.
vim.g.have_nerd_font = true

-- Disable backwards compatibility to speed up.
vim.g.skip_ts_context_commentstring_module = true

-- [[ Setting options ]]
require 'options'

-- [[ Setting keymaps ]]
require 'keymaps'

-- [[ Setting autocommands ]]
require 'autocommands'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require('lazy').setup('plugins', require 'opts.lazy')

-- vim: ts=2 sts=2 sw=2 et
