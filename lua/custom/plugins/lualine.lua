return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          icons_enabled = vim.g.have_nerd_font,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {
              'snacks_dashboard',
            },
          },
        },
        sections = {
          lualine_x = {
            require 'custom.config.codecompanion-lualine',
            {
              'copilot',
              symbols = {
                status = {
                  icons = {
                    enabled = ' ',
                    sleep = ' ', -- auto-trigger disabled
                    disabled = ' ',
                    warning = ' ',
                    unknown = ' ',
                  },
                },
              },
            },
            {
              require('lazy.status').updates,
              cond = require('lazy.status').has_updates,
            },
            'encoding',
            'fileformat',
            'filetype',
          },
        },
      }
    end,
  },
  {
    'AndreM222/copilot-lualine',
    event = 'VimEnter',
  },
}
