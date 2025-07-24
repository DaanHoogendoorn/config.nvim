vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Cycle through buffer with tab and shift-tab
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

-- https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/ (smart dd)
vim.keymap.set('n', 'dd', function()
  if vim.api.nvim_get_current_line():match '^%s*$' then
    return '"_dd'
  else
    return 'dd'
  end
end, { noremap = true, expr = true })

vim.keymap.set('n', 'cc', function()
  if vim.api.nvim_get_current_line():match '^%s*$' then
    return '"_cc'
  else
    return 'cc'
  end
end, { noremap = true, expr = true })

-- copy entire buffer content
vim.api.nvim_set_keymap('n', '<leader>yy', ':%y<CR>', { noremap = true, silent = true })

-- add semicolon to the end of the line
vim.api.nvim_set_keymap('n', '<leader>;', 'mmA;<Esc>`m', { desc = 'Add semicolon to end of line', noremap = true, silent = true })
-- add comma to the end of the line
vim.api.nvim_set_keymap('n', '<leader>,', 'mmA,<Esc>`m', { desc = 'Add comma to end of line', noremap = true, silent = true })

-- easy figlet input
vim.keymap.set('n', '<leader>if', function()
  if vim.fn.executable 'figlet' == 1 then
    local input = vim.fn.input {
      prompt = 'Figlet: ',
    }

    if input ~= '' then
      local figlet_output = vim.fn.system('figlet ' .. vim.fn.shellescape(input))

      vim.api.nvim_put(vim.split(figlet_output, '\n'), 'l', true, true)
    else
      print 'No input provided'
    end
  else
    print 'Figlet is not installed'
  end
end, { desc = '[I]nsert [f]iglet', noremap = true, silent = true })

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>ao', function()
  local has_opencode = vim.fn.executable 'opencode'
  local has_tmux = vim.fn.executable 'tmux'

  if not has_opencode or not has_tmux then
    vim.notify 'opencode and tmux are required'
    return
  end

  -- check if in a tmux session
  if vim.env.TMUX == nil then
    vim.notify 'Not in a tmux session'
    return
  end

  local splitw_command = 'splitw'
  if vim.o.columns > 140 then
    splitw_command = 'splitw -h'
  end

  vim.cmd('silent !tmux ' .. splitw_command .. ' opencode')
end, { silent = true, desc = '[A]i [o]pencode' })
