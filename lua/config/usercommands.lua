-- Add an alias for the Lazy command: `:Lazy` to `:L`
vim.api.nvim_create_user_command('L', function()
  vim.cmd 'Lazy'
end, { desc = 'Lazy.nvim' })

-- Add a config import command that loads the LSP config from the nvim-lspconfig repo
vim.api.nvim_create_user_command('LspConfigImport', function(command)
  local args = command.fargs
  local lsp_name = args[1]
  local target_path = vim.fn.stdpath 'config' .. '/lsp/' .. lsp_name .. '.lua'

  local file_url = string.format('https://raw.githubusercontent.com/neovim/nvim-lspconfig/refs/heads/master/lsp/%s.lua', lsp_name)
  local file_content = vim.fn.systemlist { 'curl', '-s', file_url }

  -- Show error if curl fails or file is empty or the content is `404: Not Found`
  if file_content[1] == '' or file_content[1] == '404: Not Found' then
    vim.notify(string.format('Failed to import LSP config for %s', lsp_name), vim.log.levels.ERROR)
    return
  end

  -- Write the file content to the target path
  vim.fn.writefile(file_content, target_path)

  -- Open the file in a new buffer
  vim.cmd(string.format('e %s', target_path))

  -- Format the buffer
  require('conform').format { async = true, lsp_fallback = true, stop_after_first = true }
  vim.cmd 'silent! w'

  -- Notify the user
  vim.notify(string.format('Imported LSP config for %s', lsp_name), vim.log.levels.INFO)
end, {
  desc = 'Import LSP config from nvim-lspconfig',
  nargs = 1,
  complete = function(arg_lead, _, _)
    local servers = require('config.utils').get_config_lsp_names()

    -- Filter server names based on the current input
    local matches = {}
    for _, server in ipairs(servers) do
      -- If arg_lead is empty or the server name starts with arg_lead
      if arg_lead == '' or string.find(server, '^' .. arg_lead) then
        table.insert(matches, server)
      end
    end

    return matches
  end,
})
