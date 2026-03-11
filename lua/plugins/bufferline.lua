-- NebuVim bufferline integration.
-- Bufferline owns the tabline so buffer navigation stays visible and discoverable.

return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = require('options.keybinds').keys.bufferline,
  opts = {
    options = {
      always_show_bufferline = true,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local signs = {
          error = ' ',
          warning = ' ',
          info = ' ',
          hint = ' ',
        }
        local out = {}

        for severity, count in pairs(diagnostics_dict) do
          local sign = signs[severity]
          if sign then
            table.insert(out, count .. sign)
          end
        end

        return #out > 0 and (' ' .. table.concat(out, ' ')) or ''
      end,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
      indicator = {
        style = 'underline',
      },
      mode = 'buffers',
      offsets = {
        {
          filetype = 'snacks_layout_box',
          text = 'Explorer',
          text_align = 'left',
          separator = true,
        },
      },
      separator_style = 'thin',
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
}
