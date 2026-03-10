local M = {}

M.server_names = {
  'lua_ls',
  'basedpyright',
  'ruff',
  'vtsls',
  'svelte',
  'eslint',
  'html',
  'cssls',
  'tailwindcss',
  'emmet_language_server',
  'jsonls',
  'yamlls',
  'hyprls',
}

M.mason_packages = {
  'basedpyright',
  'ruff',
  'stylua',
  'vtsls',
  'svelte-language-server',
  'eslint-lsp',
  'html-lsp',
  'css-lsp',
  'tailwindcss-language-server',
  'emmet-language-server',
  'json-lsp',
  'yaml-language-server',
  'prettierd',
  'eslint_d',
  'black',
  'isort',
  'debugpy',
}

function M.ensure_installed()
  return vim.deepcopy(M.mason_packages)
end

return M
