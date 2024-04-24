return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    }

    vim.keymap.set('n', '<leader>tt', '<Cmd>Neotree reveal left<CR>', { desc = '[T]oggle file[t]ree' })
    vim.keymap.set('n', '<leader><tab>', '<cmd>Neotree reveal float<CR>', { desc = 'Toggle floating filetree' })
  end,
}
