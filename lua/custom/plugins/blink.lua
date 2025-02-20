return {
  {
    'saghen/blink.compat',
    opts = {
      impersonate_nvim_cmp = true,
    },
  },
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
      'saadparwaiz1/cmp_luasnip',
    },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
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
        default = { 'lsp', 'path', 'snippets', 'buffer', 'px-to-rem', 'lazydev' },
        providers = {
          lazydev = {
            name = 'lazydev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          ['px-to-rem'] = {
            name = 'px-to-rem',
            module = 'blink.compat.source',
          },
        },
      },
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefining it
    opts_extend = { 'sources.completion.enabled_providers' },
  },
}
