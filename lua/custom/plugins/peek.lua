return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  ft = 'markdown',
  config = function()
    local peek = require 'peek'
    peek.setup()
    vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
    vim.api.nvim_create_user_command('PeekClose', peek.close, {})

    vim.keymap.set('n', '<leader>tp', function()
      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end, { desc = '[T]oggle [P]eek', noremap = true, silent = true })
  end,
}
