local P = {
  -- Debugger
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function(_, _)
  --     require("core.utils").load_mappings "dap"
  --   end,
  -- },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = "mfussenegger/nvim-dap",
  --   config = function()
  --     local dap = require "dap"
  --     local dapui = require "dapui"
  --     dapui.setup()
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close()
  --     end
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     "rcarriga/nvim-dap-ui",
  --   },
  --   config = function(_, _)
  --     local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  --     require("dap-python").setup(path)
  --     require("core.utils").load_mappings "dap_python"
  --   end,
  -- },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = { "lua", "bash", "zsh", "sh" },
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  -- Other
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ruff-lsp",
        "shfmt",
        "stylua",
        "pyright",
        "shellcheck",
        "rust-analyzer",
        "bash-language-server",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "custom.configs.nvim-tree",
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = require "custom.configs.colorizer",
  },

  {
    "github/copilot.vim",
    keys = { "<C-j>", "<M-Bslash>" },
    cmd = { "Copilot" },
  },
}
return P
