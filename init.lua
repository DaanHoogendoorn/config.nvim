-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- disable netrw at the very start of your init.lua (from nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- disable status line when not required
vim.opt.laststatus = 3

-- Set tab width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- True colors
vim.o.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.completeopt = 'menu,noinsert,popup,fuzzy'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
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

-- copy entire buffer content
vim.api.nvim_set_keymap('n', '<leader>yy', ':%y<CR>', { noremap = true, silent = true })

-- add semicolon to the end of the line
vim.api.nvim_set_keymap('n', '<leader>;', 'mmA;<Esc>`m', { desc = 'Add semicolon to end of line', noremap = true, silent = true })
-- add comma to the end of the line
vim.api.nvim_set_keymap('n', '<leader>,', 'mmA,<Esc>`m', { desc = 'Add comma to end of line', noremap = true, silent = true })

local wk = require 'which-key'

wk.add {
  { '<leader>i', group = '[I]nsert' },
  { '<leader>i_', desc = 'whick_key_ignore' },
}

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

require('custom.config.selectquotes').setup {
  key = 'q',
}

require 'custom.config.lazyblock_info'

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
