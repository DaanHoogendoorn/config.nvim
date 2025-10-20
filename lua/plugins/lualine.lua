return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.opt.laststatus = 3

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
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
          },
          {
            function()
              return ' '
            end,
            color = function()
              local status = require('sidekick.status').get()
              if status then
                return status.kind == 'Error' and 'DiagnosticError' or status.busy and 'DiagnosticWarn' or 'Special'
              end
            end,
            cond = function()
              local status = require 'sidekick.status'
              return status.get() ~= nil
            end,
          },
          'encoding',
          'fileformat',
          'filetype',
        },
      },
    }
  end,
}
