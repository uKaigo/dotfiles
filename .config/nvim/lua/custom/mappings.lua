local M = {}

M.move = {
  n = {
    ["<A-j>"] = { "<cmd> m .+1 <CR>==", "Move 1 line down" },
    ["<A-k>"] = { "<cmd> m .-2 <CR>==", "Move 1 line up" },
  },
  i = {
    ["<A-j>"] = { "<Esc> <cmd> m .+1 <CR>==gi", "Move 1 line down" },
    ["<A-k>"] = { "<Esc> <cmd> m .-2 <CR>==gi", "Move 1 line up" },
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

return M
