return {
  'pwntester/octo.nvim',
  enabled = false, -- TODO: remove after issue has been fixed: https://github.com/pwntester/octo.nvim/issues/1010
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      picker = 'snacks',
    }
  end,
}
