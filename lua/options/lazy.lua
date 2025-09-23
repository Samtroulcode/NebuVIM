-- `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local M = {}

local function bootstrap()
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
end

function M.setup()
  bootstrap()
  require('lazy').setup {
    -- On charge automatiquement tous les specs de lua/plugins/*.lua
    { import = 'plugins' },
  }
end

return M
