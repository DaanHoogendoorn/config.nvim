return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'

    require('catppuccin').setup {
      -- transparent_background = true,
      integrations = {
        telescope = {
          enabled = true,
        },
        gitsigns = true,
        mason = true,
        notify = true,
        barbar = true,
        harpoon = true,
        noice = true,
        which_key = true,
        treesitter = true,
        treesitter_context = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        mini = {
          enabled = true,
        },
        cmp = true,
        illuminate = {
          enabled = true,
        },
      },
    }
  end,
}
