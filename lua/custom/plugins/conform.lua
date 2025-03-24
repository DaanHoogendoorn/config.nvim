return { -- Autoformat
  'stevearc/conform.nvim',
  event = 'BufRead',
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true, stop_after_first = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        stop_after_first = true,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      php = { 'pint', 'php_cs_fixer', 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      xml = { 'prettierd', 'prettier', stop_after_first = true },
      rust = { 'rustfmt' },
    },
  },
}
