return {
  'neovim/nvim-lspconfig',
  enabled = false,
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',

    { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
  },
  config = function()
    local servers = require('config.utils').get_config_lsp_names()
    local ensure_installed = {
      'stylua',
      'prettier',
      'prettierd',
      'eslint',
      'css_variables',
      'phpcs',
      'php-cs-fixer',
    }

    ensure_installed = vim.tbl_extend('force', servers, ensure_installed)

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    vim.lsp.enable(servers)
  end,
}
