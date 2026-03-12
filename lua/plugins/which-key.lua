-- NebuVim which-key setup.
-- Which-key documents the centralized registry without hijacking fast motion prefixes.

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- Helix preset keeps the popup compact while preserving explicit group labels.
    preset = 'helix',
    delay = 0,
    -- The registry lives outside plugin specs so every binding stays discoverable.
    spec = require('options.keybinds').which_key,
    triggers = {
      { '<auto>', mode = 'nixsotc' },
    },
    win = {
      no_overlap = true,
    },
    keys = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
  },
}
