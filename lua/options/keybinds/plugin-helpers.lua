-- Shared helpers for plugin-facing keymaps.
-- Centralizing these utilities keeps domain tables small and predictable.

local M = {}

function M.with_lsp(label, action)
  return function()
    if #vim.lsp.get_clients { bufnr = 0 } == 0 then
      vim.notify(('No active LSP for %s'):format(label:lower()), vim.log.levels.WARN)
      return
    end

    action()
  end
end

function M.toggle_inlay_hints()
  local bufnr = vim.api.nvim_get_current_buf()
  local core = require 'config.lsp'
  local method = vim.lsp.protocol.Methods.textDocument_inlayHint

  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    if core.client_supports_method(client, method, bufnr) then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
      return
    end
  end

  vim.notify('No active LSP with inlay hints for this buffer', vim.log.levels.WARN)
end

function M.format_buffer()
  require('conform').format { async = true, lsp_format = 'fallback' }
end

function M.set_buffer_keymaps(bufnr, mappings)
  for _, map in ipairs(mappings) do
    vim.keymap.set(map.mode or 'n', map[1], map[2], {
      buffer = bufnr,
      silent = true,
      expr = map.expr,
      desc = map.desc,
    })
  end
end

return M
