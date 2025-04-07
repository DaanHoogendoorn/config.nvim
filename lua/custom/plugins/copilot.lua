return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    command = 'Copilot',
    config = function()
      vim.g.copilot_auto_trigger_enabled = false

      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = vim.g.copilot_auto_trigger_enabled, -- this can be toggled using <leader>tc
          keymap = {
            accept = '<C-w>',
            next = '<C-c>',
          },
        },
        copilot_model = 'gpt-4o-copilot',
      }

      local suggestion = require 'copilot.suggestion'

      Snacks.toggle
        .new({
          name = 'Copilot',
          get = function()
            return vim.g.copilot_auto_trigger_enabled
          end,
          set = function(state)
            if state == vim.g.copilot_auto_trigger_enabled then
              return
            end

            vim.g.copilot_auto_trigger_enabled = state
            suggestion.toggle_auto_trigger()
          end,
        })
        :map '<leader>tc'
    end,
  },
}
