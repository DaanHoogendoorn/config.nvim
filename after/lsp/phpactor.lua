return {
  filetypes = { 'php', 'blade', 'php_only' },
  init_options = {
    ['language_server_worse_reflection.inlay_hints.enable'] = true,
    ['language_server_worse_reflection.inlay_hints.params'] = true,
    ['language_server_worse_reflection.inlay_hints.types'] = true,
  },
  root_markers = { 'wp-config.php', 'composer.json', '.git', '.phpactor.json', '.phpactor.yml' },
}
