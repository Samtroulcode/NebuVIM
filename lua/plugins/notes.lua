return {
  'zk-org/zk-nvim',
  main = 'zk',
  ft = 'markdown',
  dependencies = {
    'ibhagwan/fzf-lua',
    'folke/which-key.nvim',
  },
  opts = {
    picker = 'fzf_lua',
    lsp = {
      config = {
        cmd = { 'zk', 'lsp' },
        name = 'zk',
      },
      auto_attach = {
        enabled = true,
        filetypes = { 'markdown' },
      },
    },
  },
}
