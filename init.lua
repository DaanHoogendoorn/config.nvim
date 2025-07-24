require 'config.options'
require 'config.keymaps'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require 'core.lazy'

-- Add an alias for the Lazy command: `:Lazy` to `:L`
vim.api.nvim_create_user_command('L', function()
  vim.cmd 'Lazy'
end, { desc = 'Lazy.nvim' })

-- Use q to close certain buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'checkhealth',
    'fugitive*',
    'git',
    'help',
    'lspinfo',
    'netrw',
    'notify',
    'qf',
    'query',
  },
  callback = function()
    vim.keymap.set('n', 'q', vim.cmd.close, { desc = 'Close the current buffer', buffer = true })
  end,
})

require('custom.config.selectquotes').setup {
  key = 'q',
}

require 'custom.config.lazyblock_info'
