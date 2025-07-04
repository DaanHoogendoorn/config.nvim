return {
  'CopilotC-Nvim/CopilotChat.nvim',
  event = 'BufRead',
  command = { 'CopilotChat', 'CopilotChatOpen', 'CopilotChatClose' },
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  config = function()
    require('CopilotChat').setup()

    vim.keymap.set('n', '<leader>aa', ':CopilotChatOpen<CR>')
  end,
}
