return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    transparent_background = false,
  },
  config = function(_, opts)
    local catppuccin = require 'catppuccin'
    catppuccin.setup(opts)
    vim.cmd.colorscheme 'catppuccin'
    local function style_minitabline()
      local pal = require('catppuccin.palettes').get_palette(vim.g.catppuccin_flavour or 'mocha')

      vim.api.nvim_set_hl(0, 'MiniTablineFill', { bg = pal.mantle, fg = pal.overlay0 })
      vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { bg = pal.blue, fg = pal.base, bold = true, nocombine = true })
      vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { bg = pal.blue, fg = pal.base, bold = true, nocombine = true })
      vim.api.nvim_set_hl(0, 'MiniTablineVisible', { bg = pal.surface0, fg = pal.subtext0 })
      vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { bg = pal.surface0, fg = pal.yellow })
      vim.api.nvim_set_hl(0, 'MiniTablineHidden', { bg = pal.surface0, fg = pal.overlay1 })
      vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { bg = pal.surface0, fg = pal.yellow })
      vim.api.nvim_set_hl(0, 'MiniTablineTabpagesection', { bg = pal.mantle, fg = pal.text, bold = true })
      vim.api.nvim_set_hl(0, 'MiniTablineTrunc', { bg = pal.mantle, fg = pal.overlay0 })
    end

    style_minitabline()
    vim.api.nvim_create_autocmd('ColorScheme', { callback = style_minitabline })
  end,
}
