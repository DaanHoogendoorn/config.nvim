return {
  'folke/zen-mode.nvim',
  event = 'BufRead',
  config = function()
    require('zen-mode').setup {
      plugins = {
        wezterm = {
          enabled = true,
          font = '+2',
        },
        tmux = {
          enabled = true,
        },
      },
    }

    vim.keymap.set('n', '<leader>tz', '<CMD>ZenMode<CR>', { desc = '[T]oggle [Z]en Mode' })
  end,
}
