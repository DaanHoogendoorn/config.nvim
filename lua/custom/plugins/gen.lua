return {
  'David-Kunz/gen.nvim',
  event = 'VeryLazy',
  config = function()
    local gen = require 'gen'

    gen.setup {
      model = 'codegemma:instruct',
    }

    gen.prompts['DocBlock'] = {
      prompt = 'Generate a docblock for the following code. Include the provided code in the output. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = true,
      extract = '```$filetype\n(.-)```',
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>ag', ':Gen<CR>', { desc = 'Generate code with ollama', noremap = true })
  end,
}
