return {
  'stevearc/oil.nvim',
  enabled = false,
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open file [e]xplorer', noremap = true })
  end,
}
