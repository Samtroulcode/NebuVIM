return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { '<leader>e', ':Neotree toggle<CR>', desc = 'Explorer NeoTree (root dir)' },
    },
  },
}
