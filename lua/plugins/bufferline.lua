return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy', -- ou lazy = false si tu veux l’avoir dès le start
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>bse', ':BufferLineSortByExtension<cr>', desc = '[B]uffer [S]ort by [E]xtension' },
    { '<leader>bsd', ':BufferLineSortByDirectory<cr>', desc = '[B]uffer [S]ort by [D]irectory' },
    { '<leader>bst', ':BufferLineSortByTabs<cr>', desc = '[B]uffer [S]ort by [T]abs' },
    { '<leader>bd', ':bd!<cr>', desc = '[B]uffer [D]elete' },
    { '<leader>bo', ':BufferLineCloseOthers<cr>', desc = '[B]uffer delete [O]thers' },
    { '<leader>bn', ':bnext<cr>', desc = '[B]uffer [N]ext' },
    { '<leader>bp', ':bprevious<cr>', desc = '[B]uffer [P]revious' },
    { '<M-h>', ':bprevious<cr>', desc = '[P]revious buffer' },
    { '<M-l>', ':bnext<cr>', desc = '[N]ext buffer' },
  },
  opts = { -- lazy va faire: require("bufferline").setup(opts)
    options = {
      -- choix courants (facultatifs)
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      separator_style = 'thick',
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
      offsets = {
        { filetype = 'neo-tree', text = 'Explorer', text_align = 'left', separator = true },
      },
      -- TODO: Activer les diagnostics sur les bufferlines serait un plus
      -- diagnostics_indicator = function(diagnostics_dict)
      --   local s = ' '
      --   for e, n in pairs(diagnostics_dict) do
      --     local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
      --     s = s .. n .. sym
      --   end
      --   return s
      -- end,
    },
  },
}
