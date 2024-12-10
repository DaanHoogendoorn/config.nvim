return {
  'CopilotC-Nvim/CopilotChat.nvim',
  event = 'BufRead',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    debug = true,
  },
  config = function()
    local wk = require 'which-key'

    wk.add {
      { '<leader>a', group = '[A]I' },
      { '<leader>a_', desc = 'whick_key_ignore' },
    }

    local chat = require 'CopilotChat'
    local actions = require 'CopilotChat.actions'
    local telescopeIntegration = require 'CopilotChat.integrations.telescope'

    local function pick(pick_actions)
      return function()
        telescopeIntegration.pick(pick_actions())
      end
    end

    local user = vim.env.USER or 'User'
    user = user:sub(1, 1):upper() .. user:sub(2)

    local systemPrompt = require('CopilotChat.prompts').COPILOT_INSTRUCTIONS
    local customPrompt = [[You are an AI programming assistant.
When writing code, follow these principles:
1. Handle errors and edge cases early with clear return statements
2. Use early returns to reduce nesting and improve readability
3. Keep functions focused and single-purpose
4. Write clear, descriptive variable and function names
5. Use consistent formatting and indentation
6. Add concise comments for complex logic
7. Prefer readability over cleverness
8. Return successful results at the end of functions

Please write code following these conventions and explain any significant decisions.]]

    chat.setup {
      model = 'claude-3.5-sonnet',
      show_help = true,
      question_header = '  ' .. user .. ' ',
      answer_header = '  Copilot ',
      system_prompt = systemPrompt .. '\n' .. customPrompt,
      chat_autocomplete = true,
      mappings = {},
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
    vim.keymap.set({ 'n', 'v' }, '<leader>ap', pick(actions.prompt_actions), { desc = '[A]I [P]rompt Actions' })

    vim.keymap.set({ 'n', 'v' }, '<leader>aq', function()
      local input = vim.fn.input 'Quick Chat: '
      if input ~= '' then
        require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
      end
    end, { desc = '[A]I [Q]uick chat' })
  end,
}
