local M = {}

M.move = {
  n = {
    ["<A-j>"] = {"<cmd> m .+1 <CR>=="},
    ["<A-k>"] = {"<cmd> m .-2 <CR>=="},
  },
  i = {
    ["<A-j>"] = {"<Esc> <cmd> m .+1 <CR>==gi"},
    ["<A-k>"] = {"<Esc> <cmd> m .-2 <CR>==gi"},
  },
  v = {
    -- The colon is needed for the mark to be set.
    ["<A-j>"] = {":m '>+1 <CR>gv=gv"},
    ["<A-k>"] = {":m '<-2 <CR>gv=gv"}
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
