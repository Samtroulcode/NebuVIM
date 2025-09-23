return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    float = {
      solid = false,
      transparent = true,
    },
    auto_integrations = true,
  },
  config = function(_, opts)
    local catppuccin = require 'catppuccin'
    catppuccin.setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
