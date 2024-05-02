return {
  'rmagatti/auto-session',
  lazy = false,
  config = function()
    require('auto-session').setup {
      auto_sessions_suppress_dirs = { '~/Downloads' },
    }
  end,
}
