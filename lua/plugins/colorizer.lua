return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    filetypes = { '*' },
    user_default_options = {
      AARRGGBB = true,
    },
    options = {
      parsers = {
        css = true,
        css_fn = true,
        hex = { default = true },
        css_var = {
          enable = true,
          parsers = {
            css = true,
          },
        },
        css_var_rgb = {
          enable = true,
        },
        sass = {
          enable = true,
        },
      },
    },
  },
}
