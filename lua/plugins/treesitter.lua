-- NebuVim Treesitter setup.
-- Parser coverage follows the languages and markup formats used across NebuVim workflows.

return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    main = 'nvim-treesitter',
    opts = {
      -- ╔══ Parser Coverage ══╗
      ensure_installed = {
        -- core
        'lua',
        'luadoc',
        'vim',
        'vimdoc',
        'query',
        'bash',
        'regex',
        'printf',
        'c',
        'cpp',
        'diff',
        'norg',
        -- docs / prose
        'markdown',
        'markdown_inline',
        'latex',
        'typst',
        'bibtex',
        'mermaid',
        -- web
        'html',
        'html_tags',
        'javascript',
        'typescript',
        'tsx',
        'vue',
        'svelte',
        'astro',
        'json',
        'json5',
        'css',
        'scss',
        'graphql',
        'yaml',
        'xml',
        'dtd',
        -- systems / devops
        'dockerfile',
        'nix',
        'toml',
        'sql',
        'kdl',
        -- languages
        'python',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'java',
        'kotlin',
        'swift',
        'zig',
        'rust',
        -- misc
        'csv',
        'gitignore',
        -- Hyprland support
        'hyprlang',
        -- Godot
        'gdscript',
        'godot_resource',
        'gdshader',
      },
      -- Auto-install keeps ad-hoc filetypes usable without manual parser management.
      auto_install = true,
      highlight = {
        enable = true,
        -- Ruby still benefits from Vim regex highlighting for a few edge-case indent rules.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby', 'gdshader', 'gdscript' } },
    },
  },
  -- Hyprland uses an external grammar, so it stays as a dedicated companion spec.
  {
    'tree-sitter-grammars/tree-sitter-hyprlang',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'hyprlang' },
    config = function() end,
  },
}
