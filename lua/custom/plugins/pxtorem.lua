return {
  dir = '~/Documents/Dev/px-to-rem.nvim/',
  event = 'BufRead',
  config = function()
    require('px-to-rem').setup {
      integrations = {
        cmp = true,
        vscode_cipchk_cssrem = true,
      },
    }
  end,
}
