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
          -- Open Lazy
          { desc = '󰒲 Open Lazy', group = 'open', action = 'Lazy', key = 'l' },

          -- Update plugins
          { desc = '󰊳 Update', group = 'updates', action = 'Lazy update', key = 'u' },

          -- Update remote plugins
          { desc = ' Update Remote', group = 'updates', action = 'UpdateRemotePlugins', key = 'U' },

          -- Find file with telescope
          { desc = '󰮗 Search File', group = 'search', action = 'Telescope find_files', key = 'f' },

          -- Quit
          { desc = '󰍃 Quit', group = 'quit', action = 'qa', key = 'q' },
        },
        week_header = {
          enable = true,
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
