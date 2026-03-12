-- NebuVim native autocommands.
-- These groups handle editor behavior that should exist before any plugin loads.

-- ╔══ Feedback ══╗
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('nebuvim-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- ╔══ Session Comfort ══╗
-- Restoring the cursor cuts friction when revisiting large notes or source files.
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore last cursor position',
  group = vim.api.nvim_create_augroup('last-cursor', { clear = true }),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Treat ephemeral helper windows like transient panels instead of normal buffers.
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close quickfix, help, man, etc. with q',
  group = vim.api.nvim_create_augroup('close-with-q', { clear = true }),
  pattern = { 'qf', 'help', 'man', 'lspinfo', 'startuptime', 'checkhealth' },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    require('options.keybinds').close_with_q(ev.buf)
  end,
})

-- Pick up external edits from git, formatters, or shell commands without manual reloads.
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  desc = 'Reload file if changed outside of Neovim',
  group = vim.api.nvim_create_augroup('auto-read', { clear = true }),
  command = 'checktime',
})

-- Keep diffs clean while restoring the viewport after the substitution.
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace on save',
  group = vim.api.nvim_create_augroup('trim-whitespace', { clear = true }),
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.winrestview(save)
  end,
})

-- Terminal buffers behave like terminal panes first, editable buffers second.
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Auto enter insert mode for terminals',
  group = vim.api.nvim_create_augroup('term-insert', { clear = true }),
  callback = function()
    vim.cmd 'startinsert'
    vim.bo.buflisted = false
  end,
})

-- ╔══ Writing Modes ══╗
-- Markdown and Obsidian buffers get a softer reading layout than code buffers.
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable markdown conceal for Obsidian UI',
  group = vim.api.nvim_create_augroup('markdown-conceal', { clear = true }),
  pattern = { 'markdown' },
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nc'
  end,
})

vim.api.nvim_create_autocmd('User', {
  desc = 'Apply comfort settings in Obsidian notes',
  group = vim.api.nvim_create_augroup('obsidian-comfort', { clear = true }),
  pattern = 'ObsidianNoteEnter',
  callback = function(ev)
    vim.bo[ev.buf].textwidth = 0
    vim.api.nvim_set_option_value('spelllang', 'en,fr', { buf = ev.buf })

    local wins = vim.fn.win_findbuf(ev.buf)
    for _, win in ipairs(wins) do
      vim.api.nvim_set_option_value('spell', true, { win = win })
      vim.api.nvim_set_option_value('wrap', true, { win = win })
      vim.api.nvim_set_option_value('linebreak', true, { win = win })
      vim.api.nvim_set_option_value('breakindent', true, { win = win })
      vim.api.nvim_set_option_value('conceallevel', 2, { win = win })
      vim.api.nvim_set_option_value('concealcursor', 'nc', { win = win })
    end
  end,
})
