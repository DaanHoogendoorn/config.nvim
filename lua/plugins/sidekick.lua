return {
  'folke/sidekick.nvim',
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
      prompts = {
        docblocks = "Please add docblocks to {file}. If it's typescript, please omit the type declarations in the comment as they're already in the code.",
      },
    },
  },
  keys = {
    {
      '<C-w>',
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require('sidekick').nes_jump_or_apply() then
          return
        end
      end,
      mode = { 'n' },
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle { name = 'opencode', focus = true }
      end,
      mode = { 'n', 'v' },
      desc = 'Sidekick Toggle CLI',
    },
    {
      '<leader>ab',
      function()
        -- relative to cwd
        local relative_file_path = vim.fn.expand '%:~:.'
        require('sidekick.cli').send { name = 'opencode', msg = '@' .. relative_file_path .. ' ', submit = false }
      end,
      mode = { 'n', 'v' },
      desc = 'Sidekick ask buffer',
    },
    {
      '<leader>as',
      function()
        require('sidekick.cli').select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = 'Sidekick Select CLI',
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').send { selection = true }
      end,
      mode = { 'v' },
      desc = 'Sidekick Send Visual Selection',
    },
    {
      '<leader>ap',
      function()
        require('sidekick.cli').prompt()
      end,
      mode = { 'n', 'v' },
      desc = 'Sidekick Select Prompt',
    },
    {
      '<C-.>',
      function()
        require('sidekick.cli').focus()
      end,
      mode = { 'n', 'x', 'i', 't' },
      desc = 'Sidekick Switch Focus',
    },
    {
      '<leader>aq',
      function()
        require('sidekick.cli').close { name = 'opencode' }
      end,
      mode = { 'n' },
      desc = 'Sidekick Close CLI',
    },
  },
}
