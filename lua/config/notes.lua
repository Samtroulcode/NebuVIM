local M = {}
local zk_cmd = require 'zk.commands'

-- Pointe vers ton notebook (exporte ZK_NOTEBOOK_DIR pour du béton)
local function nb()
  return vim.env.ZK_NOTEBOOK_DIR or vim.fn.getcwd()
end

-- ==== Création ====
function M.new_note()
  local title = vim.fn.input 'Titre: '
  if not title or title == '' then
    return
  end
  zk_cmd.get 'ZkNew' {
    title = title,
    notebook_path = nb(),
  }
end

function M.new_daily()
  zk_cmd.get 'ZkNew' {
    dir = 'journal/daily',
    group = 'daily',
    notebook_path = nb(),
  }
end

function M.new_rust()
  local title = vim.fn.input 'Titre (rust): '
  if not title or title == '' then
    return
  end
  zk_cmd.get 'ZkNew' {
    title = title,
    dir = 'rust',
    group = 'rust', -- utilisera filename/template de [group.rust]
    notebook_path = nb(),
  }
end

function M.new_lua()
  local title = vim.fn.input 'Titre (lua): '
  if not title or title == '' then
    return
  end
  zk_cmd.get 'ZkNew' {
    title = title,
    dir = 'lua',
    group = 'lua', -- utilisera filename/template de [group.lua]
    notebook_path = nb(),
  }
end

-- ==== Navigation / recherche (portée = tout le notebook) ====
function M.browse()
  zk_cmd.get 'ZkNotes' {
    notebook_path = nb(),
    sort = { 'modified' },
    reverse = true,
  }
end

function M.browse_rust()
  zk_cmd.get 'ZkNotes' {
    notebook_path = nb(),
    hrefs = { 'rust' }, -- restreint au dossier rust/
    sort = { 'modified' },
    reverse = true,
  }
end

function M.browse_lua()
  zk_cmd.get 'ZkNotes' {
    notebook_path = nb(),
    hrefs = { 'lua' }, -- restreint au dossier lua/
    sort = { 'modified' },
    reverse = true,
  }
end

function M.recents()
  zk_cmd.get 'ZkNotes' {
    notebook_path = nb(),
    createdAfter = 'last two weeks',
    sort = { 'created' },
    reverse = true,
    select = { 'title', 'path', 'modified' },
  }
end

function M.tags()
  zk_cmd.get 'ZkTags' { notebook_path = nb() }
end

function M.backlinks()
  zk_cmd.get 'ZkBacklinks' { notebook_path = nb() }
end

function M.links()
  zk_cmd.get 'ZkLinks' { notebook_path = nb() }
end

function M.grep()
  local q = vim.fn.input 'Rechercher (notes): '
  if q and q ~= '' then
    zk_cmd.get 'ZkNotes' {
      notebook_path = nb(),
      match = { q },
      sort = { 'modified' },
      reverse = true,
    }
  end
end

-- ==== Insertion de lien ====
function M.insert_link_cursor()
  zk_cmd.get 'ZkInsertLink' { notebook_path = nb() }
end
function M.insert_link_visual()
  zk_cmd.get 'ZkInsertLink' { content = 'selection', notebook_path = nb() }
end

-- ==== Keymaps ====
vim.keymap.set('n', '<leader>zn', M.new_note, { desc = '[Z]k [N]ew' })
vim.keymap.set('n', '<leader>zd', M.new_daily, { desc = '[Z]k [D]aily' })
vim.keymap.set('n', '<leader>zs', M.browse, { desc = '[Z]k [S]earch' })
vim.keymap.set('n', '<leader>zr', M.recents, { desc = '[Z]k [R]ecents' })
vim.keymap.set('n', '<leader>zt', M.tags, { desc = '[Z]k [T]ags' })
vim.keymap.set('n', '<leader>zl', M.links, { desc = '[Z]k [L]inks' })
vim.keymap.set('n', '<leader>zL', M.backlinks, { desc = '[Z]k [L]inks (backlinks)' })
vim.keymap.set('n', '<leader>zg', M.grep, { desc = '[Z]k [G]rep' })
vim.keymap.set('n', '<leader>zR', M.new_rust, { desc = '[Z]k new [R]ust' })
vim.keymap.set('n', '<leader>zL', M.new_lua, { desc = '[Z]k new [L]ua' })

return M
