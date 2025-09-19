return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy', -- ou lazy = false si tu veux l’avoir dès le start
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = { -- lazy va faire: require("bufferline").setup(opts)
    options = {
      -- choix courants (facultatifs)
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      separator_style = 'slant',
      offsets = {
        { filetype = 'neo-tree', text = 'Explorer', text_align = 'left', separator = true },
      },
    },
  },
}
