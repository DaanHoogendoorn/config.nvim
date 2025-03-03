return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = false,
  config = function()
    require('refactoring').setup {}

    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      require('refactoring').select_refactor { prefer_ex_cmd = true }
    end)
  end,
}
