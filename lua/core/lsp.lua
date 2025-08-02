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

-- Start all the servers that have a config
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
      return diagnostic.message
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

local function restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd 'edit'
  end, 100)
end

vim.api.nvim_create_user_command('LspRestart', function()
  restart_lsp()
end, {})

local function lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    print '󰅚 No LSP clients attached'
    return
  end

  print('󰒋 LSP Status for buffer ' .. bufnr .. ':')
  print '─────────────────────────────────'

  for i, client in ipairs(clients) do
    print(string.format('󰌘 Client %d: %s (ID: %d)', i, client.name, client.id))
    print('  Root: ' .. (client.config.root_dir or 'N/A'))
    print('  Filetypes: ' .. table.concat(client.config.filetypes or {}, ', '))

    -- Check capabilities
    local caps = client.server_capabilities
    local features = {}
    if caps.completionProvider then
      table.insert(features, 'completion')
    end
    if caps.hoverProvider then
      table.insert(features, 'hover')
    end
    if caps.definitionProvider then
      table.insert(features, 'definition')
    end
    if caps.referencesProvider then
      table.insert(features, 'references')
    end
    if caps.renameProvider then
      table.insert(features, 'rename')
    end
    if caps.codeActionProvider then
      table.insert(features, 'code_action')
    end
    if caps.documentFormattingProvider then
      table.insert(features, 'formatting')
    end

    print('  Features: ' .. table.concat(features, ', '))
    print ''
  end
end

vim.api.nvim_create_user_command('LspStatus', lsp_status, { desc = 'Show detailed LSP status' })

local function check_lsp_capabilities()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    print 'No LSP clients attached'
    return
  end

  for _, client in ipairs(clients) do
    print('Capabilities for ' .. client.name .. ':')
    local caps = client.server_capabilities

    local capability_list = {
      { 'Completion', caps.completionProvider },
      { 'Hover', caps.hoverProvider },
      { 'Signature Help', caps.signatureHelpProvider },
      { 'Go to Definition', caps.definitionProvider },
      { 'Go to Declaration', caps.declarationProvider },
      { 'Go to Implementation', caps.implementationProvider },
      { 'Go to Type Definition', caps.typeDefinitionProvider },
      { 'Find References', caps.referencesProvider },
      { 'Document Highlight', caps.documentHighlightProvider },
      { 'Document Symbol', caps.documentSymbolProvider },
      { 'Workspace Symbol', caps.workspaceSymbolProvider },
      { 'Code Action', caps.codeActionProvider },
      { 'Code Lens', caps.codeLensProvider },
      { 'Document Formatting', caps.documentFormattingProvider },
      { 'Document Range Formatting', caps.documentRangeFormattingProvider },
      { 'Rename', caps.renameProvider },
      { 'Folding Range', caps.foldingRangeProvider },
      { 'Selection Range', caps.selectionRangeProvider },
    }

    for _, cap in ipairs(capability_list) do
      local status = cap[2] and '✓' or '✗'
      print(string.format('  %s %s', status, cap[1]))
    end
    print ''
  end
end

vim.api.nvim_create_user_command('LspCapabilities', check_lsp_capabilities, { desc = 'Show LSP capabilities' })

local function lsp_diagnostics_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    counts[severity] = counts[severity] + 1
  end

  print '󰒡 Diagnostics for current buffer:'
  print('  Errors: ' .. counts.ERROR)
  print('  Warnings: ' .. counts.WARN)
  print('  Info: ' .. counts.INFO)
  print('  Hints: ' .. counts.HINT)
  print('  Total: ' .. #diagnostics)
end

vim.api.nvim_create_user_command('LspDiagnostics', lsp_diagnostics_info, { desc = 'Show LSP diagnostics count' })

local function lsp_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  print '═══════════════════════════════════'
  print '           LSP INFORMATION          '
  print '═══════════════════════════════════'
  print ''

  -- Basic info
  print('󰈙 Language client log: ' .. vim.lsp.get_log_path())
  print('󰈔 Detected filetype: ' .. vim.bo.filetype)
  print('󰈮 Buffer: ' .. bufnr)
  print('󰈔 Root directory: ' .. (vim.fn.getcwd() or 'N/A'))
  print ''

  if #clients == 0 then
    print('󰅚 No LSP clients attached to buffer ' .. bufnr)
    print ''
    print 'Possible reasons:'
    print('  • No language server installed for ' .. vim.bo.filetype)
    print '  • Language server not configured'
    print '  • Not in a project root directory'
    print '  • File type not recognized'
    return
  end

  print('󰒋 LSP clients attached to buffer ' .. bufnr .. ':')
  print '─────────────────────────────────'

  for i, client in ipairs(clients) do
    print(string.format('󰌘 Client %d: %s', i, client.name))
    print('  ID: ' .. client.id)
    print('  Root dir: ' .. (client.config.root_dir or 'Not set'))
    print('  Command: ' .. table.concat(client.config.cmd or {}, ' '))
    print('  Filetypes: ' .. table.concat(client.config.filetypes or {}, ', '))

    -- Server status
    if client.is_stopped() then
      print '  Status: 󰅚 Stopped'
    else
      print '  Status: 󰄬 Running'
    end

    -- Workspace folders
    if client.workspace_folders and #client.workspace_folders > 0 then
      print '  Workspace folders:'
      for _, folder in ipairs(client.workspace_folders) do
        print('    • ' .. folder.name)
      end
    end

    -- Attached buffers count
    local attached_buffers = {}
    for buf, _ in pairs(client.attached_buffers or {}) do
      table.insert(attached_buffers, buf)
    end
    print('  Attached buffers: ' .. #attached_buffers)

    -- Root markers (project root detection)
    local root_markers = client.config.root_markers
    local markers_by_server = nil
    pcall(function()
      markers_by_server = read_root_markers_json and read_root_markers_json() or nil
    end)
    local json_markers = markers_by_server and markers_by_server[client.name] or nil
    if root_markers and #root_markers > 0 then
      print('  Root markers: ' .. table.concat(root_markers, ', '))
    elseif json_markers and #json_markers > 0 then
      print('  Root markers (from .nvim-root-markers.json): ' .. table.concat(json_markers, ', '))
    else
      print '  Root markers: N/A'
    end

    -- Key capabilities
    local caps = client.server_capabilities
    local key_features = {}
    if caps.completionProvider then
      table.insert(key_features, 'completion')
    end
    if caps.hoverProvider then
      table.insert(key_features, 'hover')
    end
    if caps.definitionProvider then
      table.insert(key_features, 'definition')
    end
    if caps.documentFormattingProvider then
      table.insert(key_features, 'formatting')
    end
    if caps.codeActionProvider then
      table.insert(key_features, 'code_action')
    end

    if #key_features > 0 then
      print('  Key features: ' .. table.concat(key_features, ', '))
    end

    print ''
  end

  -- Diagnostics summary
  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics > 0 then
    print '󰒡 Diagnostics Summary:'
    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      counts[severity] = counts[severity] + 1
    end

    print('  󰅚 Errors: ' .. counts.ERROR)
    print('  󰀪 Warnings: ' .. counts.WARN)
    print('  󰋽 Info: ' .. counts.INFO)
    print('  󰌶 Hints: ' .. counts.HINT)
    print('  Total: ' .. #diagnostics)
  else
    print '󰄬 No diagnostics'
  end

  print ''
  print 'Use :LspLog to view detailed logs'
  print 'Use :LspCapabilities for full capability list'
end

-- Create command
vim.api.nvim_create_user_command('LspInfo', lsp_info, { desc = 'Show comprehensive LSP information' })
