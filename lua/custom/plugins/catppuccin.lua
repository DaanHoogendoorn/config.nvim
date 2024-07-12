return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'

    require('catppuccin').setup {
      transparent_background = true,
      integrations = {
        telescope = {
          enabled = true,
        },
        gitsigns = true,
        gitgutter = true,
        barbar = true,
        dashboard = true,
        mason = true,
        notify = true,
        markdown = true,
        noice = true,
        which_key = true,
        treesitter = true,
        treesitter_context = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        mini = {
          enabled = true,
        },
        cmp = true,
        fidget = true,
        lsp_trouble = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    }
  end,
}
