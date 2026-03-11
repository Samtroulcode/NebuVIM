-- NebuVim plugin keymap specs.
-- Lazy plugin specs import these tables to keep key declarations centralized.

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
    { '<leader>eg', function() Snacks.picker.git_status() end, desc = 'Explorer Git Status' },
    { '<leader>eb', function() Snacks.picker.buffers() end, desc = 'Explorer Buffers' },
  },
  yazi = {
    { '<leader>ey', '<cmd>Yazi<CR>', desc = 'Explorer Yazi' },
  },
  picker = {
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Search Help' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Search Keymaps' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'Search Files' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = 'Search Pickers' },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Search Current Word',
    },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Search Grep' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Search Diagnostics' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Search Resume' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = 'Search Recent Files' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'Search Buffers' },
    { '<leader>sm', function() Snacks.picker.man() end, desc = 'Search Man Pages' },
    { '<leader>sp', '<cmd>NeovimProjectDiscover<CR>', desc = 'Search Projects' },
    {
      '<leader>si',
      function()
        Snacks.picker.recent { filter = { cwd = true } }
      end,
      desc = 'Search Project History',
    },
    { '<leader>/', function() Snacks.picker.lines() end, desc = 'Search Buffer Lines' },
    { '<leader>s/', helpers.grep_open_files, desc = 'Search Open Files' },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Search Neovim Config',
    },
  },
  conform = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Format Buffer',
    },
    { '<leader>fi', '<cmd>ConformInfo<CR>', desc = 'Format Info' },
  },
  lazygit = {
    { '<leader>gl', '<cmd>LazyGit<CR>', desc = 'Git LazyGit' },
  },
  bufferline = {
    { '<leader>bP', '<cmd>BufferLinePick<CR>', desc = 'Buffer Pick' },
    { '<leader>bh', '<cmd>BufferLineCloseLeft<CR>', desc = 'Buffer Close Left' },
    { '<leader>bl', '<cmd>BufferLineCloseRight<CR>', desc = 'Buffer Close Right' },
    { '<leader>bH', '<cmd>BufferLineMovePrev<CR>', desc = 'Buffer Move Left' },
    { '<leader>bL', '<cmd>BufferLineMoveNext<CR>', desc = 'Buffer Move Right' },
  },
  copilot = {
    { '<leader>cc', '<cmd>CopilotChatToggle<CR>', desc = 'Copilot Toggle Chat' },
    { '<leader>ce', '<cmd>CopilotChatExplain<CR>', desc = 'Copilot Explain' },
    { '<leader>cf', '<cmd>CopilotChatFix<CR>', desc = 'Copilot Fix' },
    { '<leader>cb', '<cmd>CopilotChat Brainstorm<CR>', desc = 'Copilot Brainstorm' },
  },
  toggle = {
    {
      '<leader>tc',
      function()
        require('config.copilot').toggle_completion()
      end,
      desc = 'Copilot Toggle Completion',
    },
  },
  love = {
    { '<leader>lv', '<cmd>LoveRun<CR>', desc = 'Love Run' },
    { '<leader>ls', '<cmd>LoveStop<CR>', desc = 'Love Stop' },
  },
  todo = {
    { '<leader>st', function() Snacks.picker.pick 'todo_comments' end, desc = 'Search Todos' },
    { '<leader>tq', '<cmd>TodoQuickFix<CR>', desc = 'Toggle Todo Quickfix' },
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Todo Next' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Todo Previous' },
  },
  words = {
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Words Next Reference' },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Words Previous Reference' },
  },
  zen = {
    { '<leader>tz', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
  },
  render_markdown = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', desc = 'Toggle Markdown Render' },
  },
  text_case = {
    { '<leader>xs', function() require('textcase').current_word 'to_snake_case' end, desc = 'Text Snake Case' },
    { '<leader>xc', function() require('textcase').current_word 'to_camel_case' end, desc = 'Text Camel Case' },
    { '<leader>xp', function() require('textcase').current_word 'to_pascal_case' end, desc = 'Text Pascal Case' },
    { '<leader>xu', function() require('textcase').current_word 'to_upper_case' end, desc = 'Text Upper Case' },
  },
  obsidian = {
    { '<leader>no', '<cmd>Obsidian open<CR>', desc = 'Obsidian Open App' },
    { '<leader>nq', '<cmd>Obsidian quick_switch<CR>', desc = 'Obsidian Quick Switch' },
    { '<leader>ns', '<cmd>Obsidian search<CR>', desc = 'Obsidian Search Notes' },
    { '<leader>na', '<cmd>Obsidian dailies<CR>', desc = 'Obsidian Dailies' },
    { '<leader>nn', '<cmd>Obsidian new<CR>', desc = 'Obsidian New Note' },
    { '<leader>nN', '<cmd>Obsidian new_from_template<CR>', desc = 'Obsidian New From Template' },
    { '<leader>nd', '<cmd>Obsidian today<CR>', desc = 'Obsidian Daily Note' },
    { '<leader>ny', '<cmd>Obsidian yesterday<CR>', desc = 'Obsidian Yesterday' },
    { '<leader>nt', '<cmd>Obsidian tomorrow<CR>', desc = 'Obsidian Tomorrow' },
    { '<leader>nw', '<cmd>Obsidian workspace<CR>', desc = 'Obsidian Workspace' },
    { '<leader>nb', '<cmd>Obsidian backlinks<CR>', desc = 'Obsidian Backlinks' },
    { '<leader>nk', '<cmd>Obsidian links<CR>', desc = 'Obsidian Note Links' },
    { '<leader>nl', '<cmd>Obsidian link<CR>', mode = 'v', desc = 'Obsidian Link Selection' },
    { '<leader>nL', '<cmd>Obsidian link_new<CR>', mode = 'v', desc = 'Obsidian New Linked Note' },
    { '<leader>ne', '<cmd>Obsidian extract_note<CR>', mode = 'v', desc = 'Obsidian Extract Note' },
    { '<leader>nr', '<cmd>Obsidian rename<CR>', desc = 'Obsidian Rename Note' },
    { '<leader>nR', '<cmd>Obsidian rename<CR>', desc = 'Obsidian Rename Note' },
    { '<leader>np', '<cmd>Obsidian paste_img<CR>', desc = 'Obsidian Paste Image' },
    { '<leader>nf', '<cmd>Obsidian follow_link<CR>', desc = 'Obsidian Follow Link' },
    { '<leader>nT', '<cmd>Obsidian template<CR>', desc = 'Obsidian Insert Template' },
    { '<leader>nc', '<cmd>Obsidian toggle_checkbox<CR>', desc = 'Obsidian Toggle Checkbox' },
    { '<leader>ng', '<cmd>Obsidian tags<CR>', desc = 'Obsidian Tags' },
    { '<leader>nC', '<cmd>Obsidian toc<CR>', desc = 'Obsidian Table Of Contents' },
    { '<leader>nh', '<cmd>Obsidian help<CR>', desc = 'Obsidian Help' },
  },
  project = {
    { '<leader>pp', '<cmd>NeovimProjectDiscover<CR>', desc = 'Project Discover' },
    { '<leader>ph', '<cmd>NeovimProjectHistory<CR>', desc = 'Project History' },
    { '<leader>pr', '<cmd>NeovimProjectLoadRecent<CR>', desc = 'Project Load Recent' },
    { '<leader>pl', '<cmd>NeovimProjectLoad<CR>', desc = 'Project Load' },
  },
}
