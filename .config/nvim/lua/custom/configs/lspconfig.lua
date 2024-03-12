local lspconfig = require "lspconfig"
local ch_config = require "plugins.configs.lspconfig"

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local M = {
  capabilities = ch_config.capabilities,
}

M.on_attach = function(client, bufnr)
  if client.name == "ruff_lsp" then
    client.server_capabilities.hoverProvider = false
  end

  ch_config.on_attach(client, bufnr)

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
end

lspconfig.pyright.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
  },
}
lspconfig.ruff_lsp.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.bashls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.emmet_language_server.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.html.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.cssls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.eslint.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

return M
