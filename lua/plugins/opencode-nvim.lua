return {
  'nickjvandyke/opencode.nvim',
  version = '*',
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('snacks.terminal').open('opencode --port', {
            win = { position = 'right', enter = false, wo = { winbar = '' } },
          })
        end,
      },
      select = {
        prompts = {
          docblocks = "Please add concise docblocks to @this. If it's typescript, please omit the type declarations in the comment as they're already in the code.",
        },
      },
    }

    vim.keymap.set('t', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { desc = 'Navigate left from terminal' })
    vim.keymap.set('t', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { desc = 'Navigate down from terminal' })
    vim.keymap.set('t', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { desc = 'Navigate up from terminal' })
    vim.keymap.set('t', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { desc = 'Navigate right from terminal' })

    _G._opencode_send_text = function(text, fallback)
      local ok, connected = pcall(function()
        return require('opencode.server').connected
      end)
      if ok and connected then
        require('opencode').prompt(text)
      elseif fallback then
        local win = require('snacks.terminal').get('opencode --port', { create = false })
        if win then
          vim.api.nvim_chan_send(vim.bo[win.buf].channel, fallback)
        end
      end
    end
  end,
  keys = {
    {
      '<C-.>',
      function()
        require('snacks.terminal').toggle('opencode --port', {
          win = { position = 'right', enter = false, wo = { winbar = '' } },
        })
      end,
      mode = { 'n', 'x', 'i', 't' },
      desc = 'OpenCode Toggle Terminal',
    },
    {
      '<leader>as',
      function()
        require('opencode').select()
      end,
      desc = 'OpenCode Select',
    },
    {
      '<leader>ap',
      function()
        local rel = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
        local line = tostring(vim.fn.line('.'))
        local col = tostring(vim.fn.col('.'))
        _G._opencode_send_text('@this ', '@' .. rel .. ':' .. line .. ':' .. col .. ' ')
      end,
      mode = { 'n', 'v' },
      desc = 'OpenCode Prompt',
    },
    {
      '<leader>ab',
      function()
        local rel = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
        _G._opencode_send_text(rel .. ' ', '@' .. rel .. ' ')
      end,
      mode = { 'n' },
      desc = 'OpenCode Ask File',
    },
    {
      '<leader>aq',
      function()
        local win = require('snacks.terminal').get('opencode --port', { create = false })
        if win then
          win:close()
        end
      end,
      mode = { 'n' },
      desc = 'OpenCode Close Terminal',
    },
  },
}
