return {
  'monaqa/dial.nvim',
  keys = {
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'normal')
      end,
      desc = 'Dial increment',
      mode = 'n',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'normal')
      end,
      desc = 'Dial decrement',
      mode = 'n',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gnormal')
      end,
      desc = 'Dial g-increment',
      mode = 'n',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gnormal')
      end,
      desc = 'Dial g-decrement',
      mode = 'n',
    },
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'visual')
      end,
      desc = 'Dial increment',
      mode = 'v',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'visual')
      end,
      desc = 'Dial decrement',
      mode = 'v',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gvisual')
      end,
      desc = 'Dial g-increment',
      mode = 'v',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gvisual')
      end,
      desc = 'Dial g-decrement',
      mode = 'v',
    },
  },
  config = function()
    local augend = require 'dial.augend'
    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d'],
        augend.date.alias['%H:%M'],
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
  end,
}
