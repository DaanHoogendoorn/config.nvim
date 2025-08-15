return {
  'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  event = 'BufRead',
  ft = { 'php', 'javascript', 'typescript' },
  config = function()
    require('sonarlint').setup {
      server = {
        cmd = {
          'sonarlint-language-server',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          -- paths to the analyzers you need, using those for python and java in this example
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarphp.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarjs.jar',
        },
      },
      filetypes = {
        'php',
        'javascript',
        'typescript',
      },
    }
  end,
}
