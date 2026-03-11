return {
  'coffebar/neovim-project',
  event = 'VeryLazy',
  cmd = {
    'NeovimProjectDiscover',
    'NeovimProjectHistory',
    'NeovimProjectLoadRecent',
    'NeovimProjectLoad',
  },
  keys = require('options.keybinds').keys.project,
  opts = {
    projects = { -- define project roots
      '~/Storage/SDA/dev/*/*',
      '~/exercism/*',
      '~/.config/*',
      '~/Godot/*',
      '~/dotfiles/',
    },
    dashboard_mode = true,
    picker = {
      type = 'snacks',
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'Shatur/neovim-session-manager' },
  },
}
