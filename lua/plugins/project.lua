return {
  'coffebar/neovim-project',
  event = 'VeryLazy',
  opts = {
    projects = { -- define project roots
      '~/Documents/dev/*/*',
      '~/exercism/*',
      '~/.config/*',
    },
    dashboard_mode = true,
    picker = {
      type = 'fzf-lua', -- one of "telescope", "fzf-lua", or "snacks"
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
