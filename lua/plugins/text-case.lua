-- https://github.com/johmsalas/text-case.nvim?tab=readme-ov-file
return {
  'johmsalas/text-case.nvim',
  event = 'VeryLazy',
  cmd = { 'Subs' },
  keys = require('options.keybinds').keys.text_case,
  opts = {},
}
