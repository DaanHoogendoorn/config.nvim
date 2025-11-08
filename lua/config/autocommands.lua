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

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end
  end,
})
