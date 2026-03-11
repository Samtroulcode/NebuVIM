-- Core NebuVim keymaps.
-- This module owns only editor-native mappings loaded during startup.

local helpers = require 'options.keybinds.helpers'

local M = {}

function M.setup()
  helpers.map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear Search Highlight' })
  helpers.map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics List' })

  helpers.map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Terminal Normal Mode' })
  helpers.map('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Terminal Window Left' })
  helpers.map('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Terminal Window Down' })
  helpers.map('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Terminal Window Up' })
  helpers.map('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Terminal Window Right' })

  helpers.map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Window Height Increase', silent = true })
  helpers.map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Window Height Decrease', silent = true })
  helpers.map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Window Width Decrease', silent = true })
  helpers.map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Window Width Increase', silent = true })

  helpers.map('n', '<leader>bd', '<cmd>bd!<CR>', { desc = 'Buffer Delete' })
  helpers.map('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', { desc = 'Buffer Delete Others' })
  helpers.map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Buffer Next' })
  helpers.map('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Buffer Previous' })
  helpers.map('n', 'gB', '<cmd>bprevious<CR>', { desc = 'Buffer Previous' })
  helpers.map('n', 'gb', helpers.next_buffer_or_index, { desc = 'Buffer Next Or Index' })

  helpers.map('n', '<leader>ts', helpers.toggle_spell, { desc = 'Toggle Spellcheck' })
end

return M
