---@brief
---
--- https://github.com/phpactor/phpactor
---
--- Installation: https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation

return {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php', 'blade', 'php_only' },
  init_options = {
    ['language_server_worse_reflection.inlay_hints.enable'] = true,
    ['language_server_worse_reflection.inlay_hints.params'] = true,
    ['language_server_worse_reflection.inlay_hints.types'] = true,
  },
  root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' },
  workspace_required = true,
}
