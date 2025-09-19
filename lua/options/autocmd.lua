-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Revenir à la dernière position du curseur quand on ouvre un fichier
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

-- Fermer automatiquement certaines fenêtres avec q
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close quickfix, help, man, etc. with q',
  group = vim.api.nvim_create_augroup('close-with-q', { clear = true }),
  pattern = { 'qf', 'help', 'man', 'lspinfo', 'startuptime', 'checkhealth' },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = ev.buf, silent = true })
  end,
})

-- Recharger automatiquement le fichier si modifié à l’extérieur
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  desc = 'Reload file if changed outside of Neovim',
  group = vim.api.nvim_create_augroup('auto-read', { clear = true }),
  command = 'checktime',
})

-- Supprimer les espaces en fin de ligne à la sauvegarde
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace on save',
  group = vim.api.nvim_create_augroup('trim-whitespace', { clear = true }),
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.winrestview(save)
  end,
})

-- Quand on ouvre un terminal, lancer en mode insert
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Auto enter insert mode for terminals',
  group = vim.api.nvim_create_augroup('term-insert', { clear = true }),
  callback = function()
    vim.cmd 'startinsert'
    -- pas listé dans :ls
    vim.bo.buflisted = false
  end,
})
