return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Used by the code blocks
  },

  config = function()
    local markview = require 'markview'
    markview.setup()

    Snacks.toggle
      .new({
        name = 'Markview',
        get = function()
          return markview.state.enable
        end,
        set = function(state)
          if state then
            markview.commands.enableAll()
          else
            markview.commands.disableAll()
          end
        end,
      })
      :map '<leader>tm'
  end,
}
