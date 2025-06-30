return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      {
        'justinsgithub/wezterm-types',
        lazy = true,
      },
    },
    opts = {
      library = {
        'lazy.nvim',
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
}
