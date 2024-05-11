return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'

    require('catppuccin').setup {
      transparent_background = true,
      integrations = {
        telescope = true,
        gitsigns = true,
        mason = true,
        notify = true,
        bufferline = true,
        harpoon = true,
        noice = true,
        which_key = true,
        treesitter_context = true,
      },
    }
  end,
}
