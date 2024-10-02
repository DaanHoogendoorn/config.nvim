local utils = require 'custom.config.utils'

local M = {}

--- @class SelectQuotesOptions
--- @field key string?
M.options = {
  key = 'q',
}

--- Setup function for select quotes
--- @param options SelectQuotesOptions
M.setup = function(options)
  options = options or {}

  M.options = vim.tbl_deep_extend('force', M.options, options)

  vim.keymap.set('n', 'vi' .. M.options.key, function()
    M.select_quotes(false)
  end, { noremap = true, desc = 'Visually select inside quotes' })

  vim.keymap.set('n', 'va' .. M.options.key, function()
    M.select_quotes(true)
  end, { noremap = true, desc = 'Visually select around quotes' })

  vim.keymap.set('x', 'vi' .. M.options.key, function()
    M.select_quotes(false)
  end, { noremap = true, desc = 'Visually select inside quotes' })

  vim.keymap.set('x', 'va' .. M.options.key, function()
    M.select_quotes(true)
  end, { noremap = true, desc = 'Visually select around quotes' })

  vim.keymap.set('n', 'yi' .. M.options.key, function()
    M.select_quotes(false)
    vim.cmd 'normal y'
  end, { noremap = true, desc = 'Yank inside quotes' })

  vim.keymap.set('n', 'ya' .. M.options.key, function()
    M.select_quotes(true)
    vim.cmd 'normal y'
  end, { noremap = true, desc = 'Yank around quotes' })
end

--- Function to select around or within quotes
--- @param around boolean
M.select_quotes = function(around)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- Find the start quote by going backwards
  local start_pos = nil
  for i = col, 1, -1 do
    local char = line:sub(i, i)
    if char == "'" or char == '"' or char == '`' then
      start_pos = i
      break
    end
  end

  -- If no quote is found going backwards, search forwards
  if not start_pos then
    for i = col, #line do
      local char = line:sub(i, i)
      if char == "'" or char == '"' or char == '`' then
        start_pos = i
        break
      end
    end
  end

  if not start_pos then
    print 'No starting quote found'
    return
  end

  local start_char = line:sub(start_pos, start_pos)

  -- Find the end quote
  local end_pos = nil
  for i = start_pos + 1, #line do
    local char = line:sub(i, i)
    if char == start_char then
      end_pos = i
      break
    end
  end

  if not end_pos then
    print 'No ending quote found'
    return
  end

  -- Visual select between the quotes
  if around then
    utils.select_between({ row, start_pos - 1 }, { row, end_pos - 1 })
  else
    utils.select_between({ row, start_pos }, { row, end_pos - 2 })
  end
end

return M
