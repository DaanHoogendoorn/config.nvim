return {
  {
    'github/copilot.vim',
    -- 'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    command = 'Copilot',
    build = ':Copilot auth',
    -- opts = {
    --   suggestion = { enabled = true },
    --   panel = { enabled = true },
    -- },
  },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
}
