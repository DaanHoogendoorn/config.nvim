return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPost',
  opts = {
    filetypes = { '*' },
    options = {
      parsers = {
        css = true,
        css_fn = true,
        css_var = { enable = true },
        css_var_rgb = { enable = true },
        sass = { enable = false },
        hex = {
          default = true,
          aarrggbb = true,
        },
      },
    },
  },
}
