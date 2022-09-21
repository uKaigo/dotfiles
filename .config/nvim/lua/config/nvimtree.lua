vim.g.loaded = true
vim.g.loaded_netrwPlugin = true

require('nvim-tree').setup {
  hijack_cursor = true,
  view = {
    adaptive_size = true,
    side = 'left',
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "all",
    root_folder_modifier = ':t',
    special_files = { 'Cargo.toml', 'setup.py', 'package.json', 'Makefile', 'README.md', 'readme.md' }
  }
}
