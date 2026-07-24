return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.opt.laststatus = 3

    require('lualine').setup {
      options = {
        theme = 'catppuccin-nvim',
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
              return require('opencode').statusline()
            end,
            cond = function()
              local ok, _ = pcall(require, 'opencode')
              return ok
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
