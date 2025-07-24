return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufRead',
  config = function()
    require('treesitter-context').setup {
      enable = true,
      max_lines = 7,
    }
  end,
}
