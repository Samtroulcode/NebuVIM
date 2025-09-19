-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      filtered_items = { hide_dotfiles = false, hide_gitignored = true },
    },
    window = {
      width = 32,
    },
    default_component_configs = {
      indent = { with_markers = true, padding = 1 },
      git_status = {
        symbols = { unstaged = '', staged = '', untracked = '', renamed = '', deleted = '' },
      },
      diagnostics = { -- ← badges LSP dans l’arbre
        symbols = { hint = ' ', info = ' ', warn = ' ', error = ' ' },
        highlights = {
          hint = 'DiagnosticHint',
          info = 'DiagnosticInfo',
          warn = 'DiagnosticWarn',
          error = 'DiagnosticError',
        },
      },
    },
  },
}
