-- return {
--   'akinsho/bufferline.nvim',
--   version = '*',
--   after = 'catppuccin',
--   dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
--   config = function()
--     require('bufferline').setup {
--       highlights = require('catppuccin.groups.integrations.bufferline').get(),
--     }
--   end,
-- }

return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
