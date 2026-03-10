local M = {}

function M.opts()
  return {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == 'gdscript' then
        return nil
      end
      return { timeout_ms = 2000, lsp_format = 'fallback' }
    end,
    format_after_save = function(bufnr)
      if vim.bo[bufnr].filetype == 'gdscript' then
        return { lsp_format = 'never', timeout_ms = 3000 }
      end
    end,
    formatters = {
      ruff_fix = {
        command = 'ruff',
        args = { 'check', '--fix', '--exit-zero', '--stdin-filename', '$FILENAME', '-' },
        stdin = true,
      },
      gdformat = {
        command = 'gdformat',
        stdin = false,
        args = { '$FILENAME' },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black', 'ruff_fix' },
      javascript = { 'prettierd', 'eslint_d' },
      typescript = { 'prettierd', 'eslint_d' },
      javascriptreact = { 'prettierd', 'eslint_d' },
      typescriptreact = { 'prettierd', 'eslint_d' },
      svelte = { 'prettierd', 'eslint_d' },
      vue = { 'prettierd', 'eslint_d' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      scss = { 'prettierd' },
      json = { 'prettierd' },
      yaml = { 'prettierd' },
      rust = { 'rustfmt' },
      gdscript = { 'gdformat' },
    },
  }
end

return M
