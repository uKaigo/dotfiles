return {
  { 'tpope/vim-sleuth', event = 'VeryLazy' },

  {
    'numToStr/Comment.nvim',
    opts = require 'opts.comment',
    event = 'User FilePost',
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'User FilePost',
    opts = require 'opts.gitsigns',
  },

  {
    'folke/which-key.nvim',
    keys = {
      '<leader>',
      '<C-w>',
      '!',
      '"',
      "'",
      '`',
      '[',
      ']',
      '<',
      '>',
      'c',
      'd',
      'g',
      's',
      'v',
      'y',
      'z',
    },
    opts = {},
    cmd = 'WhichKey',
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = { 'Telescope' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = require 'configs.telescope',
  },

  {
    'catppuccin/nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'User FilePost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    opts = require 'opts.lualine',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = 'User FilePost',
    build = ':TSUpdate',
    opts = require 'opts.treesitter',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'User FilePost',
    opts = require 'opts.tscontext',
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = require 'opts.ctxcomment',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    event = 'User FilePost',
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    opts = require 'opts.nvim-tree',
  },

  {
    'b0o/SchemaStore.nvim',
    version = false,
  },
}

-- vim: ts=2 sts=2 sw=2 et
