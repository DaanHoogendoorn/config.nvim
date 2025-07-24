return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  config = function()
    local gitsigns = require 'gitsigns'

    vim.g.line_blame_enabled = true

    gitsigns.setup {
      -- INFO: don't change directly
      current_line_blame = vim.g.line_blame_enabled,
    }

    Snacks.toggle
      .new({
        name = 'Line blame',
        get = function()
          return vim.g.line_blame_enabled
        end,
        set = function(state)
          if state == vim.g.line_blame_enabled then
            return
          end

          vim.g.line_blame_enabled = state
          vim.cmd 'Gitsigns toggle_current_line_blame'
        end,
      })
      :map '<leader>tb'
  end,
}
