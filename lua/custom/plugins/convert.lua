return {
  'cjodo/convert.nvim',
  event = 'BufRead',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  ft = { 'css', 'scss' },
  config = function()
    vim.keymap.set('n', '<leader>cn', '<cmd>ConvertFindNext<CR>', { desc = '[C]ode convert [n]ext' })
    vim.keymap.set('n', '<leader>cc', '<cmd>ConvertFindCurrent<CR>', { desc = '[C]ode convert [c]urrent' })
  end,
}
