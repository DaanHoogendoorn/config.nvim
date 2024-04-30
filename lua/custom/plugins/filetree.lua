return {
  {
    'nvim-tree/nvim-tree.lua',
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
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   version = '*',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --     'MunifTanjim/nui.nvim',
  --   },
  --   config = function()
  --     require('neo-tree').setup {
  --       filesystem = {
  --         filtered_items = {
  --           hide_dotfiles = false,
  --         },
  --       },
  --     }
  --
  --     vim.keymap.set('n', '<leader>e', '<Cmd>Neotree reveal right<CR>', { desc = 'Show file [e]xplorer' })
  --     -- vim.keymap.set('n', '<leader><leader>', '<cmd>Neotree reveal float<CR>', { desc = 'Toggle floating filetree' })
  --   end,
  -- },
}
