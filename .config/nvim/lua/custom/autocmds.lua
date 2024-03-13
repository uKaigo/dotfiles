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

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.fn.jobstart "tmux set status off"
  end,
  once = true,
  group = VimLife,
})
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart("tmux set status on", { detach = true })
  end,
  once = true,
  group = VimLife,
})
