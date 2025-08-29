return {
  'echasnovski/mini.diff',
  version = '*',
  config = function()
    require('mini.diff').setup {
      view = {
        style = 'sign',
        priority = 0,
      },
    }
  end,
}
