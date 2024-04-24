return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup {
      plugins = {
        kitty = {
          enabled = true,
          font = '+2',
        },
      },
    }

    vim.keymap.set('n', '<leader>tz', '<CMD>ZenMode<CR>', { desc = '[T]oggle [Z]en Mode' })
  end,
}
