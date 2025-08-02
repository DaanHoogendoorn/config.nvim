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

return {
  check = function()
    vim.health.start 'Neovim Configuration'

    local uv = vim.uv or vim.loop
    vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

    check_external_reqs()
  end,
}
