vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    separator_style = "slant",
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      }
    }
  }
}
