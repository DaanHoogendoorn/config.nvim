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
      auto_integrations = true,
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
