return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- 'folke/tokyonight.nvim',
  'catppuccin/nvim',
  name = 'catppuccin',
  -- 'rebelot/kanagawa.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('catppuccin').setup {
      styles = {
        -- comments = { italic = false }, -- Disable italics in comments
      },
    }

    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- or for kanagawa : 'kanagawa-wave', 'kanagawa-lotus', 'kanagawa-dragon'
    -- and catppuccin : 'catppuccin-mocha', 'catppuccin-frappe', 'catppuccin-latte', 'catppuccin-macchiato'
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
