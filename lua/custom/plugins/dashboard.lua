return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      hide = {
        statusline = true,
        tabline = true,
        winbar = true,
      },
      config = {
        shortcut = {
          -- Update plugins
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },

          -- Update remote plugins
          { desc = ' Update Remote', group = '@property', action = 'UpdateRemotePlugins', key = 'U' },

          -- Find file with telescope
          { desc = '󰮗 Find File', group = '@find', action = 'Telescope find_files', key = 'f' },

          -- Quit
          { desc = '󰍃 Quit', group = '@quit', action = 'qa', key = 'q' },
        },
        week_header = {
          enable = true,
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
