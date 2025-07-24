-- Add an alias for the Lazy command: `:Lazy` to `:L`
vim.api.nvim_create_user_command('L', function()
  vim.cmd 'Lazy'
end, { desc = 'Lazy.nvim' })
