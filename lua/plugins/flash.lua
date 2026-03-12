-- NebuVim flash.nvim integration.
-- Flash owns the short `s` motions while surround stays on `gs*`, matching modern Neovim layouts.

return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = require('options.keybinds').keys.flash,
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
  },
  {
    'folke/snacks.nvim',
    optional = true,
    opts = function(_, opts)
      -- Keep Flash available inside Snacks picker so `s` behaves consistently
      -- in normal picker windows and in the editor.
      opts.picker = opts.picker or {}
      opts.picker.win = opts.picker.win or {}
      opts.picker.win.input = opts.picker.win.input or {}
      opts.picker.win.input.keys = opts.picker.win.input.keys or {}
      opts.picker.actions = opts.picker.actions or {}

      opts.picker.win.input.keys['<A-s>'] = { 'flash', mode = { 'n', 'i' } }
      opts.picker.win.input.keys.s = { 'flash' }

      opts.picker.actions.flash = function(picker)
        require('flash').jump {
          pattern = '^',
          label = { after = { 0, 0 } },
          search = {
            mode = 'search',
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
              end,
            },
          },
          action = function(match)
            local idx = picker.list:row2idx(match.pos[1])
            picker.list:_move(idx, true, true)
          end,
        }
      end
    end,
  },
}
