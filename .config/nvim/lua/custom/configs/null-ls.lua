local null_ls = require "null-ls"

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.ruff, -- linter fixes
    null_ls.builtins.formatting.ruff_format,

    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
return opts
