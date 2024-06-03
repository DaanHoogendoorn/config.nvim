return {
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        view = {
          side = 'right',
        },
      }

      vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { desc = 'Show file [e]xplorer' })
    end,
  },
}
