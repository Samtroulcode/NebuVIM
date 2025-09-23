-- return {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   lazy = false,
--   priority = 1000,
--   opts = {
--     flavour = 'mocha', -- latte, frappe, macchiato, mocha
--     transparent_background = true,
--     float = {
--       solid = false,
--       transparent = true,
--     },
--     auto_integrations = true,
--   },
--   config = function(_, opts)
--     local catppuccin = require 'catppuccin'
--     catppuccin.setup(opts)
--     vim.cmd.colorscheme 'catppuccin'
--   end,
-- }
return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
    -- Overrides conseillés par la doc
    overrides = function(colors)
      local theme = colors.theme
      return {
        -- Transparent Floating Windows
        NormalFloat = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
        FloatBorder = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
        FloatTitle = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
        -- Variante sombre réutilisable (cf. doc)
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        -- Plugins qui lient sur NormalFloat par défaut
        LazyNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },

        -- Dark completion (popup) menu
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
  config = function(_, opts)
    local kanagawa = require 'kanagawa'
    kanagawa.setup(opts)
    vim.cmd.colorscheme 'kanagawa-wave' -- kanagawa, kanagawa-wave, kanagawa-dragon, kanagawa-lotus
  end,
}
