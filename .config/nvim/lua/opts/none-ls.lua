return function()
  local null_ls = require 'null-ls'
  return {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.shfmt,
    },
  }
end

-- vim: ts=2 sts=2 sw=2 et
