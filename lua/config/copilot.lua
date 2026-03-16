-- NebuVim Copilot helpers.
-- Keep completion toggling explicit so chat and inline suggestions stay independent.

local M = {}

local completion_enabled = true

local function copilot_is_loaded()
  return package.loaded.copilot ~= nil or vim.fn.exists(':Copilot') == 2
end

local function refresh_copilot_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == '' and vim.bo[bufnr].filetype ~= '' then
      vim.api.nvim_exec_autocmds('FileType', { buffer = bufnr, modeline = false })
      vim.api.nvim_exec_autocmds('BufEnter', { buffer = bufnr, modeline = false })
    end
  end
end

function M.toggle_completion()
  completion_enabled = not completion_enabled

  if completion_enabled and not copilot_is_loaded() then
    require('lazy').load { plugins = { 'copilot.vim' } }
    refresh_copilot_buffers()
  end

  if copilot_is_loaded() then
    if completion_enabled then
      vim.cmd 'Copilot enable'
      pcall(vim.cmd, 'Copilot restart')
    else
      vim.cmd 'Copilot disable'
    end
  end

  vim.notify(
    completion_enabled and 'Copilot completion enabled' or 'Copilot completion disabled',
    vim.log.levels.INFO
  )
end

return M
