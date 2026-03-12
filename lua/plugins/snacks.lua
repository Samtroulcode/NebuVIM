return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = function()
      local keys = require('options.keybinds').keys
      local ret = vim.deepcopy(keys.explorer)
      vim.list_extend(ret, keys.picker)
      vim.list_extend(ret, keys.scratch)
      vim.list_extend(ret, keys.toggle)
      vim.list_extend(ret, keys.words)
      vim.list_extend(ret, keys.zen)
      return ret
    end,
    init = function()
      require('config.snacks.dashboard').init()
    end,
    opts = function()
      local dashboard = require 'config.snacks.dashboard'

      return {
        -- Core comfort modules are enabled here only when they add UX value without
        -- overlapping stronger dedicated plugins such as Noice or Yazi.
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
        animate = { enabled = true },
        indent = { enabled = true },
        input = { enabled = false },
        notifier = { enabled = false },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scratch = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        zen = { enabled = true },
      }
    end,
  },
}
