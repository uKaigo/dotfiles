-- These are only loaded as dependencies.
-- They are here to allow for additional configuration, if needed.
return {
  -- Required by telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

  -- Required by lspconfig
  { 'j-hui/fidget.nvim', opts = require 'opts.fidget' },

  { 'folke/neodev.nvim', opts = {} },

  -- Required by cmp
  {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    build = (function()
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
