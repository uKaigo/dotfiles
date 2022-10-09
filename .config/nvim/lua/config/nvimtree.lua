vim.g.loaded = true
vim.g.loaded_netrwPlugin = true
vim.o.splitright = true -- Fix the tree opening in right side

require('nvim-tree').setup {
  hijack_cursor = false,
  view = {
    adaptive_size = true,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit", mode = "n" },
        { key = "h", action = "close" },
        { key = "C", action = "cd" },
      }
    }
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "all",
    root_folder_modifier = ':t',
    special_files = { 'Cargo.toml', 'setup.py', 'package.json', 'Makefile', 'README.md', 'readme.md' }
  }
}
