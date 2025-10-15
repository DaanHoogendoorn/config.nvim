return {
  'DaanHoogendoorn/px-to-rem.nvim',
  lazy = false,
  dev = true,
  ---@type PxToRemConfig
  opts = {
    notify = false,
    integrations = {
      vscode_cipchk_cssrem = true,
    },
  },
}
