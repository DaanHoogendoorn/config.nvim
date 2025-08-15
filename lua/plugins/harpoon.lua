return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>!',
      function()
        require('harpoon'):list():replace_at(1)
      end,
      desc = 'Harpoon: Replace 1',
      mode = 'n',
    },
    {
      '<leader>@',
      function()
        require('harpoon'):list():replace_at(2)
      end,
      desc = 'Harpoon: Replace 2',
      mode = 'n',
    },
    {
      '<leader>#',
      function()
        require('harpoon'):list():replace_at(3)
      end,
      desc = 'Harpoon: Replace 3',
      mode = 'n',
    },
    {
      '<leader>$',
      function()
        require('harpoon'):list():replace_at(4)
      end,
      desc = 'Harpoon: Replace 4',
      mode = 'n',
    },
    {
      '<leader>1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon: Select 1',
      mode = 'n',
    },
    {
      '<leader>2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon: Select 2',
      mode = 'n',
    },
    {
      '<leader>3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon: Select 3',
      mode = 'n',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon: Select 4',
      mode = 'n',
    },
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
  end,
}
