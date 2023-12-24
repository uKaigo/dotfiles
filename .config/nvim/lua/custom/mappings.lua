local M = {}

-- M.general = {
--   n = {
--     ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "window left" },
--     ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "window right" },
--     ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "window down" },
--     ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "window up" },
--   },
-- }

M.move = {
  n = {
    ["<A-k>"] = { "<cmd> m .-2 <CR>==", "Move 1 line up" },
    ["<A-j>"] = { "<cmd> m .+1 <CR>==", "Move 1 line down" },
  },
  i = {
    ["<A-k>"] = { "<Esc> <cmd> m .-2 <CR>==gi", "Move 1 line up" },
    ["<A-j>"] = { "<Esc> <cmd> m .+1 <CR>==gi", "Move 1 line down" },
  },
  v = {
    -- The colon is needed for the mark to be set.
    ["<A-j>"] = { ":m '>+1 <CR>gv=gv", "Move block 1 line down" },
    ["<A-k>"] = { ":m '<-2 <CR>gv=gv", "Move block 1 line up" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add debug breakpoint" },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "Debug python file",
    },
  },
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "Update crates",
    },
  },
}

return M
