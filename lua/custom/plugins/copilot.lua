return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    command = 'Copilot',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = false, -- this can be toggled using <leader>tc
          keymap = {
            accept = false,
            next = '<C-c>',
          },
        },
      }

      local suggestion = require 'copilot.suggestion'

      vim.keymap.set('i', '<Tab>', function()
        if suggestion.is_visible() then
          suggestion.accept()
        else
          -- insert a tab
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true)
        end
      end, { desc = 'Accept suggestion' })

      vim.keymap.set('n', '<leader>tc', function()
        suggestion.toggle_auto_trigger()
      end, { desc = '[T]oggle [C]opilot' })
    end,
  },
}
