local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets(nil, {
  scss = {
    snip({
      trig = '@bb',
      namr = 'Break below',
      dscr = '@include break-below($size)',
    }, {
      text { '@include break-below(' },
      insert(1),
      text { ') {', '\t' },
      insert(2),
      text { '', '}' },
    }),

    snip({
      trig = '@ba',
      namr = 'Break above',
      dscr = '@include break-above($size)',
    }, {
      text { '@include break-above(' },
      insert(1),
      text { ') {', '\t' },
      insert(2),
      text { '', '}' },
    }),

    snip({
      trig = 'pc1',
      namr = 'Palette color 1',
      dscr = 'Palette color 1',
    }, {
      text { 'var(--palette-color-1)' },
    }),

    snip({
      trig = 'pc2',
      namr = 'Palette color 2',
      dscr = 'Palette color 2',
    }, {
      text { 'var(--palette-color-2)' },
    }),

    snip({
      trig = 'pc3',
      namr = 'Palette color 3',
      dscr = 'Palette color 3',
    }, {
      text { 'var(--palette-color-3)' },
    }),

    snip({
      trig = 'pc4',
      namr = 'Palette color 4',
      dscr = 'Palette color 4',
    }, {
      text { 'var(--palette-color-4)' },
    }),

    snip({
      trig = 'pc5',
      namr = 'Palette color 5',
      dscr = 'Palette color 5',
    }, {
      text { 'var(--palette-color-5)' },
    }),

    snip({
      trig = 'pc6',
      namr = 'Palette color 6',
      dscr = 'Palette color 6',
    }, {
      text { 'var(--palette-color-6)' },
    }),

    snip({
      trig = 'pc7',
      namr = 'Palette color 7',
      dscr = 'Palette color 7',
    }, {
      text { 'var(--palette-color-7)' },
    }),

    snip({
      trig = 'pc8',
      namr = 'Palette color 8',
      dscr = 'Palette color 8',
    }, {
      text { 'var(--palette-color-8)' },
    }),
  },
})
