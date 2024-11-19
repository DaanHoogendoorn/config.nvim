return {
  'folke/twilight.nvim',
  config = function()
    local twilight = require 'twilight.view'

    Snacks.toggle
      .new({
        name = 'Twilight',
        get = function()
          return twilight.enabled
        end,
        set = function(state)
          if twilight.enabled then
            twilight.disable()
          else
            twilight.enable()
          end
        end,
      })
      :map '<leader>tt'
  end,
}
