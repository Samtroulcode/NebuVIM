-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoQuickFix', 'TodoLocList' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = require('options.keybinds').keys.todo,
  opts = { signs = false },
}
