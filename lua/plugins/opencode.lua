return {
  'nickjvandyke/opencode.nvim',
  dependencies = {
    -- Required for snacks provider
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'snacks',
        snacks = {
          -- Optional: configure snacks terminal if needed
        },
      },
      -- Custom prompts - migrated from sidekick
      cli = {
        prompts = {
          docblocks = "Please add concise docblocks to @buffer. If it's typescript, please omit the type declarations in the comment as they're already in the code.",
        },
      },
    }

    -- Required for opts.events.reload
    vim.o.autoread = true

    -- Keymaps migrated from sidekick
    vim.keymap.set(
      { 'n', 'x' },
      '<leader>aa',
      function()
        require('opencode').toggle()
      end,
      { desc = 'Toggle OpenCode' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ab',
      function()
        require('opencode').prompt '@buffer '
      end,
      { desc = 'Send buffer to OpenCode' }
    )

    vim.keymap.set(
      'x',
      '<leader>av',
      function()
        require('opencode').prompt '@this '
      end,
      { desc = 'Send visual selection to OpenCode' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ap',
      function()
        require('opencode').select()
      end,
      { desc = 'Select OpenCode prompt' }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>as',
      function()
        require('opencode').select()
      end,
      { desc = 'Select OpenCode action' }
    )

    vim.keymap.set(
      { 'n', 't' },
      '<C-.>',
      function()
        require('opencode').toggle()
      end,
      { desc = 'Toggle OpenCode focus' }
    )

    vim.keymap.set(
      'n',
      '<leader>aq',
      function()
        require('opencode').toggle()
      end,
      { desc = 'Close OpenCode' }
    )

    -- Optional: Enhanced features
    -- Operator support for adding ranges
    vim.keymap.set(
      { 'n', 'x' },
      'go',
      function()
        return require('opencode').operator '@this '
      end,
      { desc = 'Add range to OpenCode', expr = true }
    )

    vim.keymap.set(
      'n',
      'goo',
      function()
        return require('opencode').operator '@this ' .. '_'
      end,
      { desc = 'Add line to OpenCode', expr = true }
    )

    -- Scroll OpenCode from Neovim
    vim.keymap.set(
      'n',
      '<S-C-u>',
      function()
        require('opencode').command 'session.half.page.up'
      end,
      { desc = 'Scroll OpenCode up' }
    )

    vim.keymap.set(
      'n',
      '<S-C-d>',
      function()
        require('opencode').command 'session.half.page.down'
      end,
      { desc = 'Scroll OpenCode down' }
    )
  end,
}
