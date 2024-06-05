return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
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
