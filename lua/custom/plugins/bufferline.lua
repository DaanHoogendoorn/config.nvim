return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      offsets = {
        {
          filetype = 'nvim-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'center',
        },
      },
    },
  },
}
