return {
  'sudormrfbin/cheatsheet.nvim',
  cmd = { 'Cheatsheet', 'CheatsheetEdit' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>?', '<cmd>Cheatsheet<CR>', desc = 'Search Cheatsheet' },
  },
  opts = {
    bundled_cheatsheets = true,
    bundled_plugin_cheatsheets = true,
    include_only_installed_plugins = true,
  },
}
