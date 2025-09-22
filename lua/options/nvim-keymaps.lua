-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal mode (exit + nav)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]])

-- Faster window resizing
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })

-- Buffers
--
-- Buffers moving logic same as tabs (gt, gT, ngt when n is a number for tabs: gb, gB, ngb for buffers)
vim.keymap.set('n', '<leader>bd', ':bd!<cr>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bo', ':%bd|e#|bd#<cr>', { desc = '[B]uffer delete [O]thers' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', 'gB', ':bprevious<cr>', { desc = '[G]oto previous [B]uffer' })

-- ngb - go to buffer number n, where n is a count given before the command.
-- I doing this because I use gt/gT/ngt to navigate tabs and want similar for buffers.
-- but the number of buffers shown in luatab is not the same as buffer number (bufnr) in vim
local function goto_buffer_index(n)
  local info = vim.fn.getbufinfo { buflisted = 1 } -- only listed buffers
  table.sort(info, function(a, b)
    return a.bufnr < b.bufnr -- sort by buffer number
  end)
  if n >= 1 and n <= #info then
    vim.cmd('buffer ' .. info[n].bufnr) -- go to buffer n
  else
    vim.notify(('No index %d buffer'):format(n, #info), vim.log.levels.WARN)
  end
end

vim.keymap.set('n', 'gb', function()
  local n = vim.v.count
  if n > 0 then
    goto_buffer_index(n)
  else
    vim.cmd 'bnext'
  end
end, { desc = '[G]oto next [b]uffer' })

-- Toggle spell checking
vim.keymap.set('n', '<leader>ts', function()
  vim.opt.spell = not vim.opt.spell:get()
  if vim.opt.spell:get() then
    vim.notify('Spellcheck ON (' .. table.concat(vim.opt.spelllang:get(), ',') .. ')', vim.log.levels.INFO)
  else
    vim.notify('Spellcheck OFF', vim.log.levels.INFO)
  end
end, { desc = '[T]oggle [S]pell checker' })
