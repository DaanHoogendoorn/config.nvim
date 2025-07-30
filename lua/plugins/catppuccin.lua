return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'

    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
      integrations = {
        flash = true,
        gitsigns = true,
        harpoon = true,
        mason = true,
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
        snacks = true,
        fidget = true,
        lsp_trouble = true,
        blink_cmp = true,
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
        octo = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
