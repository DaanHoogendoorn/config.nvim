return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        init = function()
          require 'custom.config.snippets'
        end,
      },
    },

    -- use a release tag to download pre-built binaries
    version = 'v1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },

      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      signature = {
        enabled = true,
      },

      snippets = {
        preset = 'luasnip',
      },

      sources = {
        default = { 'lsp', 'lazydev', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'lazydev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefining it
    opts_extend = { 'sources.completion.enabled_providers' },
  },
}
