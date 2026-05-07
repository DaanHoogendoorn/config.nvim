return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    init = function()
      local ensure_installed = {
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
      }
      require('nvim-treesitter').install(ensure_installed)
    end,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Native incremental selection (replaces old plugin module)
      vim.keymap.set('x', 'v', function()
        require('vim.treesitter._select').select_parent(vim.v.count1)
      end, { desc = 'Expand treesitter selection' })

      vim.keymap.set('x', 'V', function()
        require('vim.treesitter._select').select_child(vim.v.count1)
      end, { desc = 'Shrink treesitter selection' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      -- Disable built-in ftplugin maps to avoid conflicts
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
          include_surrounding_whitespace = false,
        },
      })

      local select = require('nvim-treesitter-textobjects.select')

      local mappings = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aF'] = '@call.outer',
        ['iF'] = '@call.inner',
        ['aC'] = '@class.outer',
        ['iC'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
        ['ic'] = '@comment.inner',
        ['ac'] = '@comment.outer',
      }

      for key, query in pairs(mappings) do
        local query_string = type(query) == 'table' and query.query or query
        local desc = type(query) == 'table' and query.desc or ('Select ' .. query_string)
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(query_string, 'textobjects')
        end, { desc = desc })
      end
    end,
  },
}
