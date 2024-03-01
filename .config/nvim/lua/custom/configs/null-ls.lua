local null_ls = require "null-ls"

local opts = {
  sources = {
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.formatting.shfmt,
  },
  on_attach = require("custom.configs.lspconfig").on_attach,
}
return opts
