local M = {}

--- Selects text between two positions in the current buffer.
--- @param pos_start table The starting position {line, col, off}
--- @param pos_end table The ending position {line, col, off}
M.select_between = function(pos_start, pos_end)
  vim.api.nvim_win_set_cursor(0, pos_start)
  vim.cmd 'normal! v'
  vim.api.nvim_win_set_cursor(0, pos_end)
end

return M
