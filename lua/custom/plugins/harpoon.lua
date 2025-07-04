return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>!', function()
      harpoon:list():replace_at(1)
    end, { silent = true, desc = 'Harpoon: Replace 1' })
    vim.keymap.set('n', '<leader>@', function()
      harpoon:list():replace_at(2)
    end, { silent = true, desc = 'Harpoon: Replace 2' })
    vim.keymap.set('n', '<leader>#', function()
      harpoon:list():replace_at(3)
    end, { silent = true, desc = 'Harpoon: Replace 3' })
    vim.keymap.set('n', '<leader>$', function()
      harpoon:list():replace_at(4)
    end, { silent = true, desc = 'Harpoon: Replace 4' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { silent = true, desc = 'Harpoon: Select 1' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { silent = true, desc = 'Harpoon: Select 2' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { silent = true, desc = 'Harpoon: Select 3' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { silent = true, desc = 'Harpoon: Select 4' })
  end,
}
