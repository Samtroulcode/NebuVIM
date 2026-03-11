-- LSP-local NebuVim keymaps.
-- Mappings are attached per buffer to keep LSP features contextual.

local helpers = require 'options.keybinds.helpers'

local M = {}

function M.attach(event)
  local bufnr = event.buf
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if not client then
    return
  end

  local core = require 'config.lsp'

  helpers.buf_map(bufnr, 'n', 'grn', vim.lsp.buf.rename, 'LSP Rename')
  helpers.buf_map(bufnr, { 'n', 'x' }, 'gra', vim.lsp.buf.code_action, 'LSP Code Action')
  helpers.buf_map(bufnr, 'n', 'grr', function() Snacks.picker.lsp_references() end, 'LSP References')
  helpers.buf_map(bufnr, 'n', 'gri', function() Snacks.picker.lsp_implementations() end, 'LSP Implementations')
  helpers.buf_map(bufnr, 'n', 'grd', function() Snacks.picker.lsp_definitions() end, 'LSP Definitions')
  helpers.buf_map(bufnr, 'n', 'grD', vim.lsp.buf.declaration, 'LSP Declaration')
  helpers.buf_map(bufnr, 'n', 'grt', function() Snacks.picker.lsp_type_definitions() end, 'LSP Type Definitions')
  helpers.buf_map(bufnr, 'n', 'gO', function() Snacks.picker.lsp_symbols() end, 'LSP Document Symbols')
  helpers.buf_map(bufnr, 'n', 'gW', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')
  helpers.buf_map(bufnr, 'n', 'K', vim.lsp.buf.hover, 'LSP Hover')

  if core.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
    helpers.buf_map(bufnr, 'n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, 'Toggle Inlay Hints')
  end
end

return M
