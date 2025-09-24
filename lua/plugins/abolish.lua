-- Plugin to make a variant of a word/selection
-- https://github.com/tpope/vim-abolish
return {
  'tpope/vim-abolish',
  event = 'VeryLazy',
  require('which-key').register {
    ['cr'] = {
      c = 'camelCase',
      m = 'PascalCase (Mixed)',
      s = 'snake_case',
      u = 'UPPER_CASE',
      ['-'] = 'kebab-case',
      ['.'] = 'dot.case',
    },
  },
}
