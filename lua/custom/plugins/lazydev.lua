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
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
}
