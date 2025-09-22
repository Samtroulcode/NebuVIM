return {
  'zk-org/zk-nvim',
  main = 'zk',
  ft = 'markdown',
  cmd = {
    'ZkNew',
    'ZkNotes',
    'ZkTags',
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
