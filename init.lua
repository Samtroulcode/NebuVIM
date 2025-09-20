-- Loader Lua bytecode (Neovim >= 0.9) : accélère les require()
pcall(function()
  vim.loader.enable()
end)

--[[
=====================================
============= Leader ================
=====================================
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[
=====================================
=========  List of Require ==========
=====================================
--]]

require 'options.options' -- this is my options file with all nvim options
require 'options.nvim-keymaps' -- My BASIC keymapping such as split moving
require 'options.autocmd' -- My autocommands

--[[
=====================================
===== lazy.nvim plugin manager ======
=====================================
--]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--[[
======================================
========= List of Plugins ============
======================================
--]]

-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.project',
  require 'plugins.neo-tree',
  require 'plugins.which-key',
  require 'plugins.treesitter',
  require 'plugins.comment',
  require 'plugins.mini-nvim',
  require 'plugins.bufferline',
  require 'plugins.discord',
  require 'plugins.debug',
  require 'plugins.markdown',
  require 'plugins.lint',
  require 'plugins.gitsigns',
  require 'plugins.coloscheme',
  require 'plugins.autopairs',
  require 'plugins.indent_line',
  require 'plugins.notes',
  require 'plugins.dash',
  require 'plugins.biscuit',
  require 'plugins.lualine',
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
