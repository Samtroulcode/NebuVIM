local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup('nebuvim-lsp-attach', { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(event)
      local keybinds = require 'options.keybinds'
      local core = require 'config.lsp'
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      keybinds.lsp_attach(event)

      if client and core.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_group = vim.api.nvim_create_augroup(('nebuvim-lsp-highlight-%d'):format(event.buf), { clear = true })

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
          buffer = event.buf,
          group = vim.api.nvim_create_augroup(('nebuvim-lsp-detach-%d'):format(event.buf), { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = highlight_group, buffer = event2.buf }
          end,
        })
      end

    end,
  })
end

return M
