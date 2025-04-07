return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',

    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ctions')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities(capabilities))

    local tsserver_inlay_hints_settings = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
    }

    local servers = {
      ts_ls = {
        settings = {
          javascript = {
            inlayHints = tsserver_inlay_hints_settings,
          },
          javascriptreact = {
            inlayHints = tsserver_inlay_hints_settings,
          },
          typescript = {
            inlayHints = tsserver_inlay_hints_settings,
          },
          typescriptreact = {
            inlayHints = tsserver_inlay_hints_settings,
          },
        },
      },
      phpactor = {
        filetypes = { 'php', 'blade', 'php_only' },
        init_options = {
          ['language_server_worse_reflection.inlay_hints.enable'] = true,
          ['language_server_worse_reflection.inlay_hints.params'] = true,
          ['language_server_worse_reflection.inlay_hints.types'] = true,
        },
      },
      emmet_language_server = {
        filetypes = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'php', 'blade', 'php_only', 'twig' },
      },
      cssls = {},
      somesass_ls = {},
      html = {},
      jsonls = {
        settings = {
          validate = { enable = true },
        },
      },
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            inlayHints = {
              typeHints = true,
              parameterHints = true,
              chainingHints = true,
              maxLength = 120,
            },
          },
        },
      },
      marksman = {},
      yamlls = {},
      harper_ls = {},
      --

      ['sonarlint-language-server'] = {},

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            hint = {
              enable = true,
            },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'prettier',
      'prettierd',
      'phpactor',
      'ts_ls',
      'emmet-language-server',
      'cssls',
      'html',
      'eslint',
      'css_variables',
      'phpcs',
      'php-cs-fixer',
      'jsonls',
      'sonarlint-language-server',
      'somesass_ls',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
