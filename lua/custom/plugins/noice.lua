return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('noice').setup {
      cmdline = {
        enabled = true,
      },
      popupmenu = {
        enabled = true,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
        message = {
          enabled = false,
        },
      },
    }
  end,
}
