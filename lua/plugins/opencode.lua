return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal — otherwise optional
    { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
  },
  ---@type opencode.Opts
  opts = {},
  keys = {
    -- Recommended keymaps
    {
      '<leader>ao',
      function()
        require('opencode').ask()
      end,
      desc = 'Ask opencode',
    },
    {
      '<leader>ab',
      function()
        require('opencode').ask '@buffer: '
      end,
      desc = 'Ask opencode about this buffer',
      mode = 'n',
    },
    {
      '<leader>ac',
      function()
        require('opencode').ask '@cursor: '
      end,
      desc = 'Ask opencode about this',
      mode = 'n',
    },
    {
      '<leader>ao',
      function()
        require('opencode').ask '@selection: '
      end,
      desc = 'Ask opencode about selection',
      mode = 'v',
    },
    {
      '<leader>an',
      function()
        require('opencode').command 'session_new'
      end,
      desc = 'New session',
    },
    {
      '<leader>ay',
      function()
        require('opencode').command 'messages_copy'
      end,
      desc = 'Copy last message',
    },
    {
      '<leader>ap',
      function()
        require('opencode').select_prompt()
      end,
      desc = 'Select prompt',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aq',
      function()
        require('opencode').command 'app_exit'
      end,
      desc = 'Quit opencode',
      mode = 'n',
    },
  },
}
