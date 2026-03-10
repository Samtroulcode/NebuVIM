local M = {}

function M.setup(capabilities, servers)
  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = false,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
      end,
    },
  }
end

return M
