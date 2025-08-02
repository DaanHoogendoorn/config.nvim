local check_external_reqs = function()
  vim.health.start 'External Requirements'

  local utils = {
    'git',
    'make',
    'unzip',
    'rg',
    'figlet',
    'tmux',
    'opencode',
  }
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs(utils) do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end

  return true
end

local check_lsp_executables = function()
  local utils = require 'config.utils'
  local lsp_names = utils.get_config_lsp_names()
  vim.health.start 'LSP Executable Checks'
  for _, name in ipairs(lsp_names) do
    local ok, config = pcall(require, 'lsp.' .. name)
    if not ok then
      vim.health.warn(string.format("Could not require lsp config for '%s'", name))
    elseif type(config) ~= 'table' then
      vim.health.warn(string.format("LSP config for '%s' did not return a table", name))
    elseif not config.cmd then
      vim.health.warn(string.format("LSP config for '%s' has no 'cmd' field", name))
    else
      local cmd = config.cmd
      local exe = nil
      if type(cmd) == 'table' then
        exe = cmd[1]
      elseif type(cmd) == 'string' then
        exe = cmd
      end
      if exe then
        if vim.fn.executable(exe) == 1 then
          vim.health.ok(string.format("LSP '%s': Found executable '%s'", name, exe))
        else
          vim.health.warn(string.format("LSP '%s': Could not find executable '%s'", name, exe))
        end
      else
        vim.health.warn(string.format("LSP config for '%s' has invalid 'cmd' field", name))
      end
    end
  end
end

local check_conform_executables = function()
  local ok, conform = pcall(require, 'conform')
  if not ok or not conform then
    vim.health.warn 'conform.nvim is not installed'
    return
  end
  vim.health.start 'Conform.nvim Formatter Executable Checks'
  local formatters = conform.list_all_formatters and conform.list_all_formatters() or {}
  for _, info in ipairs(formatters) do
    local name = info.name or info
    local fmt_info = conform.get_formatter_info and conform.get_formatter_info(name) or nil
    local cmd = fmt_info and fmt_info.command or nil
    local exe = nil
    if type(cmd) == 'table' then
      exe = cmd[1]
    elseif type(cmd) == 'string' then
      exe = cmd
    end
    if exe then
      if vim.fn.executable(exe) == 1 then
        vim.health.ok(string.format("Formatter '%s': Found executable '%s'", name, exe))
      else
        vim.health.warn(string.format("Formatter '%s': Could not find executable '%s'", name, exe))
      end
    else
      vim.health.warn(string.format("Formatter '%s': No command found to check", name))
    end
  end
end

return {
  check = function()
    vim.health.start 'Neovim Configuration'

    local uv = vim.uv or vim.loop
    vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

    check_external_reqs()
    check_lsp_executables()
    check_conform_executables()
  end,
}
