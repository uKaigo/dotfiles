return function()
  return {
    toggler = {
      line = '<leader>c',
    },
    opleader = {
      line = 'c',
    },

    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }
end
