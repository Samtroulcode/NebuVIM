local M = {}

local header = [[
███╗   ██╗███████╗██████╗ ██╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔══██╗██║   ██║██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██████╔╝██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██╔══██╗██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗██████╔╝╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝╚═════╝  ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

local function set_hl()
  vim.api.nvim_set_hl(0, 'NebuDashboardTitle', { fg = '#cba6f7', bold = true })
  vim.api.nvim_set_hl(0, 'NebuDashboardAccent', { fg = '#89b4fa', bold = true })
  vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = '#f9e2af', bold = true })
end

local function files_action()
  Snacks.picker.files()
end

local function grep_action()
  Snacks.picker.grep()
end

local function dotfiles_action()
  Snacks.picker.files { cwd = vim.fn.expand '~/dotfiles' }
end

local function config_action()
  Snacks.picker.files {
    cwd = vim.fn.stdpath 'config',
    hidden = true,
    ignored = false,
  }
end

local function quit_action()
  vim.cmd.qa()
end

function M.init()
  set_hl()
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('nebuvim-snacks-dashboard-hl', { clear = true }),
    callback = set_hl,
  })
end

function M.opts()
  return {
    enabled = true,
    width = 58,
    preset = {
      header = header,
    },
    sections = {
      {
        section = 'header',
        align = 'center',
        padding = 1,
      },
      {
        title = 'Explorer',
        icon = ' ',
        text = {
          { '  Explorer', hl = 'NebuDashboardTitle' },
        },
        align = 'center',
        padding = 1,
      },
      { icon = ' ', key = 'f', desc = 'Files', action = files_action },
      { icon = ' ', key = 'g', desc = 'Grep', action = grep_action },
      { icon = ' ', key = 'p', desc = 'Projects', action = ':NeovimProjectDiscover history' },

      {
        title = 'Notes',
        icon = '󰠮 ',
        text = {
          { '󰠮  Notes', hl = 'NebuDashboardTitle' },
        },
        align = 'center',
        padding = 1,
      },
      { icon = '󰃰 ', key = 'j', desc = 'Daily note', action = ':Obsidian today' },
      { icon = ' ', key = 'n', desc = 'New note', action = ':Obsidian new' },
      { icon = '󰍉 ', key = 's', desc = 'Search notes', action = ':Obsidian quick_switch' },

      {
        title = 'Config',
        icon = ' ',
        text = {
          { '  Config', hl = 'NebuDashboardTitle' },
        },
        align = 'center',
        padding = 1,
      },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
      { icon = '󱁤 ', key = 'm', desc = 'Mason', action = ':Mason' },
      { icon = ' ', key = 'h', desc = 'Health', action = ':checkhealth' },
      { icon = ' ', key = 'd', desc = 'Dotfiles', action = dotfiles_action },
      { icon = ' ', key = 'c', desc = 'Config', action = config_action },
      { icon = '󰑓 ', key = 'r', desc = 'Load last session', action = ':NeovimProjectLoadRecent' },
      { icon = '󰗼 ', key = 'q', desc = 'Quit', action = quit_action },

      {
        icon = ' ',
        title = 'Recent Files',
        section = 'recent_files',
        limit = 5,
        indent = 2,
        padding = { 2, 2 },
      },
      {
        section = 'startup',
        align = 'center',
        padding = 1,
      },
    },
  }
end

return M
