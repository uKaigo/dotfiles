local use = require('packer').use

require('packer').startup({function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'navarasu/onedark.nvim' -- onedark colorscheme
  use {
    'kyazdani42/nvim-tree.lua', -- File explorer
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
  }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})

