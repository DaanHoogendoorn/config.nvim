require 'config.options'
require 'config.keymaps'
require 'config.autocommands'

require 'core.lazy'

-- Add an alias for the Lazy command: `:Lazy` to `:L`
vim.api.nvim_create_user_command('L', function()
  vim.cmd 'Lazy'
end, { desc = 'Lazy.nvim' })

require('custom.config.selectquotes').setup {
  key = 'q',
}

require 'custom.config.lazyblock_info'
