-- NebuVim mini.nvim modules.
-- Small editing primitives live here, with surround aligned to the modern `gs*` convention.

return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  keys = require('options.keybinds').keys.surround,
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.) on `gs*`
    -- so `s` remains dedicated to Flash jump motions.
    --
    -- Examples:
    --  - gsaiw) - [G]o [S]urround [A]dd [I]nner [W]ord [)]paren
    --  - gsd'   - [G]o [S]urround [D]elete [']quotes
    --  - gsr)'  - [G]o [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        suffix_last = 'l',
        suffix_next = 'n',
      },
    }

    -- Move any selection in any direction
    --
    -- <M-hjkl> to move selection
    require('mini.move').setup()

    -- Autopairs, quotes, etc.
    require('mini.pairs').setup()

    -- Dev icons compatibility for plugins expecting nvim-web-devicons.
    require('mini.icons').setup()
    require('mini.icons').mock_nvim_web_devicons()
  end,
}
