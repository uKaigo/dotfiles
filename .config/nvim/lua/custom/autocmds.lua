-- Automatically change relativenumber depending on environment
local NumberToggle = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
local VimLife = vim.api.nvim_create_augroup("VimLife", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  { command = [[if &nu && mode() != "i" | set rnu | endif]], group = NumberToggle }
)
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  { command = [[if &nu | set nornu | endif]], group = NumberToggle }
)

vim.api.nvim_create_autocmd(
  { "VimEnter" },
  { command = 'call jobstart("tmux set status off")', once = true, group = VimLife }
)
vim.api.nvim_create_autocmd(
  { "VimLeave" },
  { command = 'silent exec "!tmux set status on"', once = true, group = VimLife }
)
