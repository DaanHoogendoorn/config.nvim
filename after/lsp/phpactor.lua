local get_root_markers = function()
  local root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' }

  local extra_root_markers_file = vim.fn.getcwd() .. '/.phpactor_root_markers.json'

  if not vim.uv.fs_stat(extra_root_markers_file) then
    return root_markers
  end

  local extra_root_markers = vim.fn.json_decode(vim.fn.readfile(extra_root_markers_file))
  if not extra_root_markers then
    return root_markers
  end

  -- insert extra root markers before the default ones
  for i = #extra_root_markers, 1, -1 do
    table.insert(root_markers, 1, extra_root_markers[i])
  end

  return root_markers
end

return {
  filetypes = { 'php', 'blade', 'php_only' },
  init_options = {
    ['language_server_worse_reflection.inlay_hints.enable'] = true,
    ['language_server_worse_reflection.inlay_hints.params'] = true,
    ['language_server_worse_reflection.inlay_hints.types'] = true,
  },
  root_markers = get_root_markers(),
}
