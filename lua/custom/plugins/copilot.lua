return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    command = 'Copilot',
    config = function()
      local copilot = require 'copilot'
      copilot.setup {
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = '<Tab>',
          },
        },
      }
    end,
  },
}
