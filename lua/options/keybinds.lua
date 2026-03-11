local M = {}

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function buf_map(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = bufnr,
    desc = desc,
  })
end

local function goto_buffer_index(index)
  local info = vim.fn.getbufinfo { buflisted = 1 }

  table.sort(info, function(a, b)
    return a.bufnr < b.bufnr
  end)

  if index >= 1 and index <= #info then
    vim.cmd('buffer ' .. info[index].bufnr)
    return
  end

  vim.notify(('No listed buffer at index %d'):format(index), vim.log.levels.WARN)
end

local function next_buffer_or_index()
  local index = vim.v.count

  if index > 0 then
    goto_buffer_index(index)
    return
  end

  vim.cmd.bnext()
end

local function toggle_spell()
  vim.opt.spell = not vim.opt.spell:get()

  if vim.opt.spell:get() then
    vim.notify('Spellcheck ON (' .. table.concat(vim.opt.spelllang:get(), ',') .. ')', vim.log.levels.INFO)
    return
  end

  vim.notify('Spellcheck OFF', vim.log.levels.INFO)
end

local function grep_open_files()
  Snacks.picker.grep_buffers()
end

function M.setup()
  map('n', '<Esc>', '<cmd>nohlsearch<CR>')
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics List' })

  map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Terminal Normal Mode' })
  map('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Terminal Window Left' })
  map('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Terminal Window Down' })
  map('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Terminal Window Up' })
  map('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Terminal Window Right' })

  map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Window Height Increase', silent = true })
  map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Window Height Decrease', silent = true })
  map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Window Width Decrease', silent = true })
  map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Window Width Increase', silent = true })

  map('n', '<leader>bd', '<cmd>bd!<CR>', { desc = 'Buffer Delete' })
  map('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', { desc = 'Buffer Delete Others' })
  map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Buffer Next' })
  map('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Buffer Previous' })
  map('n', 'gB', '<cmd>bprevious<CR>', { desc = 'Buffer Previous' })
  map('n', 'gb', next_buffer_or_index, { desc = 'Buffer Next Or Index' })

  map('n', '<leader>ts', toggle_spell, { desc = 'Toggle Spellcheck' })
end

function M.close_with_q(bufnr)
  buf_map(bufnr, 'n', 'q', '<cmd>close<CR>', 'Close Window')
end

