-- NebuVim Obsidian integration.
-- Notes stay under `<leader>n`, with note-local motions registered on buffer enter.

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = {
    'Obsidian',
  },
  keys = require('options.keybinds').keys.obsidian,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'personal',
        path = '~/Storage/SDA/Documents/Notes',
      },
    },
    notes_subdir = '_scratchpad',
    new_notes_location = 'notes_subdir',
    daily_notes = {
      folder = 'journal/daily',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'daily-note' },
      template = 'daily.md',
    },
    templates = {
      folder = 'templates',
      date_format = '%Y%m%d%H%M',
      time_format = '%H:%M',
    },
    picker = {
      name = 'snacks.pick',
      note_mappings = {
        new = '<C-x>',
        insert_link = '<C-l>',
      },
      tag_mappings = {
        tag_note = '<C-x>',
        insert_tag = '<C-l>',
      },
    },
    link = {
      style = 'wiki',
      format = 'shortest',
    },
    completion = {
      blink = true,
      nvim_cmp = false,
      min_chars = 2,
      create_new = true,
    },
    open = {
      use_advanced_uri = true,
    },
    frontmatter = {
      enabled = false,
    },
    callbacks = {
      enter_note = function()
        require('options.keybinds').keys.obsidian_note_attach(vim.api.nvim_get_current_buf())
      end,
    },
    note_id_func = function(title)
      local suffix = ''

      if title and title ~= '' then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        suffix = tostring(os.time())
      end

      return suffix
    end,
    attachments = {
      folder = '_img',
      img_name_func = function()
        return string.format('%s-', os.time())
      end,
    },
  },
}
