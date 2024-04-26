return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'github/copilot.vim' },
    -- { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    debug = false,
  },
  config = function()
    -- local utils = require "config.utils"
    local wk = require 'which-key'

    -- utils.desc("<leader>a", "AI")
    wk.register { ['<leader>a'] = { name = '[A]I', _ = 'whick_key_ignore' } }

    -- Copilot autosuggestions
    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_hide_during_completion = 0
    -- vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

    local chat = require 'CopilotChat'
    local actions = require 'CopilotChat.actions'
    -- local integration = require 'CopilotChat.integrations.fzflua'

    -- local function pick(pick_actions)
    --   return function()
    --     integration.pick(pick_actions(), {
    --       fzf_tmux_opts = {
    --         ['-d'] = '45%',
    --       },
    --     })
    --   end
    -- end

    chat.setup {
      model = 'gpt-4-turbo',
      question_header = '',
      answer_header = '',
      error_header = '',
      mappings = {
        submit_prompt = {
          insert = '',
        },
        reset = {
          normal = '',
          insert = '',
        },
      },
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
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ah', pick(actions.help_actions), { desc = '[A]I [H]elp Actions' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ap', pick(actions.prompt_actions), { desc = '[A]I [P]rompt Actions' })
  end,
}