function M.lsp_attach(event)
  local bufnr = event.buf
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if not client then
    return
  end

  local core = require 'config.lsp'

  buf_map(bufnr, 'n', 'grn', vim.lsp.buf.rename, 'LSP Rename')
  buf_map(bufnr, { 'n', 'x' }, 'gra', vim.lsp.buf.code_action, 'LSP Code Action')
  buf_map(bufnr, 'n', 'grr', function() Snacks.picker.lsp_references() end, 'LSP References')
  buf_map(bufnr, 'n', 'gri', function() Snacks.picker.lsp_implementations() end, 'LSP Implementations')
  buf_map(bufnr, 'n', 'grd', function() Snacks.picker.lsp_definitions() end, 'LSP Definitions')
  buf_map(bufnr, 'n', 'grD', vim.lsp.buf.declaration, 'LSP Declaration')
  buf_map(bufnr, 'n', 'grt', function() Snacks.picker.lsp_type_definitions() end, 'LSP Type Definitions')
  buf_map(bufnr, 'n', 'gO', function() Snacks.picker.lsp_symbols() end, 'LSP Document Symbols')
  buf_map(bufnr, 'n', 'gW', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')
  buf_map(bufnr, 'n', 'K', vim.lsp.buf.hover, 'LSP Hover')

  if core.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
    buf_map(bufnr, 'n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, 'Toggle Inlay Hints')
  end
end

function M.gitsigns_attach(bufnr)
  local gitsigns = require 'gitsigns'

  buf_map(bufnr, 'n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
      return
    end

    gitsigns.nav_hunk 'next'
  end, 'Git Next Change')

  buf_map(bufnr, 'n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
      return
    end

    gitsigns.nav_hunk 'prev'
  end, 'Git Previous Change')

  buf_map(bufnr, 'v', '<leader>gs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, 'Git Stage Hunk')

  buf_map(bufnr, 'v', '<leader>gr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, 'Git Reset Hunk')

  buf_map(bufnr, 'n', '<leader>gs', gitsigns.stage_hunk, 'Git Stage Hunk')
  buf_map(bufnr, 'n', '<leader>gr', gitsigns.reset_hunk, 'Git Reset Hunk')
  buf_map(bufnr, 'n', '<leader>gS', gitsigns.stage_buffer, 'Git Stage Buffer')
  buf_map(bufnr, 'n', '<leader>gu', gitsigns.undo_stage_hunk, 'Git Undo Stage Hunk')
  buf_map(bufnr, 'n', '<leader>gR', gitsigns.reset_buffer, 'Git Reset Buffer')
  buf_map(bufnr, 'n', '<leader>gp', gitsigns.preview_hunk, 'Git Preview Hunk')
  buf_map(bufnr, 'n', '<leader>gb', gitsigns.blame_line, 'Git Blame Line')
  buf_map(bufnr, 'n', '<leader>gd', gitsigns.diffthis, 'Git Diff Index')
  buf_map(bufnr, 'n', '<leader>gD', function()
    gitsigns.diffthis '@'
  end, 'Git Diff Last Commit')
  buf_map(bufnr, 'n', '<leader>gq', gitsigns.setqflist, 'Git Quickfix Hunks')
  buf_map(bufnr, 'n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle Git Blame')
  buf_map(bufnr, 'n', '<leader>tD', gitsigns.toggle_deleted, 'Toggle Git Deleted')
  buf_map(bufnr, 'n', '<leader>tw', gitsigns.toggle_word_diff, 'Toggle Git Word Diff')
  buf_map(bufnr, 'n', '<leader>tl', gitsigns.toggle_linehl, 'Toggle Git Line Highlight')
end

M.which_key = {
  { '<leader>?', desc = 'Search Cheatsheet' },
  { '<leader>b', group = 'Buffers' },
  { '<leader>c', group = 'Copilot' },
  { '<leader>e', group = 'Explorer' },
  { '<leader>f', group = 'Format' },
  { '<leader>g', group = 'Git', mode = { 'n', 'v' } },
  { '<leader>l', group = 'Love' },
  { '<leader>n', group = 'Notifications' },
  { '<leader>o', group = 'Obsidian' },
  { '<leader>p', group = 'Project' },
  { '<leader>s', group = 'Search' },
  { '<leader>t', group = 'Toggle' },
  { '<leader>x', group = 'Text' },
  { 'gr', group = 'LSP' },
}

M.keys = {
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
    { '<leader>s/', grep_open_files, desc = 'Search Open Files' },
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
  copilot = {
    { '<leader>cc', '<cmd>CopilotChatToggle<CR>', desc = 'Copilot Toggle Chat' },
    { '<leader>ce', '<cmd>CopilotChatExplain<CR>', desc = 'Copilot Explain' },
    { '<leader>cf', '<cmd>CopilotChatFix<CR>', desc = 'Copilot Fix' },
    { '<leader>cb', '<cmd>CopilotChat Brainstorm<CR>', desc = 'Copilot Brainstorm' },
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
    { '<leader>oo', '<cmd>Obsidian open<CR>', desc = 'Obsidian Open App' },
    { '<leader>oq', '<cmd>Obsidian quick_switch<CR>', desc = 'Obsidian Quick Switch' },
    { '<leader>os', '<cmd>Obsidian search<CR>', desc = 'Obsidian Search Notes' },
    { '<leader>oa', '<cmd>Obsidian dailies<CR>', desc = 'Obsidian Dailies' },
    { '<leader>on', '<cmd>Obsidian new<CR>', desc = 'Obsidian New Note' },
    { '<leader>oN', '<cmd>Obsidian new_from_template<CR>', desc = 'Obsidian New From Template' },
    { '<leader>od', '<cmd>Obsidian today<CR>', desc = 'Obsidian Daily Note' },
    { '<leader>oy', '<cmd>Obsidian yesterday<CR>', desc = 'Obsidian Yesterday' },
    { '<leader>ot', '<cmd>Obsidian tomorrow<CR>', desc = 'Obsidian Tomorrow' },
    { '<leader>ow', '<cmd>Obsidian workspace<CR>', desc = 'Obsidian Workspace' },
    { '<leader>ob', '<cmd>Obsidian backlinks<CR>', desc = 'Obsidian Backlinks' },
    { '<leader>ok', '<cmd>Obsidian links<CR>', desc = 'Obsidian Note Links' },
    { '<leader>ol', '<cmd>Obsidian link<CR>', mode = 'v', desc = 'Obsidian Link Selection' },
    { '<leader>oL', '<cmd>Obsidian link_new<CR>', mode = 'v', desc = 'Obsidian New Linked Note' },
    { '<leader>oe', '<cmd>Obsidian extract_note<CR>', mode = 'v', desc = 'Obsidian Extract Note' },
    { '<leader>or', '<cmd>Obsidian rename<CR>', desc = 'Obsidian Rename Note' },
    { '<leader>oR', '<cmd>Obsidian rename<CR>', desc = 'Obsidian Rename Note' },
    { '<leader>op', '<cmd>Obsidian paste_img<CR>', desc = 'Obsidian Paste Image' },
    { '<leader>of', '<cmd>Obsidian follow_link<CR>', desc = 'Obsidian Follow Link' },
    { '<leader>oT', '<cmd>Obsidian template<CR>', desc = 'Obsidian Insert Template' },
    { '<leader>oc', '<cmd>Obsidian toggle_checkbox<CR>', desc = 'Obsidian Toggle Checkbox' },
    { '<leader>og', '<cmd>Obsidian tags<CR>', desc = 'Obsidian Tags' },
    { '<leader>oC', '<cmd>Obsidian toc<CR>', desc = 'Obsidian Table Of Contents' },
    { '<leader>oh', '<cmd>Obsidian help<CR>', desc = 'Obsidian Help' },
  },
  project = {
    { '<leader>pp', '<cmd>NeovimProjectDiscover<CR>', desc = 'Project Discover' },
    { '<leader>ph', '<cmd>NeovimProjectHistory<CR>', desc = 'Project History' },
    { '<leader>pr', '<cmd>NeovimProjectLoadRecent<CR>', desc = 'Project Load Recent' },
    { '<leader>pl', '<cmd>NeovimProjectLoad<CR>', desc = 'Project Load' },
  },
}

return M
