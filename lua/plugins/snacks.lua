local dashboard = require 'config.snacks.dashboard'

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = function()
      local keys = require('options.keybinds').keys
      local ret = vim.deepcopy(keys.explorer)
      vim.list_extend(ret, keys.picker)
      vim.list_extend(ret, keys.words)
      vim.list_extend(ret, keys.zen)
      return ret
    end,
    init = dashboard.init,
    opts = {
      bigfile = { enabled = true },
      dashboard = dashboard.opts(),
      explorer = { enabled = true },
      image = {
        enabled = true,
        resolve = function(path, src)
          local api = require 'obsidian.api'
          if api.path_is_note(path) then
            return api.resolve_attachment_path(src)
          end
        end,
      },
      indent = { enabled = true },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
  },
}
