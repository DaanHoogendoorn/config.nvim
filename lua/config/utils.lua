local M = {}

--- Selects text between two positions in the current buffer.
--- @param pos_start table The starting position {line, col, off}
--- @param pos_end table The ending position {line, col, off}
M.select_between = function(pos_start, pos_end)
  vim.api.nvim_win_set_cursor(0, pos_start)
  vim.cmd 'normal! v'
  vim.api.nvim_win_set_cursor(0, pos_end)
end

M.get_config_lsp_names = function()
  local directory = vim.fn.stdpath 'config' .. '/after/lsp/'
  local files = vim.fn.glob(directory .. '*.lua', true, true)
  local names = {}
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ':t:r')
    table.insert(names, name)
  end
  return names
end

return M
