-- Automatically change relativenumber depending on environment
local NumberToggle = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  { command = [[if &nu && mode() != "i" | set rnu | endif]], group = NumberToggle }
)
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  { command = [[if &nu | set nornu | endif]], group = NumberToggle }
)
