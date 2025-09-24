local M = {}
local zk_cmd = require 'zk.commands'

-- ==== Actions génériques ====
function M.new_note()
  local title = vim.fn.input 'Titre: '
  if not title or title == '' then
    return
  end
  zk_cmd.get 'ZkNew' { title = title }
end

function M.new_daily()
  -- respecte ton group "daily" -> journal/daily + template daily.md
  zk_cmd.get 'ZkNew' { dir = 'journal/daily', group = 'daily' }
end

function M.browse()
  zk_cmd.get 'ZkNotes' {
    sort = { 'modified' }, -- champ de tri
    reverse = true, -- ordre décroissant (nouveau → ancien)
  }
end

function M.recents()
  zk_cmd.get 'ZkNotes' {
    createdAfter = 'last two weeks',
    sort = { 'created' },
    reverse = true, -- on veut les plus récentes d’abord
    select = { 'title', 'path', 'modified' },
  }
end

function M.tags()
  zk_cmd.get 'ZkTags' {}
end

function M.backlinks()
  zk_cmd.get 'ZkBacklinks' {}
end

function M.links()
  zk_cmd.get 'ZkLinks' {}
end

function M.grep()
  local q = vim.fn.input 'Rechercher (notes): '
  if q and q ~= '' then
    zk_cmd.get 'ZkNotes' {
      match = q,
      sort = { 'modified' },
      reverse = true,
    }
  end
end

-- ==== Insertion de lien ====
function M.insert_link_cursor()
  zk_cmd.get 'ZkInsertLink' {}
end

function M.insert_link_visual()
  zk_cmd.get 'ZkInsertLink' { content = 'selection' }
end

-- ==== Keymaps ====
vim.keymap.set('n', '<leader>zn', M.new_note, { desc = '[Z]k [N]ew' })
vim.keymap.set('n', '<leader>zd', M.new_daily, { desc = '[Z]k [D]aily' })
vim.keymap.set('n', '<leader>zb', M.browse, { desc = '[Z]k [B]rowse' })
vim.keymap.set('n', '<leader>zr', M.recents, { desc = '[Z]k [R]ecents' })
vim.keymap.set('n', '<leader>zt', M.tags, { desc = '[Z]k [T]ags' })
vim.keymap.set('n', '<leader>zl', M.links, { desc = '[Z]k [L]inks' })
vim.keymap.set('n', '<leader>zL', M.backlinks, { desc = '[Z]k [L]inks (backlinks)' })
vim.keymap.set('n', '<leader>zg', M.grep, { desc = '[Z]k [G]rep' })
vim.keymap.set('n', '<leader>zi', M.insert_link_cursor, { desc = '[Z]k [I]nsert link' })
vim.keymap.set('x', '<leader>zi', M.insert_link_visual, { desc = '[Z]k [I]nsert link (visual)' })

return M
