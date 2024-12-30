return {
  'echasnovski/mini.files',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  config = function()
    local minifiles = require 'mini.files'
    minifiles.setup {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 50,
      },
    }

    vim.keymap.set('n', '<leader>e', function()
      minifiles.open()
    end, { desc = '[E]xplore' })
  end,
}
