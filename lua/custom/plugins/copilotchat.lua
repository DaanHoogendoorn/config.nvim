return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  event = 'VeryLazy',
  dependencies = {
    { 'github/copilot.vim' },
    -- { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    debug = true,
  },
  config = function()
    local wk = require 'which-key'

    wk.register { ['<leader>a'] = { name = '[A]I', _ = 'whick_key_ignore' } }

    local chat = require 'CopilotChat'
    local actions = require 'CopilotChat.actions'
    local integration = require 'CopilotChat.integrations.telescope'

    local function pick(pick_actions)
      return function()
        integration.pick(pick_actions())
      end
    end

    local user = vim.env.USER or 'User'
    user = user:sub(1, 1):upper() .. user:sub(2)

    chat.setup {
      model = 'gpt-4-turbo',
      auto_insert_mode = true,
      show_help = true,
      question_header = '  ' .. user .. ' ',
      answer_header = '  Copilot ',
      prompts = {
        Explain = {
          mapping = '<leader>ae',
          description = '[A]I [E]xplain',
        },
        Review = {
          mapping = '<leader>ar',
          description = '[A]I [R]eview',
        },
        Tests = {
          mapping = '<leader>at',
          description = '[A]I [T]ests',
        },
        Fix = {
          mapping = '<leader>af',
          description = '[A]I [F]ix',
        },
        Optimize = {
          mapping = '<leader>ao',
          description = '[A]I [O]ptimize',
        },
        Docs = {
          mapping = '<leader>ad',
          description = '[A]I [D]ocumentation',
        },
        CommitStaged = {
          mapping = '<leader>ac',
          description = '[A]I Generate [C]ommit',
        },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>aa', chat.toggle, { desc = '[A]I Toggle' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ax', chat.reset, { desc = '[A]I Reset' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ah', pick(actions.help_actions), { desc = '[A]I [H]elp Actions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ap', pick(actions.prompt_actions), { desc = '[A]I [P]rompt Actions' })
  end,
}
