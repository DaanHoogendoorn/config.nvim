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
  config = function()
    require('conform').setup {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        local disable_filetypes = { c = true, cpp = true, blade = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          stop_after_first = true,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'php_cs_fixer', 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        xml = { 'prettierd', 'prettier', stop_after_first = true },
        rust = { 'rustfmt' },
      },
      formatters = {
        php_cs_fixer = {
          command = vim.fn.exepath 'php-cs-fixer',
          args = { 'fix', '$FILENAME' },
        },
      },
    }

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    Snacks.toggle
      .new({
        name = 'Autoformat',
        get = function()
          return not vim.g.disable_autoformat
        end,
        set = function(state)
          if state == not vim.g.disable_autoformat then
            return
          end

          vim.g.disable_autoformat = not state
        end,
      })
      :map '<leader>tf'
  end,
}
