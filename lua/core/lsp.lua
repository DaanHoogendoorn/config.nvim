local utils = require 'config.utils'

--- Reads the .nvim-root-markers.json file from the current working directory.
--- @return table|nil Table mapping server names to marker lists, or nil if not found/invalid.
local function read_root_markers_json()
  local uv = vim.loop
  local cwd = vim.fn.getcwd()
  local path = cwd .. '/.nvim-root-markers.json'
  local fd = uv.fs_open(path, 'r', 438)
  if not fd then
    return nil
  end
  local stat = uv.fs_fstat(fd)
  if not stat then
    uv.fs_close(fd)
    return nil
  end
  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)
  if not data then
    return nil
  end
  local ok, parsed = pcall(vim.fn.json_decode, data)
  if not ok or type(parsed) ~= 'table' then
    return nil
  end
  return parsed
end

--- Updates the LSP config for a given server with extra root markers from JSON.
--- Call this before enabling the server.
--- @param server_name string The LSP server name (as in config)
local function add_project_root_markers(server_name)
  local markers_by_server = read_root_markers_json()
  if not markers_by_server then
    return
  end
  local extra_markers = markers_by_server[server_name]
  if not extra_markers then
    return
  end
  local config = vim.lsp.config[server_name] or {}
  local orig_markers = config.root_markers or {}
  -- Insert extra_markers before orig_markers for higher priority
  local merged = utils.merge_unique(extra_markers, orig_markers)
  vim.lsp.config(server_name, { root_markers = merged })
end

--- Automatically patch and enable only the servers listed in .nvim-root-markers.json
local function adapt_servers_from_root_markers_json()
  local markers_by_server = read_root_markers_json()
  if not markers_by_server then
    return
  end
  for server_name, _ in pairs(markers_by_server) do
    add_project_root_markers(server_name)
  end
end

adapt_servers_from_root_markers_json()

-- Start all the server that have a config
vim.lsp.enable(utils.get_config_lsp_names())

-- Set up diagnostics
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    current_line = true,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', function()
      -- Adds a preview for the code actions
      require('tiny-code-action').code_action()
    end, '[C]ode [A]ctions')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    -- Cursor hold actions
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})
