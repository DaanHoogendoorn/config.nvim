return {
  'David-Kunz/gen.nvim',
  event = 'VeryLazy',
  config = function()
    local gen = require 'gen'

    gen.setup {
      model = 'codegemma:instruct',
    }

    -- Get the content of the current buffer to supply as context to the model
    local function get_buffer_content()
      local buf = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      return table.concat(lines, '\n')
    end

    gen.prompts['DocBlock'] = {
      prompt = 'Generate a docblock for the following code. Include the provided code in the output. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```\n\n\nHere is the full file for context: \n\n```$filetype\n'
        .. get_buffer_content()
        .. '\n```',
      replace = true,
      extract = '```$filetype\n(.-)```',
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>ag', ':Gen<CR>', { desc = 'Generate code with ollama', noremap = true })
  end,
}
