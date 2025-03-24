return {
  'monaqa/dial.nvim',
  event = 'VeryLazy',
  config = function()
    local augend = require 'dial.augend'

    require('dial.config').augends:register_group {
      default = {
        augend.constant.new {
          elements = { 'true', 'false' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'yes', 'no' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'and', 'or' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { '&&', '||' },
          word = false,
          cyclic = true,
        },
      },
    }

    vim.keymap.set('n', '<C-a>', function()
      require('dial.map').manipulate('increment', 'normal')
    end)
    vim.keymap.set('n', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'normal')
    end)
    vim.keymap.set('n', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gnormal')
    end)
    vim.keymap.set('n', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gnormal')
    end)
    vim.keymap.set('v', '<C-a>', function()
      require('dial.map').manipulate('increment', 'visual')
    end)
    vim.keymap.set('v', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'visual')
    end)
    vim.keymap.set('v', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gvisual')
    end)
    vim.keymap.set('v', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gvisual')
    end)
  end,
}
