return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'User FilePost',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
    config = require 'configs.lspconfig',
  },

  {
    'nvimtools/none-ls.nvim',
    ft = { 'lua', 'bash', 'zsh', 'sh' },
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = require 'opts.none-ls',
  },

  {
    'stevearc/conform.nvim',
    event = 'InsertEnter',
    opts = require 'opts.conform',
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = require 'configs.cmp',
  },
}

-- vim: ts=2 sts=2 sw=2 et
