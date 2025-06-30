return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
}
