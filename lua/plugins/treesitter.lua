return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'blade',
        'c',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'php',
        'phpdoc',
        'php_only',
        'typescript',
        'css',
        'scss',
        'json',
        'javascript',
        'jsdoc',
        'regex',
        'rust',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      opts.incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = 'v',
          node_decremental = 'V',
        },
      }

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aF'] = '@call.outer',
              ['iF'] = '@call.inner',
              ['aC'] = '@class.outer',
              ['iC'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              ['ic'] = '@comment.inner',
              ['ac'] = '@comment.outer',
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
              ['ia'] = { query = '@parameter.inner' },
              ['aa'] = { query = '@parameter.outer' },
              ['al'] = { query = '@loop.outer' },
              ['il'] = { query = '@loop.inner' },
              ['a='] = '@assignment.outer',
              ['i='] = '@assignment.inner',
              ['l='] = '@assignment.lhs',
              ['r='] = '@assignment.rhs',
              ['a,'] = '@parameter.outer',
              ['i,'] = '@parameter.inner',
            },
            include_surrounding_whitespace = false,
          },
        },
      }
    end,
  },
}
