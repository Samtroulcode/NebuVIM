return {
  'zaldih/themery.nvim',
  lazy = false,
  dependencies = {
    { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },
    { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
    { 'rebelot/kanagawa.nvim', lazy = false, priority = 1000 },
  },
  opts = {
    themes = {
      'catppuccin-mocha',
      'catppuccin-macchiato',
      'catppuccin-frappe',
      'tokyonight-night',
      'tokyonight-moon',
      'tokyonight-storm',
      'kanagawa-dragon',
      'kanagawa-wave',
    },
    livePreview = true, -- prévisualisation
  },
  keys = {
    { '<leader>st', '<cmd>Themery<cr>', desc = '[S]earch [T]hemes' },
  },
}
