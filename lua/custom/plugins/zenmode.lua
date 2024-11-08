return {
  'folke/zen-mode.nvim',
  event = 'BufRead',
  config = function()
    local zenmode = require 'zen-mode'

    vim.g.zenmode_enabled = false

    zenmode.setup {
      plugins = {
        twilight = {
          enabled = true,
        },
        wezterm = {
          enabled = true,
          font = '+2',
        },
        tmux = {
          enabled = true,
        },
      },
    }

    Snacks.toggle
      .new({
        name = 'ZenMode',
        get = function()
          return vim.g.zenmode_enabled
        end,
        set = function(state)
          if state == vim.g.zenmode_enabled then
            return
          end

          vim.g.zenmode_enabled = state
          zenmode.toggle()
        end,
      })
      :map '<leader>tz'
  end,
}
