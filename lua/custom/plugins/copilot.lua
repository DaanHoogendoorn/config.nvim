return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    command = 'Copilot',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = false,
        },
      }
    end,
  },
}
