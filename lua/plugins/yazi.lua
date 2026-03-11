return {
  {
    'mikavilpas/yazi.nvim',
    version = '*',
    cmd = 'Yazi',
    keys = require('options.keybinds').keys.yazi,
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<F1>',
      },
    },
  },
}
