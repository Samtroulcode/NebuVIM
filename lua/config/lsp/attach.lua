local core = require 'config.lsp'

local M = {}

function M.setup()
  local fzf = require 'fzf-lua'
  local group = vim.api.nvim_create_augroup('nebuvim-lsp-attach', { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(event)
      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grr', fzf.lsp_references, '[G]oto [R]eferences')
      map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
      map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
      map('gW', function()
        if fzf.lsp_live_workspace_symbols then
          fzf.lsp_live_workspace_symbols()
        else
          fzf.lsp_workspace_symbols()
        end
      end, 'Open Workspace Symbols')
      map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      if core.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_group = vim.api.nvim_create_augroup('nebuvim-lsp-highlight', { clear = false })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('nebuvim-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'nebuvim-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if core.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })
end

return M
