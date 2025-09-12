return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal — otherwise optional
    { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
  },
  config = function()
    vim.keymap.set('n', '<leader>ao', function()
      require('opencode').ask()
    end, { desc = 'Ask opencode' })

    vim.keymap.set('n', '<leader>ab', function()
      require('opencode').ask '@buffer: '
    end, { desc = 'Ask opencode about this buffer' })

    vim.keymap.set('n', '<leader>ac', function()
      require('opencode').ask '@cursor: '
    end, { desc = 'Ask opencode about this' })

    vim.keymap.set('n', '<leader>ad', function()
      require('opencode').prompt "Please add docblocks to this file: @buffer. If it's typescript, don't include the types as they are already in the code.."
    end, { desc = 'Add docblocks to this file' })

    vim.keymap.set('v', '<leader>ad', function()
      require('opencode').prompt "Please add docblocks to this selection: @selection. If it's typescript, don't include the types as they are already in the code.."
    end, { desc = 'Add docblocks to this selection' })

    vim.keymap.set('v', '<leader>ao', function()
      require('opencode').ask '@selection: '
    end, { desc = 'Ask opencode about selection' })

    vim.keymap.set('n', '<leader>an', function()
      require('opencode').command 'session_new'
    end, { desc = 'New session' })

    vim.keymap.set('n', '<leader>ay', function()
      require('opencode').command 'messages_copy'
    end, { desc = 'Copy last message' })

    vim.keymap.set({ 'n', 'v' }, '<leader>ap', function()
      require('opencode').select()
    end, { desc = 'Select prompt' })

    vim.keymap.set('n', '<leader>aq', function()
      require('opencode').command 'app_exit'
    end, { desc = 'Quit opencode' })
  end,
}
