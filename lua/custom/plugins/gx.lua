return {
  'chrishrb/gx.nvim',
  keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
  cmd = { 'Browse' },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Required for Neovim < 0.10.0
  submodules = false, -- not needed, submodules are required only for tests

  -- you can specify also another config if you want
  config = function()
    require('gx').setup {
      handlers = {
        plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true, -- open github issues
        brewfile = true, -- open Homebrew formulaes and casks
        package_json = true, -- open dependencies from package.json
        search = true, -- search the web/selection on the web if nothing else is found
        go = true, -- open pkg.go.dev from an import statement (uses treesitter)
        rust = { -- custom handler to open rust's cargo packages
          name = 'rust', -- set name of handler
          filetype = { 'toml' }, -- you can also set the required filetype for this handler
          filename = 'Cargo.toml', -- or the necessary filename
          handle = function(mode, line, _)
            local crate = require('gx.helper').find(line, mode, '(%w+)%s-=%s')

            if crate then
              return 'https://crates.io/crates/' .. crate
            end
          end,
        },
      },
      handler_options = {
        search_engine = 'google', -- you can select between google, bing, duckduckgo, ecosia and yandex
      },
    }
  end,
}
