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
  local directory = vim.fn.stdpath 'config' .. '/lsp/'
  local files = vim.fn.glob(directory .. '*.lua', true, true)
  local names = {}
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ':t:r')
    table.insert(names, name)
  end
  return names
end

--- Merge two lists, preserving order and uniqueness.
--- @param orig table The original list (table)
--- @param extra table The list to merge in (table)
--- @return table Merged list with unique values, original order preserved
M.merge_unique = function(orig, extra)
  local seen = {}
  local result = {}
  for _, v in ipairs(orig or {}) do
    table.insert(result, v)
    seen[v] = true
  end
  for _, v in ipairs(extra or {}) do
    if not seen[v] then
      table.insert(result, v)
      seen[v] = true
    end
  end
  return result
end

--- Get the path to the typescript server.
--- @see lspconfig https://github.com/neovim/nvim-lspconfig/blob/f0c6ccf43997a1c7e9ec4aea36ffbf2ddd9f15ef/lua/lspconfig/util.lua#L89
---
--- @param root_dir string The root directory of the project
--- @return string The path to the typescript server
M.get_typescript_server_path = function(root_dir)
  local project_roots = vim.fs.find('node_modules', { path = root_dir, upward = true, limit = math.huge })
  for _, project_root in ipairs(project_roots) do
    local typescript_path = project_root .. '/typescript'
    local stat = vim.loop.fs_stat(typescript_path)
    if stat and stat.type == 'directory' then
      return typescript_path .. '/lib'
    end
  end
  return ''
end

return M
