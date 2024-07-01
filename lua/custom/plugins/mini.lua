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

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- cursorword
    require('mini.cursorword').setup()

    -- hipatterns
    require('mini.hipatterns').setup()

    -- jump2d
    require('mini.jump2d').setup()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
