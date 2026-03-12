-- Note-taking keymaps exposed to plugin specs.
-- Notes stay under a single namespace so Obsidian actions remain cohesive.

local plugin_helpers = require 'options.keybinds.plugin-helpers'

local obsidian_note_keys = {
  { '<CR>', function() return require('obsidian.api').smart_action() end, expr = true, desc = 'Obsidian Smart Action' },
  { ']o', function() require('obsidian.api').nav_link 'next' end, desc = 'Obsidian Next Link' },
  { '[o', function() require('obsidian.api').nav_link 'prev' end, desc = 'Obsidian Prev Link' },
}

return {
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
    { '<leader>nR', '<cmd>Obsidian rename<CR>', desc = 'Obsidian Rename Note [alias]' },
    { '<leader>np', '<cmd>Obsidian paste_img<CR>', desc = 'Obsidian Paste Image' },
    { '<leader>nf', '<cmd>Obsidian follow_link<CR>', desc = 'Obsidian Follow Link' },
    { '<leader>nT', '<cmd>Obsidian template<CR>', desc = 'Obsidian Insert Template' },
    { '<leader>nc', '<cmd>Obsidian toggle_checkbox<CR>', desc = 'Obsidian Toggle Checkbox' },
    { '<leader>ng', '<cmd>Obsidian tags<CR>', desc = 'Obsidian Tags' },
    { '<leader>nC', '<cmd>Obsidian toc<CR>', desc = 'Obsidian Table Of Contents' },
    { '<leader>nh', '<cmd>Obsidian help<CR>', desc = 'Obsidian Help' },
  },
  obsidian_note_attach = function(bufnr)
    plugin_helpers.set_buffer_keymaps(bufnr, obsidian_note_keys)
  end,
}
