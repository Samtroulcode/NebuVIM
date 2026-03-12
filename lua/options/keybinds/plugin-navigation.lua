-- Navigation and workspace keymaps exposed to plugin specs.
-- File, project, and movement flows live together to keep the hierarchy obvious.

local helpers = require 'options.keybinds.helpers'

return {
  tmux = {
    { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<CR>', desc = 'Window Left' },
    { '<C-j>', '<cmd><C-U>TmuxNavigateDown<CR>', desc = 'Window Down' },
    { '<C-k>', '<cmd><C-U>TmuxNavigateUp<CR>', desc = 'Window Up' },
    { '<C-l>', '<cmd><C-U>TmuxNavigateRight<CR>', desc = 'Window Right' },
    { '<C-\\>', '<cmd><C-U>TmuxNavigatePrevious<CR>', desc = 'Window Previous' },
  },
  explorer = {
    { '<leader>ee', function() Snacks.explorer() end, desc = 'Explorer Toggle' },
    { '<leader>er', function() Snacks.explorer.reveal() end, desc = 'Explorer Reveal File' },
    { '<leader>eR', function() Snacks.rename.rename_file() end, desc = 'Explorer Rename File' },
    { '<leader>eg', function() Snacks.picker.git_status() end, desc = 'Explorer Git Status' },
    { '<leader>eb', function() Snacks.picker.buffers() end, desc = 'Explorer Buffers [alias]' },
  },
  yazi = {
    { '<leader>ey', '<cmd>Yazi<CR>', desc = 'Explorer Yazi' },
  },
  picker = {
    -- Canonical files/find hierarchy.
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Find Buffers' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Find Recent Files' },
    { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Neovim Config' },
    { '<leader>f/', function() Snacks.picker.lines() end, desc = 'Find Buffer Lines' },

    -- Search namespace keeps grep and inspection flows.
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Search Help' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Search Keymaps' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = 'Search Pickers' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Search Current Word' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Search Grep' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Search Resume' },
    { '<leader>sm', function() Snacks.picker.man() end, desc = 'Search Man Pages' },
    { '<leader>st', function() Snacks.picker.pick 'todo_comments' end, desc = 'Search Todos' },
    { '<leader>s/', helpers.grep_open_files, desc = 'Search Open Files' },

    -- Canonical diagnostics picker.
    { '<leader>xd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics Picker' },

    -- Compatibility aliases during the migration.
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'Find Files [alias]' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics Picker [alias]' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = 'Find Recent Files [alias]' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'Find Buffers [alias]' },
    { '<leader>sp', '<cmd>NeovimProjectDiscover<CR>', desc = 'Project Discover [alias]' },
    { '<leader>si', function() Snacks.picker.recent { filter = { cwd = true } } end, desc = 'Project History [alias]' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = 'Find Buffer Lines [alias]' },
    { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Neovim Config [alias]' },
  },
  lazygit = {
    { '<leader>gl', '<cmd>LazyGit<CR>', desc = 'Git LazyGit' },
  },
  project = {
    { '<leader>pp', '<cmd>NeovimProjectDiscover<CR>', desc = 'Project Discover' },
    { '<leader>ph', '<cmd>NeovimProjectHistory<CR>', desc = 'Project History' },
    { '<leader>pr', '<cmd>NeovimProjectLoadRecent<CR>', desc = 'Project Load Recent' },
    { '<leader>pl', '<cmd>NeovimProjectLoad<CR>', desc = 'Project Load' },
  },
  words = {
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Words Next Reference' },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Words Previous Reference' },
  },
}
