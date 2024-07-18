return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  config = function()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

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

    -- cursorword
    require('mini.cursorword').setup()

    -- hipatterns
    require('mini.hipatterns').setup()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
