local M = {}

-- Mason package names only differ where explicitly mapped here.
M.mason_by_server = {
  basedpyright = 'basedpyright',
  ruff = 'ruff',
  vtsls = 'vtsls',
  svelte = 'svelte-language-server',
  eslint = 'eslint-lsp',
  html = 'html-lsp',
  cssls = 'css-lsp',
  tailwindcss = 'tailwindcss-language-server',
  emmet_language_server = 'emmet-language-server',
  jsonls = 'json-lsp',
  yamlls = 'yaml-language-server',
  lua_ls = 'lua-language-server',
  hyprls = 'hyprls',
}

M.extra_packages = {
  'stylua',
  'prettierd',
  'eslint_d',
  'black',
  'isort',
  'debugpy',
}

function M.ensure_installed(servers)
  local packages = {}

  for server_name in pairs(servers) do
    local package_name = M.mason_by_server[server_name]
    if package_name then
      table.insert(packages, package_name)
    end
  end

  vim.list_extend(packages, M.extra_packages)
  table.sort(packages)

  return packages
end

return M
