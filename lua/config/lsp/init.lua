local M = {}

function M.get_capabilities()
  return require('blink.cmp').get_lsp_capabilities()
end

---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer
---@return boolean
function M.client_supports_method(client, method, bufnr)
  if vim.fn.has 'nvim-0.11' == 1 then
    return client:supports_method(method, bufnr)
  end

  return client.supports_method(method, { bufnr = bufnr })
end

return M
