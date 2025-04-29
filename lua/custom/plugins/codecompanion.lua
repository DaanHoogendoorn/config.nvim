return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  init = function()
    require('custom.config.codecompanion-fidget'):init()
  end,
  config = function()
    local codecompanion = require 'codecompanion'
    codecompanion.setup {
      adapters = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'claude-3.7-sonnet',
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          keymaps = {
            send = {
              modes = { n = '<CR>', i = '<C-s>' },
            },
            close = {
              modes = { n = 'q', i = '<C-c>' },
            },
          },
        },
      },
      display = {
        chat = {
          start_in_insert_mode = true,
        },
        diff = {
          enabled = true,
          provider = 'mini_diff',
        },
        action_palette = {
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },
      prompt_library = {
        ['Document'] = {
          strategy = 'inline',
          description = 'Document the selected code',
          opts = {
            mapping = '<leader>ad',
            modes = { 'v' },
            auto_submit = true,
            short_name = 'docs',
            is_slash_cmd = true,
          },
          prompts = {
            {
              role = 'user',
              content = 'Please add documentation (docblocks) to the selected code.',
            },
          },
        },
      },
    }

    -- Key mappings for codecompanion
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true, desc = 'Toggle Code Companion chat' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ap', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true, desc = 'Open Code Companion actions menu' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ad', function()
      if vim.api.nvim_get_mode().mode == 'n' then
        vim.cmd 'normal! ggVG'
      end
      codecompanion.prompt 'docs'
    end, { noremap = true, silent = true, desc = 'Generate documentation for selected code' })
    vim.keymap.set({ 'v' }, '<leader>ae', function()
      codecompanion.prompt 'explain'
    end, { noremap = true, silent = true, desc = 'Explain selected code' })
    vim.keymap.set({ 'v' }, '<leader>af', function()
      codecompanion.prompt 'fix'
    end, { noremap = true, silent = true, desc = 'Fix issues in selected code' })
    vim.keymap.set({ 'n', 'v' }, '<leader>at', function()
      -- select entire buffer if no selection is present
      if vim.api.nvim_get_mode().mode == 'n' then
        vim.cmd 'normal! ggVG'
      end
      vim.cmd 'CodeCompanion finish the todos in the selected code'
    end, { noremap = true, silent = true, desc = 'Finish the todos' })

    -- Command alias for CodeCompanion
    vim.cmd [[cab cc CodeCompanion]]
    vim.cmd [[cab ccc CodeCompanionChat]]
  end,
}
